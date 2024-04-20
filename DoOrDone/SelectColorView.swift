//
//  ColorSettingsView.swift
//  DoOrDone
//
//  Created by 鶴見駿 on 2024/04/18.
//

import SwiftUI
import FirebaseAuth

struct SelectColorView: View {
    @EnvironmentObject var coinColor: CoinColor
    
    let isHead: Bool
    @State var myColor: Color
    let user = Auth.auth().currentUser
    
    
    
    var body: some View {
        VStack {
            Circle()
                .foregroundColor(myColor)
                .frame(width: 100, height: 100)
            
            Spacer()
            
            ColorPicker("表の色", selection: $myColor)
                .padding()
            
            Button(action: {
                Task {
                    if isHead {
                        await saveHeadsColor(userID: String(user!.uid), dbHeadsColor: makeDBHeadsColorFromColor(myColor: myColor))
                    } else {
                        await saveTailsColor(userID: String(user!.uid), dbTailsColor: makeDBtTailsColorFromColor(myColor: myColor))
                    }
                }
            }) {
                RoundedRectangle(cornerRadius: 20)
                    .fill((user != nil) ? myColor.gradient : Color.gray.gradient)
                    .frame(width: 150, height: 120)
                    .overlay(Text("保存").font(.title))
                    .foregroundColor(.white)
                    
            }
            .disabled(user == nil)
            .padding()
            
            Spacer()
        }
    }
}

#Preview {
    SelectColorView(isHead: true, myColor: Color.green) .environmentObject(CoinColor())
}
