//
//  PersonDetailView.swift
//  Pipedrive Homework
//
//  Created by Kevin Mihkelson on 23.02.2024.
//

import Foundation
import SwiftUI
import Kingfisher

struct PersonDetailView: View {
    let person: Person
    
    var body: some View {
        ScrollView {
            VStack {
                KFImage(person.imageURL.flatMap(URL.init))
                    .resizable()
                    .frame(width: 150, height: 150)
                    .clipShape(.circle)
                    .overlay(
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 150, height: 150)
                            .foregroundColor(.gray)
                            .opacity(person.imageURL == nil ? 1 : 0)
                    )
                Text(person.name ?? "-")
                    .font(.title2)
                    .bold()
                VStack(spacing: 16) {
                    ForEach(PersonField.allCases, id: \.rawValue) { field in
                        HStack {
                            Image(systemName: field.iconName)
                                .font(.title2)
                                .foregroundColor(.accentColor)
                            Text(LocalizedStringKey(field.title))
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        if (field == .email || field == .phone) {
                            ForEach(getContactFieldValue(field: field), id: \.self) { contact in
                                HStack {
                                    if let label = contact.label, !label.isEmpty {
                                        Text(label.capitalized + " - ")
                                            .foregroundColor(.secondary)
                                            .bold(contact.primary ?? false)
                                    }
                                    Text(contact.value?.isEmpty ?? true ? "-" : contact.value ?? "-")
                                        .foregroundColor(.secondary)
                                        .bold(contact.primary ?? false)
                                    Spacer()
                                }
                            }
                        } else {
                            HStack {
                                Text(getFieldValue(field: field))
                                    .foregroundColor(.secondary)
                                Spacer()
                            }
                        }
                    }
                }.padding(.horizontal, 10)
                    .padding(.vertical, 20)
            }
        }
    }
    
    private func getContactFieldValue(field: PersonField) -> [PersonContact] {
      switch field {
      case .phone:
          return person.phone?.compactMap { $0 } ?? []
      case .email:
          return person.email?.compactMap { $0 } ?? []
      default:
        return []
      }
    }

    
    private func getFieldValue(field: PersonField) -> String {
        switch field {
        case .jobTitle:
            return person.jobTitle ?? "-"
        case .organizationName:
            return person.orgName ?? "-"
        case .phone:
            return ""
        case .email:
            return ""
        case .notes:
            return person.notes ?? "-"
        case .birthday:
            return person.birthday ?? "-"
        }
    }
}
