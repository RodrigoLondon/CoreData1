//
//  TaskController.swift
//  CoreData 1
//
//  Created by Lewis Jones on 06/09/2018.
//  Copyright © 2018 Rodrigo. All rights reserved.
//

import Foundation
import CoreData


class TaskController {
    
 static let shared = TaskController()
 
    
    
    init() {
        tasks = fecthTasks()
    }


    var tasks: [Task] = []
    
    
    
    // CRUD
    
    func add(taskWithName name: String, notes: String?, due: Date?) {
       let _ = Task(name: name, notes: notes, due: due)
       saveToPersistentStore()
       tasks = fecthTasks()
    }
    
    
    func update(task: Task, name: String, notes: String?, due: Date?) {
        task.name = name
        task.notes = notes
        task.due = due
        saveToPersistentStore()
        tasks = fecthTasks()
    }
    
    func remove(task: Task) {
        let moc = CoreDataStack.context
        moc.delete(task)
        saveToPersistentStore()
        tasks = fecthTasks()
    }
    
    
    func toggleIsCompleteFor(task: Task) {
        task.isComplete = !task.isComplete
        saveToPersistentStore()
    }
    
    
    func saveToPersistentStore() {
        
        do {
            try CoreDataStack.context.save()
        } catch let error {
            print("Error encoding object \(error)")
        }
        
    }
    
    
    func fecthTasks() -> [Task] {

        let request: NSFetchRequest<Task> = Task.fetchRequest()

        do {
            return try CoreDataStack.context.fetch(request)
        } catch {
            print("Error fetching entries: \(error)")
            return []
        }

    }

    
}
