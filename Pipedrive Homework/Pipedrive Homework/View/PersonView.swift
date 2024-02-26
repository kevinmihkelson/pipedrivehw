//
//  Person.swift
//  Pipedrive Homework
//
//  Created by Kevin Mihkelson on 23.02.2024.
//

import Foundation
import SwiftUI
import Kingfisher

struct PersonView: View {
    let person: Person
    
    var body: some View {
        NavigationLink(destination: PersonDetailView(person: person)) {
            HStack {
                KFImage(person.imageURL.flatMap(URL.init))
                    .resizable()
                    .frame(width: 50, height: 50)
                    .clipShape(.circle)
                    .overlay(
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.gray)
                            .opacity(person.imageURL == nil ? 1 : 0)
                    )
                VStack(alignment: .leading) {
                    Text(person.name ?? "-")
                        .font(.title3)
                        .fontWeight(.bold)
                    VStack {
                        Text(NSLocalizedString("Organization: ", comment: ""))
                        + Text(person.orgName ?? "-")
                    }
                    .font(.headline)
                    .fontWeight(.medium)
                    .foregroundColor(.gray)
                    VStack {
                        Text(NSLocalizedString("Title: ", comment: ""))
                        + Text(person.jobTitle ?? "-")
                    }.font(.headline)
                        .fontWeight(.medium)
                        .foregroundColor(.gray)
                }
                Spacer()
            }
        }
    }
}
