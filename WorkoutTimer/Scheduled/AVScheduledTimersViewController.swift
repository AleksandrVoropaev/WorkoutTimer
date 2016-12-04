//
//  AVScheduledTimersViewController.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 11/9/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import UIKit

class AVScheduledTimersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "SELECT TIMER"
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 198
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onAddTimerButton(_ sender: Any) {
        let timerCreationController = AVScheduledTimerCreationViewController()
        self.navigationController?.pushViewController(timerCreationController, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: AVScheduledTimerTableViewCell.self) as! AVScheduledTimerTableViewCell
        let cellModel = AVScheduledTimerModel(name: "Test timer",
                                           warmupTime: 30,
                                           setsCount: 5,
                                           setsRestTime: 30,
                                           restTime: 10,
                                           coolDownTime: 30)
        cellModel.addExercise(exerciseName: "Test Exercise 1", exerciseDuration: 20)
        cellModel.addExercise(exerciseName: "Test Exercise 2", exerciseDuration: 20)
        cellModel.addExercise(exerciseName: "Test Exercise 3", exerciseDuration: 20)
        cellModel.addExercise(exerciseName: "Test Exercise 4", exerciseDuration: 20)
        cellModel.addExercise(exerciseName: "Test Exercise 5", exerciseDuration: 20)

        cell.model = cellModel
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let workoutTimerController = AVWorkoutTimerViewController()
        workoutTimerController.model = (self.tableView.cellForRow(at: indexPath) as! AVScheduledTimerTableViewCell).model
        self.tableView.cellForRow(at: indexPath)?.setSelected(false, animated: true)
        self.navigationController?.pushViewController(workoutTimerController, animated: true)
    }
}
