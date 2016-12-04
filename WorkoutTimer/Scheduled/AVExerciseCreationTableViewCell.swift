//
//  AVTimerCreationTableViewCell.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 11/9/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import UIKit

class AVExerciseCreationTableViewCell: UITableViewCell, AVCellsFill {

    @IBOutlet weak var exerciseNameField: UITextField!
    @IBOutlet weak var exerciseDurationLabel: UILabel!
    
    let model = AVExerciseModel(name: "none", duration: 30)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onExerciseDurationPlusButton(_ sender: Any) {
        self.model.exerciseDuration = self.timeLabelChangeWithFunction(oldValue: self.model.exerciseDuration,
                                                         function: +,
                                                         label: self.exerciseDurationLabel)
    }
    
    @IBAction func onExerciseDurationMinusButton(_ sender: Any) {
        self.model.exerciseDuration = self.timeLabelChangeWithFunction(oldValue: self.model.exerciseDuration,
                                                         function: -,
                                                         label: self.exerciseDurationLabel)
    }
    
    @IBAction func onAddExerciseButton(_ sender: Any) {
        self.model.exerciseName = self.exerciseNameField.text!
    }
}
