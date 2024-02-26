//
//  PersonDetailField.swift
//  Pipedrive Homework
//
//  Created by Kevin Mihkelson on 25.02.2024.
//

import Foundation

enum PersonField: String, CaseIterable {
    case organizationName = "building.2.fill"
    case jobTitle = "briefcase"
    case phone = "phone.fill"
    case email = "envelope.fill"
    case notes = "note.text"
    case birthday = "calendar"
    
    
    var title: String {
        switch self {
        case .organizationName: return "Organization Name"
        case .jobTitle: return "Job Title"
        case .phone: return "Phone"
        case .email: return "Email"
        case .notes: return "Notes"
        case .birthday: return "Birthday"
        }
    }
    
    var iconName: String {
        return rawValue
    }
}
