//
//  RefleshView.swift
//  DoOrDone
//
//  Created by 鶴見駿 on 2024/04/23.
//

import SwiftUI

struct EntryView: View {
    @EnvironmentObject var networkMonitor: MonitoringNetworkState
    
    @EnvironmentObject var coinColor: CoinColor
    
    var body: some View {
        
        NavigationStack {
            if networkMonitor.isConnected {
                HomeView()
                    .environmentObject(coinColor)
                    .environmentObject(networkMonitor)
            } else {
                disconnectedNetowork()
            }
        }
        .onAppear {
            if networkMonitor.isConnected {
                Task {
                    await coinColor.getMyColor_DB()
                }
            }
        }
    }
}

#Preview {
    EntryView().environmentObject(MonitoringNetworkState())
        .environmentObject(CoinColor())
        .environmentObject(MonitoringNetworkState())
}
