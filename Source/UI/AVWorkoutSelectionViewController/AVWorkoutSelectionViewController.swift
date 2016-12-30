//
//  AVWorkoutSelectionViewController.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 11/9/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import UIKit

class AVWorkoutSelectionViewController: UIViewController {

    var model: AVObservableTimersArrayModel?

//	MARK: Interface Handling
  
    @IBAction func onTabataButton(_ sender: Any) {
        let tabataTimerController = AVTabataTimerViewController()
        tabataTimerController.model = self.model
        self.navigationController?.pushViewController(tabataTimerController, animated: true)
    }

    @IBAction func onScheduledButton(_ sender: Any) {
        let scheduledTimerController = AVScheduledTimersViewController()
        scheduledTimerController.model = self.model
        self.navigationController?.pushViewController(scheduledTimerController, animated: true)
    }
    
    @IBAction func onExercisesButton(_ sender: Any) {
        let layout = UICollectionViewFlowLayout()
        let exercisesViewController = AVYoutubeExercisesViewController(collectionViewLayout: layout)
        self.navigationController?.pushViewController(exercisesViewController, animated: true)
    }

}
