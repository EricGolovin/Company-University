//
//  Notes+CoreDataProperties.swift
//  Notes-HW
//
//  Created by Eric Golovin on 6/30/20.
//
//

import Foundation
import CoreData


extension Notes {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Notes> {
        return NSFetchRequest<Notes>(entityName: "Notes")
    }

    @NSManaged public var creationDate: Date?
    @NSManaged public var information: String?
    @NSManaged public var name: String?
    @NSManaged public var folder: Folder?

}
