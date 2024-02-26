//
//  PersonMO+CoreDataProperties.swift
//  Pipedrive Homework
//
//  Created by Kevin Mihkelson on 25.02.2024.
//
//

import Foundation
import CoreData


extension PersonMO {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonMO> {
        return NSFetchRequest<PersonMO>(entityName: "PersonMO")
    }

    @NSManaged public var addTime: Date?
    @NSManaged public var birthday: String?
    @NSManaged public var firstName: String?
    @NSManaged public var id: Int64
    @NSManaged public var jobTitle: String?
    @NSManaged public var lastName: String?
    @NSManaged public var name: String?
    @NSManaged public var notes: String?
    @NSManaged public var orgName: String?
    @NSManaged public var updateTime: Date?
    @NSManaged public var phone: NSSet?
    @NSManaged public var email: NSSet?

}

// MARK: Generated accessors for phone
extension PersonMO {
    
    @objc(addPhoneObject:)
    @NSManaged public func addToPhone(_ value: PersonContactMO)
    
    @objc(removePhoneObject:)
    @NSManaged public func removeFromPhone(_ value: PersonContactMO)
    
    @objc(addPhone:)
    @NSManaged public func addToPhone(_ values: NSSet)
    
    @objc(removePhone:)
    @NSManaged public func removeFromPhone(_ values: NSSet)
    
}

// MARK: Generated accessors for email
extension PersonMO {
    
    @objc(addEmailObject:)
    @NSManaged public func addToEmail(_ value: PersonContactMO)
    
    @objc(removeEmailObject:)
    @NSManaged public func removeFromEmail(_ value: PersonContactMO)
    
    @objc(addEmail:)
    @NSManaged public func addToEmail(_ values: NSSet)
    
    @objc(removeEmail:)
    @NSManaged public func removeFromEmail(_ values: NSSet)
    
}

extension PersonMO : Identifiable {
    
}
