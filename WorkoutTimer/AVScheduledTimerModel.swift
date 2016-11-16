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
        var setTime = 0
        self.exercises.forEach { setTime += $0.exerciseDuration + self.exerciseRestTime }
        setTime -= self.exerciseRestTime
        
        return self.warmupTime + (setTime + self.setsRestTime) * self.setsCount - self.setsRestTime  + self.coolDownTime
    }
    var timeIntervals: Array<AVExerciseModel> {
        var result:Array<AVExerciseModel> = [AVExerciseModel.init(name: "WARMUP", duration: self.warmupTime)]
        
        for setsIterator in 0...(self.setsCount - 1) {
            for exerciseIterator in 0...(self.exercises.count - 1) {
                result.append(self.exercises[exerciseIterator])
                let exercisesLastIndex = self.exercises.endIndex - 1
                if exercisesLastIndex != exerciseIterator {
                    result.append(AVExerciseModel.init(name: "REST", duration: self.exerciseRestTime))
                } else if setsIterator != (self.setsCount - 1) {
                    result.append(AVExerciseModel.init(name: "Next Set in:", duration: self.setsRestTime))
                } else {
                    result.append(AVExerciseModel.init(name: "COOL DOWN", duration: self.coolDownTime))
                }
            }
        }
        
        return result
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
