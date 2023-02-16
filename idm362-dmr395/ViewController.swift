//
//  ViewController.swift
//  idm362-dmr395
//
//  Created by Dylan on 1/19/23.
//

import UIKit

class ViewController: UIViewController {
    
    // Declare outlets
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var popOutBtn: UIButton!
    
    // Initalize counter
    var vCounter:Int = 0
    
    // * On load
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        displayLabel.textColor = UIColor(named: "Prince")
         activityIndicator.startAnimating()
    }

    // Add one to the counter
    @IBAction func addBtn(_ sender: Any) {
        vCounter += 1
        displayLabel.text = String(vCounter)
    }
    
    // Display name as label text
    @IBAction func nameBtn(_ sender: Any) {
        displayLabel.text = "Well Hello There \(nameText.text!)"
    }
    
    // Disable keyboard when user touches elsewhere
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // Slider value
    @IBAction func sliderMoving(_ sender: UISlider) {
        displayLabel.text = "Slider value: \(sender.value)"
    }
    
    // Switch for activity indicator
    @IBAction func activitySwitch(_ sender: UISwitch) {
        if (sender.isOn) {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
    
    // Segmented control
    @IBAction func segmentControl(_ sender: UISegmentedControl) {
        displayLabel.text = "Segment: \(sender.titleForSegment(at: sender.selectedSegmentIndex)!)"
    }
    
    // Build popOutBtn values
    func setUpPopOutBtn() {
        let optionsObj = {
            // (action : UIAction) in print(action.title)
            (action: UIAction) in self.displayLabel.text = action.title
        }
        
        popOutBtn.menu = UIMenu(children : [
            UIAction(title: "Mild", state: .on, handler: optionsObj),
            UIAction(title: "Medium", handler: optionsObj),
            UIAction(title: "Spicy", handler: optionsObj)
        ])
        
        popOutBtn.showsMenuAsPrimaryAction = true
        popOutBtn.changesSelectionAsPrimaryAction = true
        popOutBtn.tintColor = UIColor(named: "Prince")
    }
    
}
