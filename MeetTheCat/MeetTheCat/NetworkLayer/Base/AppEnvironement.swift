//
//  AppEnvironement.swift
//  MeetTheCat
//
//  Created by Sejmet on 20/11/2021.
//

import Foundation

enum AppEnvironement {
    case production
    case development
}

extension AppEnvironement {
    static var currentState: AppEnvironement {
        return .development
    }
}

extension AppEnvironement {
    static var baseURL: URL {
        switch AppEnvironement.currentState {
        case .production:
            return URL(string: APIServers.production)!
        case .development:
            return URL(string: APIServers.development)!
        }
    }
}

extension AppEnvironement {
    static var showLog: Bool {
        switch AppEnvironement.currentState {
        case .production:
            return false
        case .development:
            return true
        }
    }
}
