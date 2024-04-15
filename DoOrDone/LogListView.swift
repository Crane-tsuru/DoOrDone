//
//  LogListView.swift
//  DoOrDone
//
//  Created by 鶴見駿 on 2024/04/13.
//

import SwiftUI

struct LogListView: View {
    @State var allData: [DBData] = []
    
    var body: some View {
        VStack {
            List {
                ForEach(allData) {DBdata in
                    LogDetailView(DBdata: DBdata)
                }
            }
        }
        .onAppear {
            Task {
                allData = await fetchMyData()
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
