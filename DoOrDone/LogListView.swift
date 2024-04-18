//
//  LogListView.swift
//  DoOrDone
//
//  Created by 鶴見駿 on 2024/04/13.
//

import SwiftUI
import FirebaseAuth

struct LogListView: View {
    @State var allData: [DBData] = []
    let authenticated: Bool = (Auth.auth().currentUser != nil)
    
    @State var empty = false
    
    var body: some View {
        VStack {
            
            if empty {
                Text("コインを振ってみよう！\n結果を保存できます")
                    .font(.largeTitle)
            }
            
            if !authenticated {
                Text("履歴機能を使うには\nログインしてください")
                    .bold()
                    .font(.largeTitle)
                    
            } else {
                List {
                    ForEach(allData) {DBdata in
                        LogDetailView(DBdata: DBdata)
                    }
                }
            }
        }
        .onAppear {
            Task {
                if let user = Auth.auth().currentUser {
                    allData = await fetchMyData(userID: String(user.uid))
                }
                
                if allData.isEmpty {
                    empty = true
                }
            }
        }
    }
}


@ViewBuilder
func LogDetailView(DBdata: DBData) -> some View {
    VStack(alignment: .leading) {
        
        Text(DBdata.date.description)
        Text((DBdata.prediction == true) ? "やりたい" : "やりたくない").bold()
        
        HStack {
            
            if DBdata.prediction {
                
                if DBdata.result == resultWord[0] {
                    Image(systemName: "flame")
                        .foregroundColor(.red)
                    Text("やろう!")
                    
                } else {
                    Label("やっぱりやめておこう…", systemImage: "hand.raised.fill")
                }
                
            } else {
                
                if DBdata.result == resultWord[0] {
                    
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.orange)
                    Text("やらなくていい！")
                
                } else {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.green)
                    Text("少しやってみたら?")
                    
                }
            }
            
            Spacer()
            
            Text("リセット回数: \(DBdata.resetCount)")
        }
    }
}

#Preview {
    LogListView()
}
