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
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Do or Done!")
                    .font(.largeTitle)
                    .bold()
                
                Spacer()
                
                NavigationLink(destination: SelectCoinView()) {
                    Capsule()
                        .frame(width: 200, height: 120)
                        .tint(.pink)
                        .overlay(Text("コイントス").font(.largeTitle).foregroundColor(.white))
                }.padding()
                
                NavigationLink(destination: LogListView()) {
                    Label("履歴", systemImage: "square.stack.3d.up.fill")
                        .font(.largeTitle)
                        .foregroundColor(.green)
                        .opacity(authenticated ? 1.0 : 0.2)
                }
                .padding()
                
                NavigationLink(destination: SettingsView()) {
                    Label("設定", systemImage: "gear")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                }
                .padding()
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    HomeView()
}
