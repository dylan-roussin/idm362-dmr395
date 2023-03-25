//
//  SettingsViewController.swift
//  idm362-dmr395
//
//  Created by Dylan on 3/25/23.
//

import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var timerField: UITextField!
    @IBOutlet weak var notifSwitchOutlet: UISwitch!
    
    @IBAction func settingsSave(_ sender: Any) {
        setTimer()
    }
    
    var time = UserDefaults.standard.integer(forKey: "time")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timerField.delegate = self

        // Get the saved time from UserDefaults
        if let savedTime = UserDefaults.standard.object(forKey: "time") as? Int {
            time = savedTime
        } else {
            time = 300 // Set a default time of 5 minutes (300 seconds)
        }

        // Set the initial value of timerField
        timerField.text = "\(time / 60):\(String(format: "%02d", time % 60))"

    }

    @objc func setTimer() {
            // Parse the text in timerField and update the time value in UserDefaults
            if let text = timerField.text, let minutes = Int(text.components(separatedBy: ":")[0]), let seconds = Int(text.components(separatedBy: ":")[1]) {
                // Check that minutes and seconds are within valid ranges
                if minutes >= 0 && minutes <= 59 && seconds >= 0 && seconds <= 59 {
                    let newTime = minutes * 60 + seconds
                    UserDefaults.standard.set(newTime, forKey: "time")

                    // Update the time value
                    time = newTime

                    // Set the text of timerField
                    timerField.text = "\(time / 60):\(String(format: "%02d", time % 60))"
                    
                    // Display a message to indicate that the time was successfully saved
                    let alert = UIAlertController(title: "Saved Successfully", message: "The timer has been updated.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                } else {
                    // Display an alert if minutes or seconds are outside valid ranges
                    let alert = UIAlertController(title: "Invalid Input", message: "Please enter a valid time in the format mm:ss.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alert, animated: true, completion: nil)
                }
            } else {
                // Display an alert if text in the timerField is not in the correct format
                let alert = UIAlertController(title: "Invalid Input", message: "Please enter a valid time in the format mm:ss.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            // Allow only numeric input and colons
            let allowedCharacters = CharacterSet(charactersIn: "0123456789:")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
}

