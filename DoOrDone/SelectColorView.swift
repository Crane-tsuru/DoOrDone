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
    
    @State var isBack = false // flag to go SettingsView
    @State var isAlert = false // flag to show alert
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .center) {
                    Circle()
                        .foregroundColor(myColor)
                        .frame(width: 100, height: 100)
                    .padding()
                }
                
                VStack(alignment: .trailing) {
                    Circle()
                        .foregroundColor(isHead ? coinColor.headsColor : coinColor.tailsColor)
                        .frame(width: 50, height: 50)
                    .padding()
                }
            }
            
            Spacer()
            
            ColorPicker(isHead ? "表面の色" : "裏面の色", selection: $myColor)
                .padding()
            
            Spacer()
                
            
            // disable button when user == nil
            Button(action: {
                Task {
                    if isHead {
                        await saveHeadsColor(userID: String(user!.uid), dbHeadsColor: makeDBHeadsColorFromColor(myColor: myColor))
                    } else {
                        await saveTailsColor(userID: String(user!.uid), dbTailsColor: makeDBtTailsColorFromColor(myColor: myColor))
                    }
                    
                    if user != nil {
                        await coinColor.getMyColor_DB()
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
            SettingsView().environmentObject(coinColor)
        }
    }
}

#Preview {
    SelectColorView(isHead: true, myColor: Color.green) .environmentObject(CoinColor())
}
