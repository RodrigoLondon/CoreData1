//
//  TaskDetailTableViewController.swift
//  CoreData 1
//
//  Created by Lewis Jones on 06/09/2018.
//  Copyright © 2018 Rodrigo. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {

    
    var task: Task? {
        didSet {
            updateViews()
        }
    }
    var dueDateValue: Date?
    
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var dueTextField: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet var dueDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dueTextField.inputView = dueDatePicker
        updateViews()
        title = task?.name ?? ""
    }

    @IBAction func addTaskButtonPressed(_ sender: UIBarButtonItem) {
        
        updateTask()
        let  _ =  navigationController?.popViewController(animated: true)
        
        
        
//        guard let taskName = taskNameTextField.text,
//        let note = noteTextView.text, let date = dueDateValue else { return }
//
//        TaskController.shared.add(taskWithName: taskName, notes: note, due: date)
//        tableView.reloadData()
//
//        taskNameTextField.text = ""
//        noteTextView.text = ""
        
    }
    
    @IBAction func cancelTaskButtonTapped(_ sender: UIBarButtonItem) {
        
   let _ = navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        self.dueTextField.text = sender.date.stringValue()
        self.dueDateValue = sender.date
    }
    
    @IBAction func userTappedView(_ sender: Any) {
        self.taskNameTextField.resignFirstResponder()
        self.dueTextField.resignFirstResponder()
        self.noteTextView.resignFirstResponder()
    }
    
    
    private func updateTask() {
    
        guard let name = taskNameTextField.text else { return }
        let due = dueDateValue
        let notes = noteTextView.text
        
        if let task = self.task {
            TaskController.shared.update(task: task, name: name, notes: notes, due: due)
        } else {
            TaskController.shared.add(taskWithName: name, notes: notes, due: due)
        }
        
    }
    
    
   private func updateViews() {
    
        guard let task = task, isViewLoaded else { return }
    
        title = task.name
        taskNameTextField.text = task.name
        noteTextView.text = task.notes
        dueTextField.text = (task.due as Date?)?.stringValue()
    
    
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
