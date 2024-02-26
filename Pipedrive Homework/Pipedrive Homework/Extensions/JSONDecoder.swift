//
//  JSONDecoderExtensions.swift
//  Pipedrive Homework
//
//  Created by Kevin Mihkelson on 23.02.2024.
//

import Foundation

extension JSONDecoder {
    static let shared: JSONDecoder = {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
}
