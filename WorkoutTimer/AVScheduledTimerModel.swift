//
//  AVScheduledTimerModel.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 11/11/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import Foundation

class AVScheduledTimerModel {
    var name: String
    var warmupTime: Int
    var setsCount: Int
    var setsRestTime: Int
    var exercises: Array<AVExerciseModel> = []
    var exerciseRestTime: Int
    var coolDownTime: Int
    var summaryDuration: Int {
        var sum = 0
        self.exercises.forEach { sum += $0.exerciseDuration }
        
        return sum
    }
    
    init(name: String, warmupTime: Int, setsCount: Int, setsRestTime: Int, restTime: Int, coolDownTime: Int) {
        self.name = name
        self.warmupTime = warmupTime
        self.setsCount = setsCount
        self.setsRestTime = setsRestTime
        self.exerciseRestTime = restTime
        self.coolDownTime = coolDownTime
    }
    
    init(name: String, warmupTime: Int, setsCount: Int, setsRestTime: Int, exercises:Array<AVExerciseModel>, exerciseRestTime: Int, coolDownTime: Int) {
        self.name = name
        self.warmupTime = warmupTime
        self.setsCount = setsCount
        self.setsRestTime = setsRestTime
        self.exerciseRestTime = exerciseRestTime
        self.coolDownTime = coolDownTime
        self.exercises.append(contentsOf: exercises)
    }

    func addExercise(exerciseName: String, exerciseDuration: Int) {
        self.exercises.append(AVExerciseModel(name: exerciseName, duration: exerciseDuration))
    }
}
