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
    @IBOutlet weak var addExerciseButton: UIButton!
    
    var exerciseName = "Exercise"
    var exerciseDuration = 20
    
    var addExerciseButtonAction: ((AnyObject?) -> ())?
    
//	MARK: View Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.exerciseDurationLabel.text = self.secondsToTimeString(seconds: self.exerciseDuration)
    }
    
//	MARK: Interface Handling

    @IBAction func onExerciseDurationPlusButton(_ sender: Any) {
        self.exerciseDuration = self.timeLabelChangeWithFunction(oldValue: self.exerciseDuration,
                                                         function: +,
                                                         label: self.exerciseDurationLabel)
    }
    
    @IBAction func onExerciseDurationMinusButton(_ sender: Any) {
        self.exerciseDuration = self.timeLabelChangeWithFunction(oldValue: self.exerciseDuration,
                                                         function: -,
                                                         label: self.exerciseDurationLabel)
    }

    @IBAction func onAddExerciseButton(_ sender: Any) {
        if let action = self.addExerciseButtonAction {
            action(self)
        }
    }

}
