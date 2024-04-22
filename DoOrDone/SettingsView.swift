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
                            .foregroundColor(coinColor.headsColor)
                            .frame(width: 20, height: 20)
                        Text("コインの表の色")
                            .foregroundColor(coinColor.headsColor)
                    }
                }
                
                Button(action: {
                    changeTail = true
                }) {
                    HStack {
                        Circle()
                            .foregroundColor(coinColor.tailsColor)
                            .frame(width: 20, height: 20)
                        Text("コインの裏の色")
                            .foregroundColor(coinColor.tailsColor)
                    }
                }
            }
            .navigationTitle("設定")
            .sheet(isPresented: $changeHead) {
                SelectColorView(isHead: true, myColor: coinColor.headsColor)
                    .environmentObject(coinColor)
            }
            .sheet(isPresented: $changeTail) {
                SelectColorView(isHead: false, myColor: coinColor.tailsColor)
                    .environmentObject(coinColor)
            }
        }
    }
}

#Preview {
    SettingsView().environmentObject(CoinColor())
}
