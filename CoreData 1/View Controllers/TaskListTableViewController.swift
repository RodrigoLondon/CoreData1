//
//  TaskListTableViewController.swift
//  CoreData 1
//
//  Created by Lewis Jones on 06/09/2018.
//  Copyright © 2018 Rodrigo. All rights reserved.
//

import UIKit

class TaskListTableViewController: UITableViewController, ButtonTableViewCellDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    
    
    @IBAction func didPressEditButton(_ sender: Any) {
        
        tableView.setEditing(!tableView.isEditing, animated: true)
        if tableView.isEditing {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didPressEditButton(_ : )))
        } else {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(didPressEditButton(_ : )))
            //            let note = NotesController.shared.notes
            //            NotesController.shared.remove(note: note)
        }
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return TaskController.shared.tasks.count
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let task = TaskController.shared.tasks[sourceIndexPath.row]
        TaskController.shared.tasks.remove(at: sourceIndexPath.row)
        TaskController.shared.tasks.insert(task, at: destinationIndexPath.row)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: ButtonTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as? ButtonTableViewCell
        if cell == nil { cell = ButtonTableViewCell() }

        
        let task = TaskController.shared.tasks[indexPath.row]
        
        cell.update(withTask: task)
        cell.delegate = self
        cell.textLabel?.text = task.name
//        cell.detailTextLabel?.text = task.notes
        return cell
    
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let task = TaskController.shared.tasks[indexPath.row]
            TaskController.shared.remove(task: task)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    
    
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell) {
        guard let indexPath = tableView.indexPath(for: sender) else { return }
        let task = TaskController.shared.tasks[indexPath.row]
        TaskController.shared.toggleIsCompleteFor(task: task)
        tableView.reloadRows(at: [indexPath], with: .automatic)
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toTaskDetailTVC" {
           if let detailViewController = segue.destination as? TaskDetailTableViewController,
            let indexPath = tableView.indexPathForSelectedRow?.row {
            let task = TaskController.shared.tasks[indexPath]
            detailViewController.task = task
            detailViewController.dueDateValue = task.due
            
            }
        }
    }

}
