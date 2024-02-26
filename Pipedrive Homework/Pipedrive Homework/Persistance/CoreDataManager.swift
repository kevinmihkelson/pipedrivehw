//
//  CoreDataManager.swift
//  Pipedrive Homework
//
//  Created by Kevin Mihkelson on 23.02.2024.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    private init() {}
    private static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataModel")
        container.loadPersistentStores(completionHandler: { _, error in
            _ = error.map { fatalError("Unresolved error \($0)") }
        })
        return container
    }()
    
    var mainContext: NSManagedObjectContext {
        return CoreDataManager.persistentContainer.viewContext
    }
    
    func loadPersons() async throws -> [Person] {
        let context = CoreDataManager.shared.mainContext
        let fetchRequest: NSFetchRequest<PersonMO> = PersonMO.fetchRequest()
        
        do {
            let results = try await context.perform {
                try fetchRequest.execute()
            }
            return results.compactMap { personMO in
                copyPersonMOToPerson(personMO: personMO)
            }
        } catch {
            debugPrint("Error fetching persons: \(error)")
            throw error
        }
    }
    
    func savePersons(persons: [Person]) async throws {
        let context = mainContext
        try await context.perform {
            for person in persons {
                do {
                    if let existingPerson = try self.fetchPerson(withId: person.id) {
                        
                        self.copyPersonFieldsToPersonMO(person: person, personMO: existingPerson, context: context)
                        try context.save()
                    } else {
                        let personMO = self.copyPersonToPersonMO(person: person, in: context)
                        try context.save()
                    }
                } catch {
                    throw error
                }
            }
        }
    }
    
    func fetchPerson(withId id: Int) throws -> PersonMO? {
        let context = mainContext
        let fetchRequest = PersonMO.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", NSNumber(value: id))
        
        do {
            let results = try context.performAndWait {
                try fetchRequest.execute()
            }
            return results.first
        } catch let error {
            throw error
        }
    }
    
    private func copyPersonMOToPerson(personMO: PersonMO) -> Person {
        let contactMOPhone: [PersonContactMO] = personMO.phone?.toArray() ?? []
        let contactMOEmail: [PersonContactMO] = personMO.email?.toArray() ?? []
        
        return Person(
            id: Int(personMO.id),
            name: personMO.name ?? "noname",
            firstName: personMO.firstName,
            lastName: personMO.lastName,
            orgName: personMO.orgName,
            phone: contactMOPhone.compactMap { phoneContactMO in
                PersonContact(label: phoneContactMO.label,
                              value: phoneContactMO.value,
                              primary: phoneContactMO.primary)
            },
            email: contactMOEmail.compactMap { emailContactMO in
                PersonContact(label: emailContactMO.label,
                              value: emailContactMO.value,
                              primary: emailContactMO.primary)
            },
            updateTime: personMO.updateTime,
            addTime: personMO.addTime,
            notes: personMO.notes,
            birthday: personMO.birthday,
            jobTitle: personMO.jobTitle
        )
    }
    
    private func copyPersonToPersonMO(person: Person, in context: NSManagedObjectContext) -> PersonMO {
        let entity = PersonMO.entity()
        let personMO = PersonMO(entity: entity, insertInto: context)
        
        personMO.id = Int64(person.id)
        copyPersonFieldsToPersonMO(person: person, personMO: personMO, context: context)
        return personMO
    }
    
    private func copyPersonFieldsToPersonMO(person: Person, personMO: PersonMO, context: NSManagedObjectContext) {
        personMO.name = person.name
        personMO.orgName = person.orgName
        personMO.addTime = person.addTime
        personMO.firstName = person.firstName
        personMO.lastName = person.lastName
        personMO.updateTime = person.updateTime
        personMO.addTime = person.addTime
        personMO.notes = person.notes
        personMO.birthday = person.birthday
        personMO.jobTitle = person.jobTitle
        
        if let phoneNumbers = person.phone {
            if (phoneNumbers.count >= 1) {
                let phoneContactMOs = phoneNumbers.map { phoneNumber in
                    let contactMO = PersonContactMO(entity: PersonContactMO.entity(), insertInto: context)
                    contactMO.label = phoneNumber?.label
                    contactMO.primary = phoneNumber?.primary ?? false
                    contactMO.value = phoneNumber?.value
                    contactMO.person = personMO
                    return contactMO
                }
                personMO.phone = NSSet(array: phoneContactMOs)
            }
        }
        
        if let emailAddresses = person.email {
            if (emailAddresses.count >= 1) {
                let emailContactMOs = emailAddresses.map { emailAddress in
                    let contactMO = PersonContactMO(entity: PersonContactMO.entity(), insertInto: context)
                    contactMO.label = emailAddress?.label
                    contactMO.primary = emailAddress?.primary ?? false
                    contactMO.value = emailAddress?.value
                    contactMO.person = personMO
                    return contactMO
                }
                personMO.email = NSSet(array: emailContactMOs)
            }
        }
    }
    
    
}
