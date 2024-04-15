//
//  DeleteButton.swift
//  DoOrDone
//
//  Created by 鶴見駿 on 2024/04/15.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

struct DeleteButton: View {
    var body: some View {
        Button("削除") {
            Task {
                await delete(id: "D7C48A2D-7061-42DE-A9FD-F57551A826E1")
            }
        }
    }
}

#Preview {
    DeleteButton()
}
