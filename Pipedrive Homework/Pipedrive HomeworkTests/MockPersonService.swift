//
//  MockPersonService.swift
//  Pipedrive HomeworkTests
//
//  Created by Kevin Mihkelson on 25.02.2024.
//

import Foundation
@testable import Pipedrive_Homework

class MockPersonService: PersonServiceDelegate {
    public static let mockPersonList: [Person] = {
        var list: [Person] = []
        for index in 0..<30 {
          list.append(Person(id: index + 1))
        }
        return list
      }()

    func getPersonList(start: Int, limit: Int, completion: @escaping (Result<([Person], Bool?), NetworkError>) -> Void) async {
      let adjustedStart = max(0, start)
      let adjustedLimit = min(limit, Self.mockPersonList.count - adjustedStart)
      
      let sublist = Self.mockPersonList[adjustedStart..<adjustedStart + adjustedLimit]

        completion(.success((Array(sublist), start + limit < Self.mockPersonList.count)))
    }
    
}
