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
        Text((DBdata.prediction == true) ? "前向き" : "後ろ向き")
        
        if DBdata.prediction {
            
            if DBdata.result == resultWord[0] {
                HStack {
                    Image(systemName: "flame")
                        .foregroundColor(.red)
                    Text("やろう!")
                }
            } else {
                Label("やっぱりやめておこう…", systemImage: "person.fill.exclamationmark")
            }
            
        } else {
            
            if DBdata.result == resultWord[0] {
                HStack {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.blue)
                    Text("やらなくていい！")
                }
            } else {
                HStack {
                    Image(systemName: "heart.fill")
                        .foregroundColor(.green)
                    Text("少しやってみたら?")
                }
            }
            
        }
    }
}

#Preview {
    LogListView()
}
