import SwiftUI
import FirebaseCore
import FirebaseFirestore

class CoinColor: ObservableObject {
    @Published var headColor = Color.green
    @Published var tailColor = Color.orange
    
    func saveColor(isHead: Bool, color: Color) {
        if isHead {
            
        }
    }
}

func headsColor_default() -> DBHeadsColor {
    return DBHeadsColor(headsRed: 0, headsGreen: 1, headsBlue: 0, headsAlpha: 0.5)
}

func tailsColor_default() -> DBTailsColor {
    return DBTailsColor(tailsRed: 0, tailsGreen: 0, tailsBlue: 1, tailsAlpha: 0.5)
}

struct DBHeadsColor: Codable {
    var headsRed: CGFloat
    var headsGreen: CGFloat
    var headsBlue: CGFloat
    var headsAlpha: Double
    
    func translateDBColorToColor() -> Color {
        return Color(red: headsRed, green: headsGreen, blue: headsBlue, opacity: headsAlpha)
    }
}

struct DBTailsColor: Codable {
    var tailsRed: Double
    var tailsGreen: Double
    var tailsBlue: Double
    var tailsAlpha: Double

    
    func translateDBColorToColor() -> Color {
        return Color(red: tailsRed, green: tailsGreen, blue: tailsBlue, opacity: tailsAlpha)
    }
}

// Color -> DBHeadsColor
func makeDBHeadsColorFromColor(myColor: Color) -> DBHeadsColor {
    guard let components = myColor.cgColor?.components, components.count > 2 else {
        return headsColor_default()
    }
    
    return DBHeadsColor(headsRed: components[0], headsGreen: components[1], headsBlue: components[2], headsAlpha: components[4])
}

// Color -> DBTaildColor
func makeDBtTailsColorFromColor(myColor: Color) -> DBTailsColor {
    guard let components = myColor.cgColor?.components, components.count > 2 else {
        return tailsColor_default()
    }
    
    return DBTailsColor(tailsRed: components[0], tailsGreen: components[1], tailsBlue: components[2], tailsAlpha: components[3])
}


let collectionName_Color = "color"


func saveHeadsColor(userID: String, red: CGFloat, green: CGFloat, blue: CGFloat, opacity: CGFloat) async {
    do {
        try await db.collection(collectionName_Color).document(userID).setData([
            "headsRed": red,
            "headsGreen": green,
            "headsBlue": blue,
            "headsAlpha": opacity
        ])
        print("Document successfully written!")
    } catch {
        print("Error writing document: \(error)")
    }
}

func saveTailsColor(userID: String, red: CGFloat, green: CGFloat, blue: CGFloat, opacity: CGFloat) async {
    do {
        try await db.collection(collectionName_Color).document(userID).setData([
            "tailsRed": red,
            "tailsGreen": green,
            "tailsBlue": blue,
            "tailsAlpha": opacity
        ])
        print("Document successfully written!")
    } catch {
        print("Error writing document: \(error)")
    }
}


// get HeadsColor from firestore
func fetchHeadsColor(userID: String) async -> DBHeadsColor {
    var myHeadsColor: DBHeadsColor = headsColor_default()
    let docRef = db.collection(collectionName_Color).document(userID)
    
    do {
        myHeadsColor = try await docRef.getDocument(as: DBHeadsColor.self)
    } catch {
        print("Error getting document: \(error)")
    }
    
    return myHeadsColor
}

// get TailsColor from firestore
func fetchTailsColor(userID: String) async -> DBTailsColor {
    var myTailsColor: DBTailsColor = tailsColor_default()
    let docRef = db.collection(collectionName_Color).document(userID)
    
    do {
        myTailsColor = try await docRef.getDocument(as: DBTailsColor.self)
    } catch {
        print("fetch myTailsColor Error: \(error)")
    }
    
    return myTailsColor
}
