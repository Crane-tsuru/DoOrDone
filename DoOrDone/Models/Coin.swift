//
//  Coin.swift
//  DoOrDone
//
//  Created by 鶴見駿 on 2024/04/13.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore

struct Coin: View {
    @Binding var isFlipping: Bool
    @Binding var isHeads: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(isHeads ? .gray : .orange)
                .frame(width: 100, height: 100)
            
            Circle()
                .foregroundColor(isHeads ? .green: .yellow)
                .frame(width: 90, height: 90)
        }
    }
}

class CoinColor: ObservableObject {
    @Published var headColor = Color.green
    @Published var tailColor = Color.orange
    
    func saveColor(isHead: Bool, color: Color) {
        if isHead {
            
        }
    }
}

func color_default() -> DBColor {
    return DBColor(headsRed: 0, headsGreen: 1, headsBlue: 0, headsAlpha: 1, tailsRed: 0, tailsGreen: 0, tailsBlue: 1, tailsAlpha: 1)
}

struct DBColor: Codable {
    var headsRed: CGFloat
    var headsGreen: CGFloat
    var headsBlue: CGFloat
    var headsAlpha: CGFloat
    
    var tailsRed: CGFloat
    var tailsGreen: CGFloat
    var tailsBlue: CGFloat
    var tailsAlpha: CGFloat
    
    enum CodingKeys: CodingKey {
        case headsRed
        case headsGreen
        case headsBlue
        case headsAlpha
        case tailsRed
        case tailsGreen
        case tailsBlue
        case tailsAlpha
    }
}

let collectionName_Color = "color"

extension DBColor {
    func saveHeadsColor(userID: String) async {
        do {
            try await db.collection(collectionName_Color).document(userID).setData([
                "headsRed": headsRed,
                "headsGreen": headsGreen,
                "headsBlue": headsBlue,
                "headsAlpha": headsAlpha,
            ])
            print("Document successfully written!")
        } catch {
            print("Error writing document: \(error)")
        }
    }
    
    func saveTailsColor(userID: String) async {
        do {
            try await db.collection(collectionName_Color).document(userID).setData([
                "headsRed": headsRed,
                "headsGreen": headsGreen,
                "headsBlue": headsBlue,
                "headsAlpha": headsAlpha,
                "tailsRed": tailsRed,
                "tailsGreen": tailsGreen,
                "tailsBlue": tailsBlue,
                "tailsAlpha": tailsAlpha
            ])
            print("Document successfully written!")
        } catch {
            print("Error writing document: \(error)")
        }
    }
    
    func getHeadsColor() -> Color {
        return Color(red: headsRed, green: headsGreen, blue: headsBlue, opacity: headsAlpha)
    }
    
    func getTailsColor() -> Color {
        return Color(red: tailsRed, green: tailsGreen, blue: tailsBlue, opacity: tailsAlpha)
    }
}

func getDBColor(userID: String) async -> DBColor {
    var myDBColor: DBColor = color_default()
    let docRef = db.collection(collectionName_Color).document(userID)
    
    do {
        myDBColor = try await docRef.getDocument(as: DBColor.self)
    } catch {
        print("Error getting document: \(error)")
    }
    
    return myDBColor
}
