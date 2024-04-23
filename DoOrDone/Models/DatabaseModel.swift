//
//  DatabaseModel.swift
//  DoOrDone
//
//  Created by 鶴見駿 on 2024/04/19.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth


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
        let querySnapshot = try await db.collection(userID).order(by: "date").getDocuments()
        for document in querySnapshot.documents {
            try allData.append(document.data(as: DBData.self))
        }
        
    } catch {
        print(error)
    }
    
    return allData
}

func delete(collection: String, targetDocument: String) async {
    do {
      try await db.collection(collection).document(targetDocument).delete()
      print("Document successfully removed!")
    } catch {
      print("Error removing document: \(error)")
    }
}
