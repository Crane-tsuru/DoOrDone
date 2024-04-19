//
//  ColorSettingsView.swift
//  DoOrDone
//
//  Created by 鶴見駿 on 2024/04/18.
//

import SwiftUI

struct HeadsColorView: View {
    @EnvironmentObject var coinColor: CoinColor
    
    let isHead: Bool
    @State var myColor: Color
    
    var body: some View {
        VStack {
            Circle()
                .foregroundColor(isHead ?  coinColor.headColor : coinColor.tailColor)
                .frame(width: 100, height: 100)
            
            ColorPicker("表の色", selection: isHead ? $coinColor.headColor : $coinColor.tailColor)
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Spacer()
        }
    }
}

#Preview {
    HeadsColorView(isHead: true, myColor: Color.green) .environmentObject(CoinColor())
}
