//
//  AVSceduledTimerCreationViewController.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 11/9/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import UIKit

class AVScheduledTimerCreationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var warmupLabel: UILabel!
    @IBOutlet weak var setsLabel: UILabel!
    @IBOutlet weak var restLabel: UILabel!
    @IBOutlet weak var coolDownLabel: UILabel!
    
    var model = AVScheduledTimerModel(name: "none", warmupTime: 30, setsCount: 1, restTime: 10, coolDownTime: 30)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "ADD NEW TIMER"
        
        tableView.rowHeight = 196

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cls : AnyClass
        
        if indexPath.row == 1 {
            cls = AVExerciseCreationTableViewCell.self
        } else {
            cls = AVExerciseDetailsTableViewCell.self
        }
        
        return tableView.dequeueReusableCell(withClass: cls)!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height : CGFloat
        if indexPath.row == 1 {
            height = 196
        } else {
            height = 80
        }
        
        return height
    }
    
    func timeLabelChangeWithFunction(oldValue: Int, function: (Int, Int) -> Int, label: UILabel) -> Int {
        let newValue = function(oldValue, 1)
        
//        let seconds = newValue % 60
//        let minutes = newValue / 60
//
//        label.text = "\(minutes) : \(seconds)"

        label.text = self.secondsToTimeString(seconds: newValue)
        
        return newValue
    }
    
    func secondsToTimeString(seconds value: Int) -> String {
        let seconds = String(format:"%02d", value % 60)
        let minutes = String(format:"%02d", value / 60)

        return "\(minutes):\(seconds)"
    }
    
    func countLabelChangeWithFunction(oldValue: Int, function: (Int, Int) -> Int, label: UILabel) -> Int {
        let newValue = function(oldValue, 1)
        
        label.text = "\(newValue)"
        
        return newValue
    }
    
    @IBAction func onPlusWarmupButton(_ sender: Any) {
        self.model.warmupTime = self.timeLabelChangeWithFunction(oldValue: self.model.warmupTime,
                                                                 function: +,
                                                                 label: self.warmupLabel)
    }
    
    @IBAction func onMinusWarmupButton(_ sender: Any) {
        self.model.warmupTime = self.timeLabelChangeWithFunction(oldValue: self.model.warmupTime,
                                                                 function: -,
                                                                 label: self.warmupLabel)
    }
    
    @IBAction func onPlusSetsButton(_ sender: Any) {
        self.model.setsCount = self.countLabelChangeWithFunction(oldValue: self.model.setsCount,
                                                                 function: +,
                                                                 label: self.setsLabel)
    }
    
    @IBAction func onMinusSetsButton(_ sender: Any) {
        self.model.setsCount = self.countLabelChangeWithFunction(oldValue: self.model.setsCount,
                                                                 function: -,
                                                                 label: self.setsLabel)
    }
    
    @IBAction func onPlusRestButton(_ sender: Any) {
        self.model.restTime = self.timeLabelChangeWithFunction(oldValue: self.model.restTime,
                                                                 function: +,
                                                                 label: self.restLabel)
    }
    
    @IBAction func onMinusRestButton(_ sender: Any) {
        self.model.restTime = self.timeLabelChangeWithFunction(oldValue: self.model.restTime,
                                                               function: -,
                                                               label: self.restLabel)
    }
    
    @IBAction func onPlusCoolDownButton(_ sender: Any) {
        self.model.coolDownTime = self.timeLabelChangeWithFunction(oldValue: self.model.coolDownTime,
                                                               function: +,
                                                               label: self.coolDownLabel)
    }
    
    @IBAction func onMinusCoolDownButton(_ sender: Any) {
        self.model.coolDownTime = self.timeLabelChangeWithFunction(oldValue: self.model.coolDownTime,
                                                                   function: +,
                                                                   label: self.coolDownLabel)
    }
    
    @IBAction func onSaveButton(_ sender: Any) {

    }
}
