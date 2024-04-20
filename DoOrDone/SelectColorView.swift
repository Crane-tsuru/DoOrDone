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
    
    @State var isBack = false
    @State var isAlert = false
    
    var body: some View {
        VStack {
            Circle()
                .foregroundColor(myColor)
                .frame(width: 100, height: 100)
                .padding()
            
            Spacer()
            
            ColorPicker(isHead ? "表面の色" : "裏面の色", selection: $myColor)
                .padding()
            
            Spacer()
                
            
            Button(action: {
                Task {
                    if isHead {
                        await saveHeadsColor(userID: String(user!.uid), dbHeadsColor: makeDBHeadsColorFromColor(myColor: myColor))
                    } else {
                        await saveTailsColor(userID: String(user!.uid), dbTailsColor: makeDBtTailsColorFromColor(myColor: myColor))
                    }
                    isAlert = true
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
        .alert(isPresented: $isAlert) {
            Alert(title: Text("保存しました"), dismissButton: .default(Text("戻る"), action: {isBack = true}))
        }
        .fullScreenCover(isPresented: $isBack) {
            SettingsView()
        }
    }
}

#Preview {
    SelectColorView(isHead: true, myColor: Color.green) .environmentObject(CoinColor())
}
