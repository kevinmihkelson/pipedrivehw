//
//  APIClient.swift
//  Pipedrive Homework
//
//  Created by Kevin Mihkelson on 22.02.2024.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case BadURL
    case NoData
    case DecodingError
    case APIError(String)
}

class APIClient {
    
    static func getRequest(
        route: APIRouter,
        completion: @escaping(Result<Data, NetworkError>) -> Void) {
            AF.request(route.urlPath, method: .get ).validate().response { response in
                let result = response.result
                switch result {
                case .success(let data):
                    guard let data = data else {
                        completion(.failure(.NoData))
                        return
                    }
                    
                    completion(.success(data))
                case .failure(let error):
                    completion(.failure(.APIError(error.localizedDescription)))
                }
            }
        }
}
