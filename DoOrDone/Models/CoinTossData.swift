//
//  CoinTossData.swift
//  DoOrDone
//
//  Created by 鶴見駿 on 2024/04/13.
//

import SwiftUI

class CoinTossData: ObservableObject {
    var date: Date = Date()
    var prediction = ""
}


extension CoinTossData {
    static var judgeMemver = ["表", "裏"]
    
    
}
