//
//  SelectCoinView.swift
//  DoOrDone
//
//  Created by 鶴見駿 on 2024/04/13.
//

import SwiftUI

struct PredictCoinView: View {
    @State var isfullCover = false
    @ObservedObject var coinTossData = CoinTossData()
    
    @EnvironmentObject var coinColor: CoinColor
    
    var body: some View {
        VStack {
            Spacer()
            
            Button(action: {
                isfullCover = true
            }) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(coinColor.headsColor.gradient)
                    .frame(width: 200, height: 150)
                    .overlay(Text(judgeMember[0] + "\nやりたい").font(.title))
                    .foregroundColor(.white)
            }
        
            Spacer()
            
            Button(action: {
                Task {
                    coinTossData.prediction.toggle()
                }
                isfullCover = true
            }) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(coinColor.tailsColor.gradient)
                    .frame(width: 200, height:  150)
                    .overlay(Text(judgeMember[1] + "\nやりたくない").font(.title).foregroundColor(.white))
            }
                
            Spacer()
        }.fullScreenCover(isPresented: $isfullCover) {
            CoinFlippingView(coinTossData: coinTossData).environmentObject(coinColor)
        }
    }
}

#Preview {
    PredictCoinView().environmentObject(CoinColor())
}
