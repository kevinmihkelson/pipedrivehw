//
//  PersonService.swift
//  Pipedrive Homework
//
//  Created by Kevin Mihkelson on 22.02.2024.
//

import Foundation

protocol PersonServiceDelegate {
    func getPersonList(start: Int, limit: Int, completion: @escaping (Result<([Person], Bool?), NetworkError>) -> Void) async
}

class PersonService: PersonServiceDelegate{
    
    func getPersonList(start: Int, limit: Int, completion: @escaping (Result<([Person], Bool?), NetworkError>) -> Void) async {
        APIClient.getRequest(route: .getPersons(start: start, limit: limit), completion: { result in
            switch result {
            case .success(let data):
                guard let obj = try? JSONDecoder.shared.decode(ResponseModel<Person>.self, from: data) else {
                    completion(.failure(.DecodingError))
                    return
                }
                Task {
                    try await CoreDataManager.shared.savePersons(persons: obj.data)
                }
            
                completion(.success((obj.data, obj.additionalData?.pagination.moreItemsInCollection)))
            case .failure(let error):
                completion(.failure(.APIError(error.localizedDescription)))
            }
        })
    }
}
