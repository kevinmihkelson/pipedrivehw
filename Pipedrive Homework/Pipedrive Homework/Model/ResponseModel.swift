//
//  ResponseModel.swift
//  Pipedrive Homework
//
//  Created by Kevin Mihkelson on 22.02.2024.
//

struct ResponseModel<T: Codable>: Codable {
    let success: Bool
    let data: [T]
    let additionalData: AdditionalData?
    
    enum CodingKeys: String, CodingKey {
        case success,data
        case additionalData = "additional_data"
    }
}
