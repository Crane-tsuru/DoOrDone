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
    var body: some View {
        Button("削除") {
            Task {
                await delete(id: "CCBD9EE3-CC3E-4C1B-BD8E-0D460BEE145B")
            }
        }
    }
}

#Preview {
    DeleteButton()
}
