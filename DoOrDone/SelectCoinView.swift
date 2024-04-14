//
//  SelectCoinView.swift
//  DoOrDone
//
//  Created by 鶴見駿 on 2024/04/13.
//

import SwiftUI

struct SelectCoinView: View {
    @State var isfullCover = false
    @ObservedObject var coinTossData = CoinTossData()
    
    var body: some View {
        VStack {
            Spacer()
            
            Button(action: {
                isfullCover = true
            }) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.orange.gradient)
                    .frame(width: 200, height: 150)
                    .overlay(Text(judgeMember[0]).font(.title))
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
                    .fill(.green.gradient)
                    .frame(width: 200, height:  150)
                    .overlay(Text(judgeMember[1]).font(.title).foregroundColor(.white))
            }
                
            Spacer()
        }.fullScreenCover(isPresented: $isfullCover) {
            CoinFlippingView(coinTossData: coinTossData)
        }
    }
}

#Preview {
    SelectCoinView()
}
