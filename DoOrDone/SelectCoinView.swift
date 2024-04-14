//
//  SelectCoinView.swift
//  DoOrDone
//
//  Created by 鶴見駿 on 2024/04/13.
//

import SwiftUI

struct SelectCoinView: View {
    @State var isfullCover = false
    @State var prediction = ""
    
    var body: some View {
        VStack {
            Spacer()
            
            Button(action: {
                Task {
                    await prediction = Predict(prediction: judgeMember[0])
                }
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
                    await prediction = Predict(prediction: judgeMember[1])
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
            if !prediction.isEmpty {
                CoinFlippingView(CoinTossData: CoinTossData(prediction: prediction))
            }
        }
    }
}

#Preview {
    SelectCoinView()
}
