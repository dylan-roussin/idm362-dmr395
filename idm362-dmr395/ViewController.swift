//
//  ViewController.swift
//  idm362-dmr395
//
//  Created by Dylan on 1/19/23.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    @IBOutlet var tableView: UITableView!

    
    var tasks = [String]()
    
    var timer = Timer()
    var isTimerStarted = false
    var time = 1500

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Home"
        
        tableView?.delegate = self
        tableView?.dataSource = self
        
        // Setup
        
        if !UserDefaults().bool(forKey: "setup") {
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(0, forKey: "count")
            UserDefaults().set(1500, forKey: "time")
        }
        
        timeLabel.text = formatTime(UserDefaults().integer(forKey: "time"))
        
        // get tasks
        updateTasks()
        
    }
    
    func updateTasks() {
        tasks.removeAll()
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        for x in 0..<count {
            if let task = UserDefaults()
                .value(forKey: "task_\(x+1)") as? String {
                tasks.append(task)
            }
            
        }
        time = UserDefaults().integer(forKey: "time")
        tableView?.reloadData()
    }
    
    func refresh() {
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        tasks.removeAll()
        for i in 1...count {
            if let task = UserDefaults().value(forKey: "task_\(i)") as? String {
                tasks.append(task)
            }
        }
        tableView.reloadData()
    }
    
    
    @IBAction func addButtonPressed() {
        let viewCon = storyboard?.instantiateViewController(withIdentifier: "entry") as! EntryViewController
        viewCon.title = "New Task"
        viewCon.update = {
            DispatchQueue.main.async {
                self.updateTasks()
            }
        }
        present(viewCon, animated: true, completion: nil)
    }


    @IBAction func startButtonPressed(_ sender: Any) {
        stopButton.isEnabled = true
        stopButton.alpha = 1.0
        if !isTimerStarted {
            startTimer()
            isTimerStarted = true
            startButton.setTitle("Pause", for: .normal)
        } else {
            timer.invalidate()
            isTimerStarted = false
            startButton.setTitle("Resume", for: .normal)
        }
    }
    
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        stopButton.isEnabled = false
        stopButton.alpha = 0.5
        startButton.setTitle("Start", for: .normal)
        timer.invalidate()
        isTimerStarted = false
        time = UserDefaults().integer(forKey: "time")
        timeLabel.text = formatTime(time)
    }

    
    func startTimer(){
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if time < 1 {
            stopButton.isEnabled = false
            stopButton.alpha = 0.5
            startButton.setTitle("Start", for: .normal)
            timer.invalidate()
            isTimerStarted = false
            time = UserDefaults().integer(forKey: "time")
            timeLabel.text = formatTime(time)

        } else {
            time -= 1
            timeLabel.text = formatTime(time)
        }
    }
    



    
    func formatTime(_ time: Int)->String{
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i", minutes, seconds)
    }
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let position = indexPath.row + 1
        let viewCon = storyboard?.instantiateViewController(withIdentifier: "task") as! TaskViewController
        viewCon.title = "New Task"
        viewCon.task = tasks[indexPath.row]
        viewCon.position = position
        viewCon.update = { [weak self] in
            self?.refresh()
        }
        present(viewCon, animated: true, completion: nil)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = tasks[indexPath.row]
        
        return cell
    }
}
