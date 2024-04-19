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
    
    @State var dbColor: DBColor = color_default()
    
    var body: some View {
        NavigationView {
            List {
                Button(action: {
                    changeHead = true
                }) {
                    HStack {
                        Circle()
                            .foregroundColor(dbColor.getHeadsColor())
                            .frame(width: 20, height: 20)
                        Text("コインの表の色")
                            .foregroundColor(dbColor.getHeadsColor())
                    }
                }
                
                Button(action: {
                    changeTail = true
                }) {
                    HStack {
                        Circle()
                            .foregroundColor(dbColor.getTailsColor())
                            .frame(width: 20, height: 20)
                        Text("コインの表の色")
                            .foregroundColor(dbColor.getTailsColor())
                    }
                }
            }
            .navigationTitle("設定")
            .sheet(isPresented: $changeHead) {
                HeadsColorView(isHead: true, myColor: dbColor.getHeadsColor())
                    .environmentObject(CoinColor())
            }
            .sheet(isPresented: $changeTail) {
                HeadsColorView(isHead: false, myColor: dbColor.getTailsColor())
                    .environmentObject(CoinColor())
            }
        }
        .onAppear {
            Task {
//                if let headsColor = 
            }
        }
    }
}

#Preview {
    SettingsView().environmentObject(CoinColor())
}
