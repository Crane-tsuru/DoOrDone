//
//  CoinTossData.swift
//  DoOrDone
//
//  Created by 鶴見駿 on 2024/04/13.
//

import SwiftUI

class CoinTossData: ObservableObject, Identifiable {
    let id = UUID()
    var date = dateFormat.string(from: Date())
    @Published var prediction = true
    @Published var result = ""
    @Published var resetCount: Int = 0
    
    public func translateDataToDB() async -> DBData {
        let DBdata =  DBData(id: id, date: date, prediction: prediction, result: result, resetCount: resetCount)
        return DBdata
    }
}


let judgeMember = ["表", "裏"]
let resultWord = ["アタリ", "ハズレ"]
let message: [Bool: [String]] = [true: ["やってみよう！", "やっぱりやめておこう…"],
                                   false: ["少しでいいから始めてみない？", "やらなくていい！"]]
