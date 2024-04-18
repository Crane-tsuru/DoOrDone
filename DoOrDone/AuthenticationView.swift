//
//  AuthenticationView.swift
//  DoOrDone
//
//  Created by 鶴見駿 on 2024/04/18.
//

import SwiftUI
import FirebaseAuth

struct AuthenticationView: View {
    @State var email: String = ""
    @State var password: String = ""
    
    @State var flag = false
    
    var body: some View {
        
        VStack {
            if Auth.auth().currentUser == nil {
                NavigationView {
                    VStack {
                        TextField("mail address", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 250)
                        
                        TextField("password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 250)
                        
                        Button(action: {
                            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                                if (result?.user) != nil {
                                    // ログイン時に閲覧できる画面として画面遷移させる
                                    print("ログインしました。")
                                    flag.toggle()
                                }
                            }
                        }) {
                            Text("ログイン")
                        }.padding()
                        
                        Button(action: {
                            
                        }) {
                            Text("匿名ログイン")
                        }.padding()
                        
                        NavigationLink(destination: PasswordResetView()) {
                            Text("パスワードリセット")
                        }
                        
                        NavigationLink(destination: CreateUserView()) {
                            Text("未登録の方はこちらから")
                        }
                    }
                }
            } else {
                HomeView()
            }
        }.fullScreenCover(isPresented: $flag) {
            HomeView()
        }
    }
}

struct PasswordResetView: View {
    
    @State var email:String = ""
    
    var body: some View {
        VStack{
            TextField("mail address", text: $email).padding().textFieldStyle(.roundedBorder)
            Button(action: {
                Auth.auth().sendPasswordReset(withEmail: email) { error in
                    // ...
                }
            }, label: {
                Text("メール送信")
            })
        }
    }
}

#Preview {
    AuthenticationView()
}
