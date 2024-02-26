//
//  Pagination.swift
//  Pipedrive Homework
//
//  Created by Kevin Mihkelson on 26.02.2024.
//

import Foundation

struct Pagination: Codable {
    let start: Int
    let limit: Int
    let moreItemsInCollection: Bool
    
    enum CodingKeys: String, CodingKey {
        case start, limit
        case moreItemsInCollection = "more_items_in_collection"
    }
}
