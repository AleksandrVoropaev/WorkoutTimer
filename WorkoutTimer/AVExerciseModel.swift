//
//  AVExerciseModel.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 11/11/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import Foundation

class AVExerciseModel {
    var exerciseName: String
    var exerciseDuration: Int
    
    init(name: String, duration: Int) {
        self.exerciseName = name
        self.exerciseDuration = duration
    }
}
