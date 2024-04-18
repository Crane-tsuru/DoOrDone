//
//  CoinTossData.swift
//  DoOrDone
//
//  Created by 鶴見駿 on 2024/04/13.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore


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

struct DBData: Codable, Identifiable {
    var id: UUID
    var date: String
    var prediction: Bool
    var result: String
    var resetCount: Int
    
    enum CodingKeys: CodingKey {
        case id
        case date
        case prediction
        case result
        case resetCount
    }
}

let judgeMember = ["表", "裏"]
let resultWord = ["アタリ", "ハズレ"]
let message: [Bool: [String]] = [true: ["やってみよう！", "やっぱりやめておこう…"],
                                   false: ["やらなくていい！", "少しでいいから始めてみない？"]]


let db = Firestore.firestore()

extension DBData {
    
    func save(userID: String) async {
        // Add a new document in collection
        do {
            try await db.collection(userID).document(id.uuidString).setData([
                "id": id.uuidString,
                "date": date,
                "prediction": prediction,
                "result": result,
                "resetCount": resetCount
          ])
          print("Document successfully written!")
        } catch {
          print("Error writing document: \(error)")
        }
    }
}

func fetchMyData(userID: String) async -> [DBData] {
    var allData: [DBData] = []
    
    do {
        let querySnapshot = try await db.collection("user").getDocuments()
        for document in querySnapshot.documents {
            try allData.append(document.data(as: DBData.self))
        }
        
    } catch {
        print(error)
    }
    
    return allData
}

func delete(id: String) async {
    do {
      try await db.collection("user").document(id).delete()
      print("Document successfully removed!")
    } catch {
      print("Error removing document: \(error)")
    }
}
