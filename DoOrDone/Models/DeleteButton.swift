//
//  DeleteButton.swift
//  DoOrDone
//
//  Created by 鶴見駿 on 2024/04/15.
//

// not on App

import SwiftUI
import FirebaseCore
import FirebaseFirestore

struct DeleteButton: View {
    let collection = "BezdbyTTTLTfrsIDWONJMzIDNNJ2"
    
    var body: some View {
        Button("削除") {
            Task {
                await delete(collection: "BezdbyTTTLTfrsIDWONJMzIDNNJ2", targetDocument: "3D4EA167-AF7B-47AD-9862-9099977A00C1")
            }
        }
    }
}

#Preview {
    DeleteButton()
}
