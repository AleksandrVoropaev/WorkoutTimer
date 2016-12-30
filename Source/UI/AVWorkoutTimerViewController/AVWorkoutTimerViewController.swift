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
    
    var timeIntervals: Array<AVTimeIntervalModel> = []
    var totalCountDownTime: Int = 0
    var exerciseCountDown: Int = 0
    var exerciseCountUp: Int = 0
    var activityCountDown: Int = 0
    var currentTimeIntervalIndex: Int = 0
    
    var model: TimerModel? {
        didSet {
            if let newModel = model {
                self.timeIntervals = newModel.timeIntervals
                self.totalCountDownTime = newModel.totalDuration
                self.activityCountDown = self.totalCountDownTime
                self.exerciseCountDown = newModel.timeIntervals.first?.duration ?? 0
            }
        }
    }
    
    var isStopped = false // true when timer is stopped
    var isFirstRun = true
    var isRunning: Bool { // false when timer is paused (not stopped)
        didSet {
            if !isStopped {
                self.stopButton.isHidden = !isRunning
                self.pauseButton.isHidden = !isRunning
                self.startButton.isHidden = isRunning
                if isFirstRun {
                    self.startButton.setTitle("RESUME", for: UIControlState.normal)
                    self.isFirstRun = false
                }
            }
        }
    }

//	MARK: Initializations and Deallocations

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.isRunning = true
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.isRunning = true
        super.init(coder: aDecoder)
    }
    
//	MARK: View Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        if let firstTimeInterval = self.timeIntervals.first {
            self.captionLabel.text = firstTimeInterval.name
            self.captionLabel.adjustsFontSizeToFitWidth = true
            self.countDownTimerLabel.text = self.secondsToTimeString(seconds: firstTimeInterval.duration)
            self.totalCountDownTimerLabel.text = self.secondsToTimeString(seconds: self.totalCountDownTime)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "TIMER"
    }
    
//	MARK: Interface Handling
    
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
            self.totalCountDownTimerLabel.text = self.secondsToTimeString(seconds: self.model?.totalDuration ?? 0)

            self.activityCountDown = self.totalCountDownTime
            self.isRunning = false
            self.isFirstRun = true
        }
    }
    
//	MARK: Private

    fileprivate func countDown() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .milliseconds(900)) { () -> Void in
            if self.isRunning {
                if self.exerciseCountDown == 0 {
                    self.nextTimeInterval()
                } else {
                    let countUp = self.exerciseCountUp + 1
                    self.countUpTimerLabel.text = self.secondsToTimeString(seconds: countUp)
                    self.exerciseCountUp = countUp
                    let countDown = self.exerciseCountDown - 1
                    self.countDownTimerLabel.text = self.secondsToTimeString(seconds: countDown)
                    self.exerciseCountDown = countDown
                    let activityCountDown = self.activityCountDown - 1
                    self.totalCountDownTimerLabel.text = self.secondsToTimeString(seconds: activityCountDown)
                    self.activityCountDown = activityCountDown
                }
                
                self.countDown()
            }
        }
    }
    
    fileprivate func nextTimeInterval() {
        let currentTimeIntervalIndex = self.currentTimeIntervalIndex + 1
        self.currentTimeIntervalIndex = currentTimeIntervalIndex
        if currentTimeIntervalIndex < self.timeIntervals.count {
            let currentExercise = self.timeIntervals[currentTimeIntervalIndex]
            self.captionLabel.text = currentExercise.name
            self.countDownTimerLabel.text = self.secondsToTimeString(seconds: currentExercise.duration)
            self.exerciseCountDown = currentExercise.duration
            self.countUpTimerLabel.text = "00:00"
            self.exerciseCountUp = 0
        } else {
            self.isStopped = true
            self.isRunning = false
            self.captionLabel.text = "END"
            self.countUpTimerLabel.text = "00:00"
            self.countDownTimerLabel.text = "00:00"
            self.totalCountDownTimerLabel.text = "00:00"
            self.pauseButton.isUserInteractionEnabled = false
        }
    }
    
}
