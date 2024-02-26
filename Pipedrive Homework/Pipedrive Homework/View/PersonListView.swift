//
//  PersonListView.swift
//  Pipedrive Homework
//
//  Created by Kevin Mihkelson on 22.02.2024.
//

import SwiftUI

struct PersonListView: View {
    @ObservedObject var personViewModel: PersonViewModel
    
    var body: some View {
        List(personViewModel.personList) { person in
            PersonView(person: person)
                .onAppear {
                    if (!personViewModel.isFetching) {
                        personViewModel.requestMore(index: person.id)
                    }
                }
                .listRowSeparator(.hidden)
        }.navigationTitle("Persons")
            .listStyle(.plain)
    }
}


#Preview {
    PersonsView(personViewModel: PersonViewModel())
}
