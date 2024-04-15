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
    var date = Date()
    @Published var prediction = true
    @Published var result = ""
    
    public func translateDataToDB() async -> DBData {
        let DBdata =  DBData(id: id, date: date, prediction: prediction, result: result)
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
var message = ["やってみよう！", "やっぱりやめておこう…", "やらなくていい！", "少しでいいから始めてみない？"]


let db = Firestore.firestore()

extension DBData {
    
    func save() async {
        // Add a new document in collection
        do {
            try await db.collection("user").document(id.uuidString).setData([
                "id": id.uuidString,
                "date": date,
                "prediction": prediction,
                "result": result
          ])
          print("Document successfully written!")
        } catch {
          print("Error writing document: \(error)")
        }
    }
}

func fetchMyData() async -> [DBData] {
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
