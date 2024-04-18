//
//  SettingsView.swift
//  DoOrDone
//
//  Created by 鶴見駿 on 2024/04/18.
//

import SwiftUI
import FirebaseAuth


struct SettingsView: View {
    @State var isLogout = false
    
    var body: some View {
        VStack {
            Button(action: {
                do {
                    try Auth.auth().signOut()
                    print("success")
                    isLogout.toggle()
                    
                } catch let signOutError as NSError {
                    print(signOutError)
                }
            }) {
                Label("ログアウト", systemImage: "arrowshape.turn.up.left")
            }
        }.fullScreenCover(isPresented: $isLogout) {
            AuthenticationView()
        }
    }
}

#Preview {
    SettingsView()
}
