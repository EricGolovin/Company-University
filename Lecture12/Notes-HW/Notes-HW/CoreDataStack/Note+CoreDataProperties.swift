//
//  Note+CoreDataProperties.swift
//  Notes-HW
//
//  Created by Eric Golovin on 7/1/20.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var creationDate: Date?
    @NSManaged public var information: String?
    @NSManaged public var name: String?
    @NSManaged public var folder: Folder?

}

extension Note {
    func getStringDate(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        guard let creationDate = creationDate else {
            return "none"
        }
        
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        return formatter.string(from: creationDate)
    }
}
