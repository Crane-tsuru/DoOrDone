//
//  FirstEntryView.swift
//  DoOrDone
//
//  Created by 鶴見駿 on 2024/04/18.
//

import SwiftUI


import SwiftUI
import FirebaseAuth

struct CreateUserView: View {
    @State var name: String = ""
    @State var email: String = ""
    @State var password: String = ""
    
    var body: some View {
        VStack {
            TextField("name", text: $name).padding().textFieldStyle(.roundedBorder)
            TextField("mail address", text: $email).padding().textFieldStyle(.roundedBorder)
            TextField("password", text: $password).padding().textFieldStyle(.roundedBorder)
            
            Button(action: {
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    if let user = result?.user {
                        let request = user.createProfileChangeRequest()
                        request.displayName = name
                        request.commitChanges { error in
                            if error == nil {
                                user.sendEmailVerification() { error in
                                    if error == nil {
                                        print("仮登録画面へ")
                                    }
                                }
                            }
                        }
                    }
                }
            }) {
                Text("新規登録")
            }.padding()
        }
    }
}


#Preview {
    CreateUserView()
}
