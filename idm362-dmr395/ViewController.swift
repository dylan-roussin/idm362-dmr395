//
//  ViewController.swift
//  idm362-dmr395
//
//  Created by Dylan on 1/19/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var nameText: UITextField!
    
    var vCounter:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        displayLabel.textColor = UIColor(named: "Prince")
    }

    @IBAction func addBtn(_ sender: Any) {
        vCounter += 1
        displayLabel.text = String(vCounter)
    }
    
    
    @IBAction func nameBtn(_ sender: Any) {
        displayLabel.text = "Well Hello There \(nameText.text!)"
    }
    // Disable keyboard when user touches elsewhere
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

