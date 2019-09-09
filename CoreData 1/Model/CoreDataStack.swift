//
//  CoreDataStack.swift
//  CoreData 1
//
//  Created by Lewis Jones on 06/09/2018.
//  Copyright © 2018 Rodrigo. All rights reserved.
//

import Foundation
import  CoreData



enum CoreDataStack {
    
    static let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData1")
        container.loadPersistentStores() { (storeDecription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        return container
    }()
    
    static var context: NSManagedObjectContext { return container.viewContext }
}
