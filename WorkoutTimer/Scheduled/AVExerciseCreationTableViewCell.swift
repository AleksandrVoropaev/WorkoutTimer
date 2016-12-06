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
    
    let model = AVTimeInterval(name: "none", duration: 0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onExerciseDurationPlusButton(_ sender: Any) {
        self.model.duration = self.timeLabelChangeWithFunction(oldValue: self.model.duration,
                                                         function: +,
                                                         label: self.exerciseDurationLabel)
    }
    
    @IBAction func onExerciseDurationMinusButton(_ sender: Any) {
        self.model.duration = self.timeLabelChangeWithFunction(oldValue: self.model.duration,
                                                         function: -,
                                                         label: self.exerciseDurationLabel)
    }
    
    @IBAction func onAddExerciseButton(_ sender: Any) {
        self.model.name = self.exerciseNameField.text ?? "none"
    }
}
