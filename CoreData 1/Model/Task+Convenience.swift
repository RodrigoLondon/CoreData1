//
//  Task+Convenience.swift
//  CoreData 1
//
//  Created by Lewis Jones on 06/09/2018.
//  Copyright © 2018 Rodrigo. All rights reserved.
//

import Foundation
import CoreData


extension Task {
    
    convenience init (name: String, notes: String? = nil, due: Date? = nil, context: NSManagedObjectContext = CoreDataStack.context){
        
        self.init(context: context)
        
        self.name = name
        self.notes = notes
        self.due = due 
        self.isComplete = false
    
    }
    
    
}
