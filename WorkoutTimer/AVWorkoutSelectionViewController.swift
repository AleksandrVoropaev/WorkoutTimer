//
//  AVWorkoutSelectionViewController.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 11/9/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import UIKit

class AVWorkoutSelectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTabataButton(_ sender: Any) {
        let tabataTimerController = AVTabataTimerViewController()
        self.navigationController?.pushViewController(tabataTimerController, animated: true)
    }

    @IBAction func onScheduledButton(_ sender: Any) {
        let scheduledTimerController = AVScheduledTimersViewController()
        self.navigationController?.pushViewController(scheduledTimerController, animated: true)
    }
    
    @IBAction func onExercisesButton(_ sender: Any) {
        let exercisesViewController = AVYoutubeExercisesViewController()
        self.navigationController?.pushViewController(exercisesViewController, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
