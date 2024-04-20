//
//  SettingsView.swift
//  DoOrDone
//
//  Created by 鶴見駿 on 2024/04/18.
//

import SwiftUI
import FirebaseAuth

struct SettingsView: View {
    @EnvironmentObject var coinColor: CoinColor
    
    @State var changeHead = false
    @State var changeTail = false
    
    @State var headsColor = Color(red: 0, green: 0, blue: 0, opacity: 0.5)
    
    @State var tailsColor = Color(red: 1, green: 1, blue: 1, opacity: 0.5)

    
    var body: some View {
        NavigationView {
            List {
                Button(action: {
                    changeHead = true
                }) {
                    HStack {
                        Circle()
                            .foregroundColor(headsColor)
                            .frame(width: 20, height: 20)
                        Text("コインの表の色")
                            .foregroundColor(headsColor)
                    }
                }
                
                Button(action: {
                    changeTail = true
                }) {
                    HStack {
                        Circle()
                            .foregroundColor(tailsColor)
                            .frame(width: 20, height: 20)
                        Text("コインの表の色")
                            .foregroundColor(tailsColor)
                    }
                }
            }
            .navigationTitle("設定")
            .sheet(isPresented: $changeHead) {
                SelectColorView(isHead: true, myColor: headsColor)
                    .environmentObject(CoinColor())
            }
            .sheet(isPresented: $changeTail) {
                SelectColorView(isHead: false, myColor: tailsColor)
                    .environmentObject(CoinColor())
            }
        }
        .onAppear {
            Task {
                if let user = Auth.auth().currentUser  {
                    let DBHeadsColor = await fetchHeadsColor(userID: String(user.uid))
                    
                    let DBTailsColor = await fetchTailsColor(userID: String(user.uid))
                    
                    headsColor = DBHeadsColor.translateDBColorToColor()
                    
                    tailsColor = DBTailsColor.translateDBColorToColor()
                }
            }
        }
    }
}

#Preview {
    SettingsView().environmentObject(CoinColor())
}
