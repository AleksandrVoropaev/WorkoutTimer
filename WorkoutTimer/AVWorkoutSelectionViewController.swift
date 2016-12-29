//
//  AVWorkoutSelectionViewController.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 11/9/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import UIKit

class AVWorkoutSelectionViewController: UIViewController {

//    var model: AVTimerArrayModel?
    var observableModel: AVObservableTimersArrayModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onTabataButton(_ sender: Any) {
        let tabataTimerController = AVTabataTimerViewController()
//        tabataTimerController.timerArray = self.model
        tabataTimerController.observableModel = self.observableModel
        self.navigationController?.pushViewController(tabataTimerController, animated: true)
    }

    @IBAction func onScheduledButton(_ sender: Any) {
        let scheduledTimerController = AVScheduledTimersViewController()
//        scheduledTimerController.model = self.model
        scheduledTimerController.observableModel = self.observableModel
        self.navigationController?.pushViewController(scheduledTimerController, animated: true)
    }
    
    @IBAction func onExercisesButton(_ sender: Any) {
        let layout = UICollectionViewFlowLayout()
        let exercisesViewController = AVYoutubeExercisesViewController(collectionViewLayout: layout)
        self.navigationController?.pushViewController(exercisesViewController, animated: true)
    }

}
