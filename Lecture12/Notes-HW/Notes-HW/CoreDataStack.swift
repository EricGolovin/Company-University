//
//  CoreDataStack.swift
//  Notes-HW
//
//  Created by Eric Golovin on 7/8/20.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let stack = CoreDataStack(name: "Notes_HW")
    
    private let modelName: String
    
    private init(name: String) {
        self.modelName = name
    }
    
    lazy var managedContext: NSManagedObjectContext = {
        return storeContainer.viewContext
    }()
    
    lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func saveContext() {
        guard managedContext.hasChanges else { return }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    func delete(_ object: NSManagedObject) {
        managedContext.delete(object)
        saveContext()
    }
}
