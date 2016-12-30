//
//  AVSceduledTimerCreationViewController.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 11/9/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import UIKit

class AVScheduledTimerCreationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, AVCellsFill {

    @IBOutlet weak var timerNameLabel: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var warmupTimeLabel: UILabel!
    @IBOutlet weak var setsCountLabel: UILabel!
    @IBOutlet weak var setsRestTimeLabel: UILabel!
    @IBOutlet weak var exerciseRestTimeLabel: UILabel!
    @IBOutlet weak var coolDownTimeLabel: UILabel!
    
    var model: AVObservableTimersArrayModel?
    
    var exercises: [AVTimeIntervalModel] = []
    var warmupTime: Int64 = 30
    var setsCount: Int16 = 3
    var exerciseRestTime: Int16 = 10
    var setRestTime: Int16 = 20
    var coolDownTime: Int16 = 30

    let exerciseCreationCellHeight: CGFloat = 164
    let exerciseDetailsCellHeight: CGFloat = 62
    
//	MARK: View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "ADD NEW TIMER"
        
        self.setupLabels()
    }
    
    func setupLabels() {
        self.warmupTimeLabel.text = self.secondsToTimeString(seconds: Int(self.warmupTime))
        self.setsCountLabel.text = String(self.warmupTime)
        self.setsRestTimeLabel.text = self.secondsToTimeString(seconds: Int(self.setRestTime))
        self.exerciseRestTimeLabel.text = self.secondsToTimeString(seconds: Int(self.exerciseRestTime))
        self.coolDownTimeLabel.text = self.secondsToTimeString(seconds: Int(self.coolDownTime))
    }
    
//	MARK: Interface Handling

    @IBAction func onPlusWarmupButton(_ sender: Any) {
        self.warmupTime = Int64(self.timeLabelChangeWithFunction(oldValue: Int(self.warmupTime),
                                                                 function: +,
                                                                 label: self.warmupTimeLabel))
    }

    @IBAction func onMinusWarmupButton(_ sender: Any) {
        self.warmupTime = Int64(self.timeLabelChangeWithFunction(oldValue: Int(self.warmupTime),
                                                                 function: -,
                                                                 label: self.warmupTimeLabel))
    }
    
    @IBAction func onPlusSetsButton(_ sender: Any) {
        self.setsCount = Int16(self.countLabelChangeWithFunction(oldValue: Int(self.setsCount),
                                                                 function: +,
                                                                 label: self.setsCountLabel))
    }
    
    @IBAction func onMinusSetsButton(_ sender: Any) {
        self.setsCount = Int16(self.countLabelChangeWithFunction(oldValue: Int(self.setsCount),
                                                                 function: -,
                                                                 label: self.setsCountLabel))
    }

    @IBAction func onPlusSetsRestTimeButton(_ sender: Any) {
        self.setRestTime = Int16(self.timeLabelChangeWithFunction(oldValue: Int(self.setRestTime),
                                                                  function: +,
                                                                  label: self.setsRestTimeLabel))
    }
    
    @IBAction func onMinusSetsRestTimeButton(_ sender: Any) {
        self.setRestTime = Int16(self.timeLabelChangeWithFunction(oldValue: Int(self.setRestTime),
                                                                  function: -,
                                                                  label: self.setsRestTimeLabel))
    }
    
    @IBAction func onPlusRestButton(_ sender: Any) {
        self.exerciseRestTime = Int16(self.timeLabelChangeWithFunction(oldValue: Int(self.exerciseRestTime),
                                                                       function: +,
                                                                       label: self.exerciseRestTimeLabel))
    }
    
    @IBAction func onMinusRestButton(_ sender: Any) {
        self.exerciseRestTime = Int16(self.timeLabelChangeWithFunction(oldValue: Int(self.exerciseRestTime),
                                                                       function: -,
                                                                       label: self.exerciseRestTimeLabel))
    }
    
    @IBAction func onPlusCoolDownButton(_ sender: Any) {
        self.coolDownTime = Int16(self.timeLabelChangeWithFunction(oldValue: Int(self.coolDownTime),
                                                                   function: +,
                                                                   label: self.coolDownTimeLabel))
    }
    
    @IBAction func onMinusCoolDownButton(_ sender: Any) {
        self.coolDownTime = Int16(self.timeLabelChangeWithFunction(oldValue: Int(self.coolDownTime),
                                                                   function: -,
                                                                   label: self.coolDownTimeLabel))
    }
    
    @IBAction func onAddExerciseButton(_ sender: Any) {
        let cell = sender as! AVExerciseCreationTableViewCell
        var name = ""
        if let text = cell.exerciseNameField.text {
            name = text.isEmpty ? "Exercise" : text
        }

        self.exercises.append(AVTimeIntervalModel(name: name, duration: cell.exerciseDuration))
        self.tableView.reloadData()
    }
    
    @IBAction func onSaveButton(_ sender: Any) {
        self.model?.addTimer(name: self.timerNameLabel.text ?? "Workout",
                             warmupTime: self.warmupTime,
                             setsCount: self.setsCount,
                             exercises: self.exercises,
                             exerciseRestTime: self.exerciseRestTime,
                             setRestTime: self.setRestTime,
                             coolDownTime: self.coolDownTime)
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
//	MARK: UITableViewDelegate, UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.exercises.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cls: AnyClass
        
        if indexPath.row == self.exercises.count {
            cls = AVExerciseCreationTableViewCell.self
            let cell = tableView.dequeueReusableCell(withClass: cls) as! AVExerciseCreationTableViewCell
            cell.addExerciseButtonAction = self.onAddExerciseButton
            
            return cell
        } else {
            cls = AVExerciseDetailsTableViewCell.self
            let cell = tableView.dequeueReusableCell(withClass: cls) as! AVExerciseDetailsTableViewCell
            cell.exerciseNameLabel.text = self.exercises[indexPath.row].name
            cell.exerciseDurationLabel.text = self.secondsToTimeString(seconds: self.exercises[indexPath.row].duration)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == self.exercises.count {
            return self.exerciseCreationCellHeight
        } else {
            return self.exerciseDetailsCellHeight
        }
    }

}
