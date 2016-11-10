//
//  AVTimerCreationTableViewCell.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 11/9/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import UIKit

class AVExerciseCreationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var exerciseNameField: UITextField!
    
    @IBOutlet weak var exerciseDurationLabel: UILabel!
    @IBOutlet weak var exerciseDurationDecreaseButton: UIButton!
    @IBOutlet weak var exerciseDurationIncreaseButton: UIButton!
    
    @IBOutlet weak var addExerciseButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
