//
//  AVWorkoutTimerViewController.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 11/9/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import UIKit

class AVWorkoutTimerViewController: UIViewController {

    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var resumeButton: UIButton!
    
    var isFirstRun = true
    
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
