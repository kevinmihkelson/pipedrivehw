//
//  PersonViewModel.swift
//  Pipedrive Homework
//
//  Created by Kevin Mihkelson on 22.02.2024.
//

import Foundation
import SwiftUI


class PersonViewModel: ObservableObject {
    @Published var personList: [Person] = []
    @Published var isFetching: Bool = false
    @Published var errorMessage: String?
    @Published var showAlert: Bool = false
    
    private var moreItemsAvailable: Bool?
    private var page: Int = 0
    private let itemsFromEndThreshold: Int
    private let limit: Int
    
    private let personService: PersonServiceDelegate
    private let coreDataManager: CoreDataManager
    
    init(personService: PersonServiceDelegate = PersonService(), coreDataManager: CoreDataManager = CoreDataManager.shared, itemsFromEndThreshold: Int, limit: Int) {
        self.personService = personService
        self.coreDataManager = coreDataManager
        self.itemsFromEndThreshold = itemsFromEndThreshold
        self.limit = limit
    }
    
    func getPersonList() async {
        await MainActor.run {
            isFetching = true
        }
        if Connectivity.isConnectedToInternet {
            await fetchFromWeb()
        } else {
            await fetchFromCoreData()
        }
    }
    
    @MainActor
    func refreshList() async {
        isFetching = true
        personList.removeAll()
        page = 0
        await getPersonList()
    }
    
    @MainActor
    func requestMore(index: Int) async {
        if (moreItemsAvailable == true && thresholdMet(page + 1 * limit, index)) {
            isFetching = true
            page += 1
            await fetchFromWeb()
        }
    }
    
    private func fetchFromWeb() async {
        await personService.getPersonList(start: page * limit, limit: limit) { [self] result in
            switch result {
            case .success((let people, let moreItemsInCollection)):
                personList.append(contentsOf: people)
                moreItemsAvailable = moreItemsInCollection
            case .failure(let error):
                errorMessage = error.localizedDescription
                showAlert = true
            }
            isFetching = false
        }
    }
    
    private func fetchFromCoreData() async {
        do {
            let fetchedPeople = try await coreDataManager.loadPersons()
            if !fetchedPeople.isEmpty {
                await MainActor.run() {
                    personList = fetchedPeople
                }
            } else {
                print("No people found in CoreData")
            }
        } catch {
            errorMessage = error.localizedDescription
            showAlert.toggle()
        }
    }
    
    private func thresholdMet(_ itemsLoadedCount: Int, _ index: Int) -> Bool {
        return (itemsLoadedCount - index) == itemsFromEndThreshold
    }
    
}
