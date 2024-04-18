//
//  SettingsView.swift
//  DoOrDone
//
//  Created by 鶴見駿 on 2024/04/18.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var coinColor: CoinColor
    @State var changeHead = false
    @State var changeTail = false
    
    var body: some View {
        NavigationView {
            List {
                Button(action: {
                    changeHead = true
                }) {
                    HStack {
                        Circle()
                            .foregroundColor(coinColor.headColor)
                            .frame(width: 20, height: 20)
                        Text("コインの表の色")
                            .foregroundStyle(coinColor.headColor)
                    }
                }
                
                Button(action: {
                    changeTail = true
                }) {
                    HStack {
                        Circle()
                            .foregroundColor(coinColor.tailColor)
                            .frame(width: 20, height: 20)
                        Text("コインの表の色")
                            .foregroundStyle(coinColor.tailColor)
                    }
                }
            }
            .navigationTitle("設定")
            .sheet(isPresented: $changeHead) {
                HeadsColorView(isHead: true)
                    .environmentObject(CoinColor())
            }
            .sheet(isPresented: $changeTail) {
                HeadsColorView(isHead: false)
                    .environmentObject(CoinColor())
            }
        }
    }
}

#Preview {
    SettingsView().environmentObject(CoinColor())
}
