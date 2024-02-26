//
//  PersonContactMO+CoreDataProperties.swift
//  Pipedrive Homework
//
//  Created by Kevin Mihkelson on 25.02.2024.
//
//

import Foundation
import CoreData


extension PersonContactMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonContactMO> {
        return NSFetchRequest<PersonContactMO>(entityName: "PersonContactMO")
    }

    @NSManaged public var label: String?
    @NSManaged public var value: String?
    @NSManaged public var primary: Bool
    @NSManaged public var person: PersonMO?

}

extension PersonContactMO : Identifiable {

}
