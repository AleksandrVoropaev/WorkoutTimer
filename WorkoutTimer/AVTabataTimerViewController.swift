//
//  AVTabataTimerViewController.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 11/9/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import UIKit

class AVTabataTimerViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "SET UP TIMER"

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onStartButton(_ sender: Any) {
        let workoutTimerController = AVWorkoutTimerViewController()
        self.navigationController?.pushViewController(workoutTimerController, animated: true)
    }
}
