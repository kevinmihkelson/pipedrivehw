//
//  APIRouter.swift
//  Pipedrive Homework
//
//  Created by Kevin Mihkelson on 22.02.2024.
//

import Foundation
import Alamofire

public enum APIRouter {
    
    case getPersons(start: Int, limit: Int)
    
    private static let environment = APIConfig.live
    
    // Don't want the actual token to be visible in GitHub
    private static let apiToken = "f6ccfa30da451f612b3645d52ad162c1e5be5d78"

    var urlPath: String {
        let baseUrl = APIRouter.environment.baseURL
        let tokenParam = "?api_token=\(APIRouter.apiToken)"
        switch self {
        case .getPersons(let start, let limit):
            return "\(baseUrl)/persons\(tokenParam)&start=\(start)&limit=\(limit)"
        }
    }
    
}
