//
//  AVExerciseDetailsTableViewCell.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 11/9/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import UIKit

class AVExerciseDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var exerciseNameLabel: UILabel!
    @IBOutlet weak var exerciseDurationLabel: UILabel!
    var exerciseModel = AVExerciseModel(name: "none", duration: 0)
    
    func fillWithModel(model: AVExerciseModel) {
        let seconds = model.exerciseDuration % 60
//        var minutes = model.exerciseDuration > 60 ? model.exerciseDuration / 60 : 0
        let minutes = model.exerciseDuration / 60
        self.exerciseDurationLabel.text = "\(minutes) : \(seconds)"
        self.exerciseNameLabel.text = model.exerciseName
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
