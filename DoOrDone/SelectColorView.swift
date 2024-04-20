//
//  ColorSettingsView.swift
//  DoOrDone
//
//  Created by 鶴見駿 on 2024/04/18.
//

import SwiftUI

struct SelectColorView: View {
    @EnvironmentObject var coinColor: CoinColor
    
    let isHead: Bool
    @State var myColor: Color
    
    var body: some View {
        VStack {
            Circle()
                .foregroundColor(myColor)
                .frame(width: 100, height: 100)
            
            Spacer()
            
            ColorPicker("表の色", selection: $myColor)
                .padding()
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            Button(action: {
                
            }) {
                Text("保存")
            }.padding()
            
            Spacer()
        }
    }
}

#Preview {
    SelectColorView(isHead: true, myColor: Color.green) .environmentObject(CoinColor())
}
