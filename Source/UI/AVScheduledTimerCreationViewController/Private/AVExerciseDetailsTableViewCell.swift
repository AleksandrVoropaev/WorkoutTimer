//
//  AVExerciseDetailsTableViewCell.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 11/9/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import UIKit

class AVExerciseDetailsTableViewCell: UITableViewCell, AVCellsFill {

    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var exerciseDurationLabel: UILabel!
    
    var exerciseModel: ExerciseModel?
    
    public func fillWithModel(model: ExerciseModel) {
        self.exerciseDurationLabel.text = self.secondsToTimeString(seconds: Int(model.duration))
        self.exerciseNameLabel.text = model.name
    }
    
}
