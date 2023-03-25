//
//  EntryViewController.swift
//  idm362-dmr395
//
//  Created by Dylan on 3/25/23.
//

import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var field: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    
    var update: (() -> Void)?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        field.delegate = self
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        saveTask()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        saveTask()
        
        return true
    }
    
    @objc func saveTask(){
        guard let text = field.text, !text.isEmpty else {
            return
        }
       guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        
        let newCount = count + 1
        
        UserDefaults().set(newCount, forKey: "count")
        UserDefaults().set(text, forKey: "task_\(newCount)")
        
        update?()
        
        dismiss(animated: true)
    }
}
