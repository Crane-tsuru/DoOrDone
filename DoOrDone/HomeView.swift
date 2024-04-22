//
//  ContentView.swift
//  DoOrDone
//
//  Created by 鶴見駿 on 2024/04/13.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    let authenticated: Bool = (Auth.auth().currentUser != nil)
    
    @EnvironmentObject var coinColor: CoinColor
    
    var body: some View {
            VStack {
                Text("Do or Done!")
                    .font(.largeTitle)
                    .bold()
                
                Spacer()
                
                NavigationLink(destination: PredictCoinView().environmentObject(coinColor)) {
                    Capsule()
                        .frame(width: 200, height: 120)
                        .tint(.pink)
                        .overlay(Text("コイントス").font(.largeTitle).foregroundColor(.white))
                }.padding()
                
                Spacer()
                
                NavigationLink(destination: LogListView()) {
                    Label("履歴", systemImage: "square.stack.3d.up.fill")
                        .font(.largeTitle)
                        .foregroundColor(.green)
                        .opacity(authenticated ? 1.0 : 0.2)
                }
                .scaleEffect(1.5)
                .padding()
                
                Spacer()
                
                NavigationLink(destination: SettingsView().environmentObject(coinColor)) {
                    Label("設定", systemImage: "gearshape")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                }
                .padding()
                
                Spacer()
            }
            .padding()
    }
}

#Preview {
    HomeView().environmentObject(CoinColor())
}
