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
//        guard let user = authResult?.user else { return }
//        let isAnonymous = user.isAnonymous  // true
//        let uid = user.uid
        return
    }

    return true
  }
}

@main
struct DoOrDoneApp: App {
  // register app delegate for Firebase setup
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate


  var body: some Scene {
    WindowGroup {
      NavigationView {
          AuthenticationView().environmentObject(CoinColor())
      }
    }
  }
}
