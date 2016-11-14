//
//  AVWorkoutTimerViewController.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 11/9/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import UIKit

class AVWorkoutTimerViewController: UIViewController {

    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var countDownTimerLabel: UILabel!
    @IBOutlet weak var countUpTimerLabel: UILabel!
    @IBOutlet weak var totalCountDownTimerLabel: UILabel!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var resumeButton: UIButton!
    
    var isFirstRun = true
    var model: AVScheduledTimerModel? {
        didSet {
            let newModel = model ?? AVScheduledTimerModel(name: "none", warmupTime: 0, setsCount: 0, setsRestTime: 0, exercises: [AVExerciseModel(name: "none", duration: 0)], exerciseRestTime: 0, coolDownTime: 0)
            let firstExercise = model?.exercises[0] ?? AVExerciseModel(name: "nonenone", duration: 0)
            let string: String = firstExercise.exerciseName
            print(string)
            if string != "" {
                self.captionLabel.text = string
            }
//            self.captionLabel.text = String(string) != "" ? String(string) : "WARMUP"
//            self.captionLabel.text = newModel.exercises.first?.exerciseName ?? "WARMUP"
            
//            let exerciseDuration = newModel.exercises.first?.exerciseDuration ?? 0
            let countDown = newModel.warmupTime == 0 ? newModel.warmupTime : newModel.exercises.first?.exerciseDuration ?? 0
            self.countDownTimerLabel.text = String(countDown)
            self.totalCountDownTimerLabel.text = String(newModel.summaryDuration)
        }
    }
    
    
    var isRunning: Bool {
        didSet {
            self.stopButton.isHidden = isRunning
            self.resumeButton.isHidden = isRunning
            self.pauseButton.isHidden = !isRunning
            if isFirstRun {
                self.pauseButton.setTitle("PAUSE", for: UIControlState.normal)
                isFirstRun = false
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "TIMER"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPauseButton(_ sender: Any) {
        self.isRunning = false
    }
    
    @IBAction func onResumeButton(_ sender: Any) {
        self.isRunning = true
    }
    
    @IBAction func onStopButton(_ sender: Any) {
        self.isRunning = true
    }
}
