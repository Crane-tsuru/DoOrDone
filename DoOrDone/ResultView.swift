//
//  ResultView.swift
//  DoOrDone
//
//  Created by 鶴見駿 on 2024/04/13.
//

import SwiftUI

struct ResultView: View {
    @State var isHomeScreen = false
    @State var again = false
    
    @ObservedObject var coinTossData: CoinTossData
    
    var body: some View {
        VStack {
            Spacer()
            
            Label(coinTossData.result, systemImage: (coinTossData.result == resultWord[0]) ? "sparkles" : "exclamationmark.triangle")
                .foregroundColor(.orange)
                .font(.largeTitle)
                .padding()
                
            Spacer()
                
            Button(action: { isHomeScreen = true}) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.blue.gradient)
                    .frame(width: 200, height: 150)
                    .overlay(Text("ホームに戻る").font(.title))
                    .foregroundColor(.white)
            }.padding()
                
            Button(action: { again = true}) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.pink.gradient)
                    .frame(width: 200, height: 150)
                    .overlay(Text("振り直す").font(.title))
                    .foregroundColor(.white)
            }.padding()
                
            Spacer()
        }
        .fullScreenCover(isPresented: $isHomeScreen) {
            ContentView()
        }
        .fullScreenCover(isPresented: $again) {
            SelectCoinView()
        }
    }
}

//#Preview {
//    ResultView(result: "アタリ")
//}
