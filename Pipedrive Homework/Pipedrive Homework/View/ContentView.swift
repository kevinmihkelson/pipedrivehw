//
//  ContentView.swift
//  Pipedrive Homework
//
//  Created by Kevin Mihkelson on 22.02.2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var personViewModel: PersonViewModel = PersonViewModel(itemsFromEndThreshold: 1, limit: 15)
    
    var body: some View {
        NavigationView {
            PersonListView(personViewModel: personViewModel)
        }.task {
            await personViewModel.getPersonList()
        }
    }
}
