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
        
//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.estimatedRowHeight = 300
//        tableView.rowHeight = 220
        
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
                                           warmupTime: 27,
                                           setsCount: 5,
                                           setsRestTime: 30,
                                           restTime: 32,
                                           coolDownTime: 35)
        cellModel.addExercise(exerciseName: "Test Exercise 1", exerciseDuration: 22)
        cellModel.addExercise(exerciseName: "Test Exercise 2", exerciseDuration: 23)
        cellModel.addExercise(exerciseName: "Test Exercise 3", exerciseDuration: 24)
        cellModel.addExercise(exerciseName: "Test Exercise 4", exerciseDuration: 25)
        cellModel.addExercise(exerciseName: "Test Exercise 5", exerciseDuration: 26)

        cell.model = cellModel
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190.0
    }

    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        var height: CGFloat
//        var cell = tableView.cellForRow(at: indexPath) as! AVScheduledTimerTableViewCell
//        var count = cell.model.exercises.count
//        var additionalHeight = count * 21
//        height = CGFloat(192 + additionalHeight)
//        return height
//        //        return CGFloat(192 + (tableView.cellForRow(at: indexPath) as! AVScheduledTimerTableViewCell).model.exercises.count * 21)
//    }
    
}
