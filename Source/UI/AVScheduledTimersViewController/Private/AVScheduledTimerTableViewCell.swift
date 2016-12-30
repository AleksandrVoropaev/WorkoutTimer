//
//  AVScheduledTimerTableViewCell.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 11/11/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import UIKit

class AVScheduledTimerTableViewCell: UITableViewCell, AVCellsFill {

    @IBOutlet weak var timerNameLabel: UILabel!
    @IBOutlet weak var warmupLabel: UILabel!
    @IBOutlet weak var setsLabel: UILabel!
    @IBOutlet weak var restBetweenSetsLabel: UILabel!
    @IBOutlet weak var restBetweenExercisesLabel: UILabel!
    @IBOutlet weak var coolDownLabel: UILabel!
    @IBOutlet weak var execiseNameLabel: UILabel!
    @IBOutlet weak var exerciseDurationLabel: UILabel!
    
    var model: TimerModel?
        {
        didSet {
            if let model = self.model {
                self.timerNameLabel.text = model.name
                self.warmupLabel.text = self.secondsToTimeString(seconds: Int(model.warmupTime))
                self.setsLabel.text = String(model.setsCount)
                self.restBetweenSetsLabel.text = self.secondsToTimeString(seconds: Int(model.setRestTime))
                self.restBetweenExercisesLabel.text = self.secondsToTimeString(seconds: Int(model.exerciseRestTime))
                self.coolDownLabel.text = self.secondsToTimeString(seconds: Int(model.coolDownTime))
                
                var exerciseNames = ""
                var exerciseTimes = ""
                if let exercises = model.exercises {
                    for (index, exercise) in exercises.enumerated() {
                        exerciseNames += (exercise as! ExerciseModel).name ?? ""
                        exerciseTimes += self.secondsToTimeString(seconds: Int((exercise as! ExerciseModel).duration))
                        if index < exercises.count - 1 {
                            exerciseNames += "\r\n"
                            exerciseTimes += "\r\n"
                        }
                    }
                }
                
                self.execiseNameLabel.text = exerciseNames
                self.exerciseDurationLabel.text = exerciseTimes
            }
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
