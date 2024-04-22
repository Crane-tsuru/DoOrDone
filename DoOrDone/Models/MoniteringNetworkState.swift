//
//  MoniteringNetworkState.swift
//  DoOrDone
//
//  Created by 鶴見駿 on 2024/04/23.
//

import Foundation
import Network

class MonitoringNetworkState: ObservableObject {

    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)

    @Published var isConnected = false

    init() {
        monitor.start(queue: queue)

        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    self.isConnected = true
                }
            } else {
                DispatchQueue.main.async {
                    self.isConnected = false
                }
            }
        }
    }
}
