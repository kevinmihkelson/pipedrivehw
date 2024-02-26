//
//  PersonListView.swift
//  Pipedrive Homework
//
//  Created by Kevin Mihkelson on 22.02.2024.
//

import SwiftUI

struct PersonListView: View {
    @ObservedObject var personViewModel: PersonViewModel
    @State private var isRefreshing: Bool = false
    
    var body: some View {
        VStack {
            if (personViewModel.personList.isEmpty) {
                ScrollView {
                    VStack {
                        Spacer() 
                        Text(LocalizedStringKey("No people found!"))
                            .font(.headline)
                            .padding(.top)
                        Text(LocalizedStringKey("Pull up to refresh"))
                            .font(.callout)
                            .foregroundColor(.secondary)
                    }
                }.refreshable {
                    isRefreshing = true
                    if (!personViewModel.isFetching) {
                        await personViewModel.refreshList()
                    }
                }
            } else {
                List {
                    ForEach(personViewModel.personList) { person in
                        PersonView(person: person)
                            .listRowSeparator(.hidden)
                            .task {
                                if (!personViewModel.isFetching) {
                                    await personViewModel.requestMore(index: person.id)
                                }
                            }
                    }
                }
                .listStyle(.plain)
            }
        }.navigationTitle(LocalizedStringKey("Persons"))
            .alert(
                isPresented: $personViewModel.showAlert,
                content: { Alert(title: Text("Error"), message: Text(personViewModel.errorMessage ?? "Unknown error")) }
            )
            .overlay(content: {
                if (personViewModel.isFetching && personViewModel.personList.isEmpty && !isRefreshing) {
                    ProgressView().scaleEffect(2)
                }
            })
    }
}
