//
//  CoinTossData.swift
//  DoOrDone
//
//  Created by 鶴見駿 on 2024/04/13.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

let db = Firestore.firestore()

class CoinTossData: ObservableObject, Identifiable {
    let id = UUID()
    var date = Date()
    @Published var prediction = true
    @Published var result = ""
    
    public func translateDataToDB() -> DBData {
        let DBdata = DBData(id: id, date: date, prediction: prediction, result: result)
        return DBdata
    }
}

struct DBData: Codable, Identifiable {
    var id: UUID
    var date: Date
    var prediction: Bool
    var result: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case date
        case prediction
        case result
    }
}

var judgeMember = ["表", "裏"]
var resultWord = ["アタリ!", "ハズレ"]

extension CoinTossData {
    
    func save(coinTossData: CoinTossData) async {
        // Add a new document in collection
        do {
            try await db.collection("user").document(coinTossData.id.uuidString).setData([
                "id": coinTossData.id,
                "date": coinTossData.date,
                "result": coinTossData.result
          ])
          print("Document successfully written!")
        } catch {
          print("Error writing document: \(error)")
        }
    }
}


