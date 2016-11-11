//
//  AVScheduledTimerTableViewCell.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 11/9/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import UIKit

class AVScheduledTimerTableViewCell: UITableViewCell {

    @IBOutlet weak var timerNameLabel: UILabel!
    @IBOutlet weak var warmupLabel: UILabel!
    @IBOutlet weak var setsCountLabel: UILabel!
    @IBOutlet weak var restLabel: UILabel!
    @IBOutlet weak var coolDownLabel: UILabel!
    @IBOutlet weak var exerciseDurationLabel: UILabel!
    @IBOutlet weak var exerciseNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
