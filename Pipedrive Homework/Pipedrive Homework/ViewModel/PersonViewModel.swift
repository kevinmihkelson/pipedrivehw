//
//  PersonViewController.swift
//  Pipedrive Homework
//
//  Created by Kevin Mihkelson on 22.02.2024.
//

import Foundation

class PersonViewController: ObservableObject {
    @Published var personList: [Person] = []
    
    private let personService: PersonServiceDelegate
    
    init(personService: PersonServiceDelegate = PersonService()) {
        self.personService = personService
    }
    
    func getPersonList() async {
        await personService.getPersonList { [self] result in
            switch result {
            case .success(let people):
                personList = people
            case .failure(let error):
                print("Error fetching people: \(error)")
            }
        }
    }
}
