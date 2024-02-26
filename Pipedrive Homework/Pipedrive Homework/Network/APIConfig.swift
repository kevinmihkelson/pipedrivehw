//
//  APIConfig.swift
//  Pipedrive Homework
//
//  Created by Kevin Mihkelson on 22.02.2024.
//

import Foundation

enum APIConfig {
    case dev
    case live
    
    var baseURL: String {
        switch self {
        case .dev:
            // If a dev env exists
            return "https://api.pipedrive.com/v1"
        case .live:
            return "https://api.pipedrive.com/v1"
        }
    }
}
