//
//  DoOrDoneApp.swift
//  DoOrDone
//
//  Created by 鶴見駿 on 2024/04/13.
//
import SwiftUI
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      
    // アプリ起動時に匿名認証
    Auth.auth().signInAnonymously() { (authResult, error) in
        if error != nil{
            print("Auth Error :\(error!.localizedDescription)")
        }

        
        // 認証情報の取得
        return
    }

    return true
  }
}

@main
struct DoOrDoneApp: App {
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  var coinColor = CoinColor()

  var body: some Scene {
    WindowGroup {
      NavigationView {
          AuthenticationView().environmentObject(coinColor)
      }.onAppear {
          Task {
              if let user = Auth.auth().currentUser {
                  await coinColor.getMyColor_DB(userID: String(user.uid))
              }
          }
      }
    }
  }
}
