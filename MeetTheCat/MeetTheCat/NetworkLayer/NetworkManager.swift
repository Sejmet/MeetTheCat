//
//  NetworkManager.swift
//  MeetTheCat
//
//  Created by Sejmet on 20/11/2021.
//

import Foundation
import Network
import Alamofire

class NetworkManager {
    
    private enum NetworkStatus {
        case connected, notConnected
    }
    
    private let monitor = NWPathMonitor()
    private static var networkStatus: NetworkStatus = .connected

    func start() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.handlePathUpdate(path)
        }
        startFechingConectionChanges()
    }

    func stop() {
        monitor.cancel()
    }
    
    private func startFechingConectionChanges(){
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }

    private func handlePathUpdate(_ path: NWPath) {
        let status: NetworkStatus = path.status == .satisfied ? .connected : .notConnected
        updateNetworkStatus(to: status)
    }

    private func updateNetworkStatus(to status: NetworkStatus) {
        guard NetworkManager.networkStatus != status else { return }
        NetworkManager.networkStatus = status
        status == .connected ? print("Connected") : handleNoConnection()
    }

    private func handleNoConnection() {
        DispatchQueue.main.async {
//            let noConnectionAlert = ModalFactory.createAlert()
//            noConnectionAlert.alertSubtitle = "No hay conexion a internet. Compruebe su conexion a internet para continuar."
//            noConnectionAlert.alertIcon = .crossErrorImage
//            MainNavigationViewController.shared.present(noConnectionAlert, animated: true, completion: nil)
        }
    }
    
     static func isThereConnection() -> Bool {
        NetworkManager.networkStatus == .connected
    }
}
