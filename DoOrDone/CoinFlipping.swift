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
    
    @ObservedObject var CoinTossData: CoinTossData
    
    var body: some View {
        VStack {
            VStack {
                if !CoinTossData.result.isEmpty {
                    Label(CoinTossData.result, systemImage: isHeads ? "sparkles" : "exclamationmark.triangle")
                }
            }
            
            Spacer()
            Coin(isFlipping: $isFlipping, isHeads: $isHeads)
                .rotation3DEffect(
                    Angle(degrees: Double(degreesToFlip)),
                    axis: (x: CGFloat(0), y: CGFloat(10), z:CGFloat(0))
                )
            Spacer()
        }.onAppear {
            Task {
                await flipCoin()
            }
            
            if isHeads == true {
                CoinTossData.result = "アタリ!"
            } else {
                CoinTossData.result = "ハズレ"
            }
        }
        .fullScreenCover(isPresented: $isFlipping) {
            ResultView(result: CoinTossData.result)
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
        if CoinTossData.prediction == judgeMember[0] {
            (divisible % 2) == 0 ? (isHeads = false) : (isHeads = true)
        } else {
            (divisible % 2) == 1 ? (isHeads = false) : (isHeads = true)
        }
    }
    
    func reset() {
        degreesToFlip = 0
    }
}

//#Preview {
//    CoinFlippingView(CoinTossData: CoinTossData(prediction: judgeMember[0]))
//}
