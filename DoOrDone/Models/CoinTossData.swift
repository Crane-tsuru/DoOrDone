//
//  CoinTossData.swift
//  DoOrDone
//
//  Created by 鶴見駿 on 2024/04/13.
//

import SwiftUI

class CoinTossData: ObservableObject {
    var date = Date()
    @Published var prediction = true
    @Published var result = ""
}

var judgeMember = ["表", "裏"]
var resultWord = ["アタリ!", "ハズレ"]

extension CoinTossData {
    
//    func judege(result: String) -> Bool {
//        if prediction == result {
//            return true
//        } else {
//            return false
//        }
//    }
}


