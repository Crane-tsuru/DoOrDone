//
//  SelectCoinView.swift
//  DoOrDone
//
//  Created by 鶴見駿 on 2024/04/13.
//

import SwiftUI

struct SelectCoinView: View {
    @State var isfullCover = false
    
    var body: some View {
        VStack {
            Spacer()
            
            Button(action: { isfullCover = true }) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.orange.gradient)
                    .frame(width: 200, height: 150)
                    .overlay(Text("表").font(.title))
                    .foregroundColor(.white)
            }
        
            Spacer()
            
            Button(action: { isfullCover = true }) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.green.gradient)
                    .frame(width: 200, height:  150)
                    .overlay(Text("裏").font(.title).foregroundColor(.white))
            }
                
            Spacer()
        }.fullScreenCover(isPresented: $isfullCover) {
            CoinFlippingView()
        }
    }
}

#Preview {
    SelectCoinView()
}
