//
//  ResultView.swift
//  DoOrDone
//
//  Created by 鶴見駿 on 2024/04/13.
//

import SwiftUI
import FirebaseAuth

struct ResultView: View {
    @State var isHomeScreen = false
    @State var again = false
    
    @ObservedObject var coinTossData: CoinTossData
    
    @EnvironmentObject var coinColor: CoinColor
    
    var body: some View {
        VStack {
            Spacer()
            
            Label(((coinTossData.result == resultWord[0]) ? message[coinTossData.prediction]?[0] : message[coinTossData.prediction]?[1]) ?? "エラー",
                  systemImage: (coinTossData.result == resultWord[0]) ? "sparkles" : "exclamationmark.triangle")
                .foregroundColor(.orange)
                .font(.largeTitle)
                .padding()
                
            Spacer()
                
            Button(action: {
                Task {
                    if let user = Auth.auth().currentUser {
                        async let DBdata = coinTossData.translateDataToDB()
                        await DBdata.save(userID: String(user.uid))
                    }
                    isHomeScreen.toggle()
                }
                
            }) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.blue.gradient)
                    .frame(width: 200, height: 150)
                    .overlay(Text("ホームに戻る").font(.title))
                    .foregroundColor(.white)
            }.padding()
                
            Button(action: {
                coinTossData.resetCount += 1
                again = true
            }) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.pink.gradient)
                    .frame(width: 200, height: 150)
                    .overlay(Text("振り直す").font(.title))
                    .foregroundColor(.white)
            }.padding()
                
            Spacer()
        }
        .fullScreenCover(isPresented: $isHomeScreen) {
            EntryView()
                .environmentObject(coinColor)
        }
        .fullScreenCover(isPresented: $again) {
            CoinFlippingView(coinTossData: coinTossData)
                .environmentObject(coinColor)
        }
    }
}

//#Preview {
//    ResultView(result: "アタリ")
//}
