//
//  TaskViewController.swift
//  idm362-dmr395
//
//  Created by Dylan on 3/25/23.
//

import UIKit

class TaskViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    
    
    var task: String?
    var position: Int?
    var update: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        label.text = task
    }
    

    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        deleteTask()
    }
    
    @objc func deleteTask() {
            guard let position = position else { // check if position is not nil
                return
            }
            guard let count = UserDefaults().value(forKey: "count") as? Int else {
                 return
            }
             
            let newCount = count - 1
            UserDefaults().set(newCount, forKey: "count")
            UserDefaults().set(nil, forKey: "task_\(position)")
            update?()
            dismiss(animated: true)// pop back to the previous view controller
        }
}
