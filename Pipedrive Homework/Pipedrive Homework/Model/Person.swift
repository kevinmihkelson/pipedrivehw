//
//  Person.swift
//  Pipedrive Homework
//
//  Created by Kevin Mihkelson on 22.02.2024.
//

import Foundation

struct Person: Identifiable {
    var id: Int
    var name: String?
    var firstName: String?
    var lastName: String?
    var isActive: Bool?
    var orgName: String?
    var phone: [PersonContact?]?
    var email: [PersonContact?]?
    var updateTime: Date?
    var addTime: Date?
    var notes: String?
    var birthday: String?
    var jobTitle: String?
    var imageURL: String?
}

extension Person: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
        lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
        isActive = try container.decodeIfPresent(Bool.self, forKey: .isActive)
        orgName = try container.decodeIfPresent(OrgID.self, forKey: .orgName)?.name
        phone = try container.decodeIfPresent([PersonContact?].self, forKey: .phone)
        email = try container.decodeIfPresent([PersonContact?].self, forKey: .email)
        updateTime = try container.decodeIfPresent(Date.self, forKey: .updateTime)
        addTime = try container.decodeIfPresent(Date.self, forKey: .addTime)
        notes = try container.decodeIfPresent(String.self, forKey: .notes)
        birthday = try container.decodeIfPresent(String.self, forKey: .birthday)
        jobTitle = try container.decodeIfPresent(String.self, forKey: .jobTitle)
        imageURL = try container.decodeIfPresent(PictureID.self, forKey: .imageURL)?.imageURL512
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case orgName = "org_id"
        case name
        case firstName = "first_name"
        case lastName = "last_name"
        case isActive = "active_flag"
        case phone
        case email
        case updateTime = "update_time"
        case addTime = "add_time"
        case notes
        case birthday
        case jobTitle = "job_title"
        case imageURL = "picture_id"
    }
    
    
    private struct PictureID: Codable {
        let pictures: [String: String]
        
        var imageURL512: String? {
            return pictures["512"]
        }
    }
    
    private struct OrgID: Codable {
        let name: String?
    }
}
