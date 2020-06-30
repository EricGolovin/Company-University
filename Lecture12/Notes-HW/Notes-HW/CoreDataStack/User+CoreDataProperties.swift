//
//  User+CoreDataProperties.swift
//  Notes-HW
//
//  Created by Eric Golovin on 6/30/20.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var folders: NSOrderedSet?

}

// MARK: Generated accessors for folders
extension User {

    @objc(insertObject:inFoldersAtIndex:)
    @NSManaged public func insertIntoFolders(_ value: Folder, at idx: Int)

    @objc(removeObjectFromFoldersAtIndex:)
    @NSManaged public func removeFromFolders(at idx: Int)

    @objc(insertFolders:atIndexes:)
    @NSManaged public func insertIntoFolders(_ values: [Folder], at indexes: NSIndexSet)

    @objc(removeFoldersAtIndexes:)
    @NSManaged public func removeFromFolders(at indexes: NSIndexSet)

    @objc(replaceObjectInFoldersAtIndex:withObject:)
    @NSManaged public func replaceFolders(at idx: Int, with value: Folder)

    @objc(replaceFoldersAtIndexes:withFolders:)
    @NSManaged public func replaceFolders(at indexes: NSIndexSet, with values: [Folder])

    @objc(addFoldersObject:)
    @NSManaged public func addToFolders(_ value: Folder)

    @objc(removeFoldersObject:)
    @NSManaged public func removeFromFolders(_ value: Folder)

    @objc(addFolders:)
    @NSManaged public func addToFolders(_ values: NSOrderedSet)

    @objc(removeFolders:)
    @NSManaged public func removeFromFolders(_ values: NSOrderedSet)

}
