//
//  Person.swift
//  Pipedrive Homework
//
//  Created by Kevin Mihkelson on 23.02.2024.
//

import Foundation
import SwiftUI

struct PersonView: View {
    let person: Person

    var body: some View {
        HStack {
            // Display person's name and ID with appropriate formatting
            VStack(alignment: .leading) {
                Text(person.name)
                    .font(.title3)
                    .fontWeight(.bold)
                Text("ID: \(person.id)")
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            // Add other relevant person details as needed (e.g., email, phone number)
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
