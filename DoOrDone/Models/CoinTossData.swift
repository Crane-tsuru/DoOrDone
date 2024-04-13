//
//  CoinTossData.swift
//  DoOrDone
//
//  Created by 鶴見駿 on 2024/04/13.
//

import SwiftUI

struct CoinTossData {
    var date: Date = Date()
    var prediction = ""
}


extension CoinTossData {
    static var member = ["表", "裏"]
}
