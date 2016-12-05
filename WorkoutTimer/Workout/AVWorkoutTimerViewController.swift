//
//  AVWorkoutTimerViewController.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 11/9/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import UIKit

class AVWorkoutTimerViewController: UIViewController, AVCellsFill {

    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var countDownTimerLabel: UILabel!
    @IBOutlet weak var countUpTimerLabel: UILabel!
    @IBOutlet weak var totalCountDownTimerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    
    var captionLabelText: String?
    var countDownTimerLabelText: String?
    var countUpTimerLabelText: String?
    var totalCountDownTimerLabelText: String?
    
    var timeIntervals: Array<ExerciseModel> = []
    var totalCountDownTime: Int = 0
    var exerciseCountDown: Int = 0
    var exerciseCountUp: Int = 0
    var activityCountDown: Int = 0
    var currentTimeIntervalIndex: Int = 0
    
    var model: TimerModel? {
        didSet {
            if let newModel = model {
                let timeIntervals = newModel.timeIntervals
                var totalCountDownTime = 0
                timeIntervals.forEach {
                    totalCountDownTime += Int($0.duration)
                }
                
                self.totalCountDownTime = totalCountDownTime
                self.timeIntervals = timeIntervals
            }
            
//            let newModel = model ?? AVScheduledTimerModel(name: "none", warmupTime: 0, setsCount: 0, setsRestTime: 0, exercises: [AVExerciseModel(name: "none", duration: 0)], exerciseRestTime: 0, coolDownTime: 0)
//            if newModel.warmupTime != 0 {
//                self.captionLabelText = "WARMUP"
//            } else {
//                let exerciseName = newModel.exercises[0].exerciseName
//                self.captionLabelText = exerciseName != "" ? exerciseName : "No exercises"
//            }
//            
//            let countDownTime = newModel.warmupTime != 0 ? newModel.warmupTime : newModel.exercises[0].exerciseDuration
//            self.countDownTimerLabelText = self.secondsToTimeString(seconds: countDownTime)
//            self.totalCountDownTimerLabelText = self.secondsToTimeString(seconds: newModel.summaryDuration)
//            self.totalCountDownTime = newModel.summaryDuration
//            
//            self.exerciseCountDown = countDownTime
//            self.activityCountDown = newModel.summaryDuration
//            self.timeIntervals = newModel.timeIntervals
        }
    }
    
    var isStopped = false
    var isFirstRun = true
    var isRunning: Bool {
        didSet {
            if !isStopped {
                self.stopButton.isHidden = !isRunning
                self.pauseButton.isHidden = !isRunning
                self.startButton.isHidden = isRunning
                if isFirstRun {
                    self.startButton.setTitle("RESUME", for: UIControlState.normal)
                    isFirstRun = false
                }
            }
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.isRunning = true
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.isRunning = true
        super.init(coder: aDecoder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let firstTimeInterval = self.timeIntervals.first {
            self.captionLabel.text = firstTimeInterval.name
            self.captionLabel.adjustsFontSizeToFitWidth = true
            self.countDownTimerLabel.text = self.secondsToTimeString(seconds: Int(firstTimeInterval.duration))
            self.totalCountDownTimerLabel.text = self.secondsToTimeString(seconds: self.totalCountDownTime)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "TIMER"

        // Do any additional setup after loading the view.
    }

    func countDown() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) { () -> Void in
            if self.isRunning {
                if self.exerciseCountDown == 0 {
                    self.nextTimeInterval()
                }

                self.exerciseCountUp += 1
                self.countUpTimerLabel.text = self.secondsToTimeString(seconds: self.exerciseCountUp)
                self.exerciseCountDown -= 1
                self.countDownTimerLabel.text = self.secondsToTimeString(seconds: self.exerciseCountDown)
                self.activityCountDown -= 1
                self.totalCountDownTimerLabel.text = self.secondsToTimeString(seconds: self.activityCountDown)

                self.countDown()
            }
        }
    }
    
    func nextTimeInterval() {
        self.currentTimeIntervalIndex += 1
        if self.currentTimeIntervalIndex < self.timeIntervals.count {
            let currentExercise = self.timeIntervals[self.currentTimeIntervalIndex]
            self.captionLabel.text = currentExercise.name
            self.countDownTimerLabel.text = self.secondsToTimeString(seconds: Int(currentExercise.duration))
            self.exerciseCountDown = Int(currentExercise.duration)
            self.countUpTimerLabel.text = "00:00"
            self.exerciseCountUp = 0
        } else {
            self.isStopped = true
            self.isRunning = false
            self.captionLabel.text = "END"
            self.countUpTimerLabel.text = "00:00"
            self.pauseButton.isUserInteractionEnabled = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onStartButton(_ sender: Any) {
        self.isRunning = true
        self.countDown()
    }
    
    @IBAction func onPauseButton(_ sender: Any) {
        self.isRunning = false
    }
    
    @IBAction func onStopButton(_ sender: Any) {
        if isStopped {
            _ = self.navigationController?.popViewController(animated: true)
        } else {
            self.startButton.setTitle("START", for: UIControlState.normal)
            self.currentTimeIntervalIndex = -1
            self.nextTimeInterval()
            self.totalCountDownTimerLabel.text = self.totalCountDownTimerLabelText
            self.activityCountDown = self.totalCountDownTime
            self.isRunning = false
            self.isFirstRun = true
        }
    }
}
