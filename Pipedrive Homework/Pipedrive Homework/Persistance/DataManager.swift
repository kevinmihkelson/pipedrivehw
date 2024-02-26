//
//  DataManager.swift
//  Pipedrive Homework
//
//  Created by Kevin Mihkelson on 23.02.2024.
//

import Foundation
import CoreData

enum DataManagerType {
    case normal, preview, testing
}

class DataManager: NSObject, ObservableObject {
    
    static let shared = DataManager(type: .normal)
    static let preview = DataManager(type: .preview)
    static let testing = DataManager(type: .testing)
    
    @Published var todos: OrderedDictionary<UUID, Todo> = [:]
    
    var projectsArray: [Project] {
        Array(projects.values)
    }
    
    fileprivate var managedObjectContext: NSManagedObjectContext
    private let todosFRC: NSFetchedResultsController<TodoMO>
    private let projectsFRC: NSFetchedResultsController<ProjectMO>
    
    private init(type: DataManagerType) {
        switch type {
        case .normal:
            let persistentStore = PersistentStore()
            self.managedObjectContext = persistentStore.context
        case .preview:
            let persistentStore = PersistentStore(inMemory: true)
            self.managedObjectContext = persistentStore.context
            // Add Mock Data
            try? self.managedObjectContext.save()
        case .testing:
            let persistentStore = PersistentStore(inMemory: true)
            self.managedObjectContext = persistentStore.context
        }
        
        let projectFR: NSFetchRequest<ProjectMO> = ProjectMO.fetchRequest()
        projectFR.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        projectsFRC = NSFetchedResultsController(fetchRequest: projectFR,
                                                 managedObjectContext: managedObjectContext,
                                                 sectionNameKeyPath: nil,
                                                 cacheName: nil)
        
        super.init()
        
        projectsFRC.delegate = self
        try? projectsFRC.performFetch()
        if let newProjects = projectsFRC.fetchedObjects {
            self.projects = OrderedDictionary(uniqueKeysWithValues: newProjects.map({ ($0.id!, Project(projectMO: $0)) }))
        }
    }
    
    func saveData() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch let error as NSError {
                NSLog("Unresolved error saving context: \(error), \(error.userInfo)")
            }
        }
    }
}

extension DataManager: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if let newTodos = controller.fetchedObjects as? [TodoMO] {
            self.todos = OrderedDictionary(uniqueKeysWithValues: newTodos.map({ ($0.id!, Todo(todoMO: $0)) }))
        } else if let newProjects = controller.fetchedObjects as? [ProjectMO] {
            print(newProjects)
            self.projects = OrderedDictionary(uniqueKeysWithValues: newProjects.map({ ($0.id!, Project(projectMO: $0)) }))
        }
    }
}
