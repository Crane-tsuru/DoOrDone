//
//  CoinFlipping.swift
//  DoOrDone
//
//  Created by 鶴見駿 on 2024/04/13.
//

import SwiftUI

struct CoinFlippingView: View {
    @State var isFlipping = false
    @State var isHeads = false
    @State var degreesToFlip: Int = 0
    @State var tailsCount: Int = 0
    @State var headsCount: Int = 0
    
    @ObservedObject var CoinTossData: CoinTossData
    
    var body: some View {
        VStack {
            VStack {
                Text("Heads: \(headsCount)")
                Text("Tails: \(tailsCount)")
            }
            
            Spacer()
            Coin(isFlipping: $isFlipping, isHeads: $isHeads)
                .rotation3DEffect(
                    Angle(degrees: Double(degreesToFlip)),
                    axis: (x: CGFloat(0), y: CGFloat(10), z:CGFloat(0))
                )
            Spacer()
            Button("Flip Coin") {
                Task {
                    await flipCoin()
                }
            }
        }.onAppear {
            Task {
                await flipCoin()
            }
        }
        .fullScreenCover(isPresented: $isFlipping) {
            ResultView(result: .constant("あたり"))
        }
    }
    
    func flipCoin() async {
        withAnimation {
            let randomNumber = Int.random(in: 5...6)
            if degreesToFlip > 1800000000 {
                reset()
            }
            degreesToFlip = degreesToFlip + (randomNumber * 180)
            headsOrTails()
        }
        
        try? await Task.sleep(nanoseconds: 2 * 1000 * 1000 * 1000)
        isFlipping.toggle()
    }
    
    func headsOrTails() {
        let divisible = degreesToFlip / 180
        (divisible % 2) == 0 ? (isHeads = false) : (isHeads = true)
        isHeads == true ? (headsCount += 1 ) : (tailsCount += 1)
    }
    
    func reset() {
        degreesToFlip = 0
    }
}

#Preview {
    CoinFlippingView(CoinTossData: CoinTossData(prediction: judgeMember[0]))
}
