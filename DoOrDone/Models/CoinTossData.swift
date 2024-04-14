//
//  CoinTossData.swift
//  DoOrDone
//
//  Created by 鶴見駿 on 2024/04/13.
//

import SwiftUI

class CoinTossData: ObservableObject {
    var date: Date
    @Published var prediction: String
    @Published var result: String
    
    init(prediction: String) {
        self.date = Date()
        self.prediction = prediction
        self.result = ""
    }
}

var judgeMember = ["表", "裏"]

extension CoinTossData {
    
    func judege(result: String) -> Bool {
        if prediction == result {
            return true
        } else {
            return false
        }
    }
}

func Predict(prediction: String) async -> String {
    return prediction
}
