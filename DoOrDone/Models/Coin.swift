//
//  Coin.swift
//  DoOrDone
//
//  Created by 鶴見駿 on 2024/04/13.
//

import SwiftUI

struct Coin: View {
    @Binding var isFlipping: Bool
    @Binding var isHeads: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(isHeads ? .gray : .orange)
                .frame(width: 100, height: 100)
            
            Circle()
                .foregroundColor(isHeads ? .green: .yellow)
                .frame(width: 90, height: 90)
        }
    }
}

class CoinColor: ObservableObject {
    @Published var headColor = Color.green
    @Published var tailColor = Color.orange
    
    func saveColor(isHead: Bool, color: Color) {
        if isHead {
            
        }
    }
}
