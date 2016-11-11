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
    @IBOutlet weak var restLabel: UILabel!
    @IBOutlet weak var coolDownLabel: UILabel!
    @IBOutlet weak var execiseNameLabel: UILabel!
    @IBOutlet weak var exerciseDurationLabel: UILabel!
    
    var model = AVScheduledTimerModel(name: "none",
                                      warmupTime: 30,
                                      setsCount: 3,
                                      restTime: 10,
                                      coolDownTime: 30) {
        didSet {
            self.timerNameLabel.text = model.name
            self.warmupLabel.text = self.secondsToTimeString(seconds: model.warmupTime)
            self.setsLabel.text = String(model.setsCount)
            self.restLabel.text = self.secondsToTimeString(seconds: model.restTime)
            self.coolDownLabel.text = self.secondsToTimeString(seconds: model.coolDownTime)
            
            var exerciseNames = ""
            var exerciseTimes = ""
            for (index, exercise) in model.exercises.enumerated() {
                exerciseNames += exercise.exerciseName
                exerciseTimes += self.secondsToTimeString(seconds: exercise.exerciseDuration)
                if index < model.exercises.count - 1 {
                    exerciseNames += "\r\n"
                    exerciseTimes += "\r\n"
                }
            }
            
            self.execiseNameLabel.text = exerciseNames
            self.exerciseDurationLabel.text = exerciseTimes
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
