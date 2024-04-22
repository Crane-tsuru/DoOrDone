//
//  Coin.swift
//  DoOrDone
//
//  Created by 鶴見駿 on 2024/04/13.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

// Coin View
struct Coin: View {
    @Binding var isFlipping: Bool
    @Binding var isHeads: Bool
    
    @EnvironmentObject var coinColor: CoinColor
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 5)
                .foregroundColor(isHeads ? .gray : .black)
                .frame(width: 95, height: 95)
            
            Circle()
                .foregroundColor(isHeads ? coinColor.headsColor : coinColor.tailsColor)
                .frame(width: 90, height: 90)
                .zIndex(1.0)
        }
    }
}
