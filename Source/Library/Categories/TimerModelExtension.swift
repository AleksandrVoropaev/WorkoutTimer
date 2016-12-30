//
//  AVCoreDataTimerExtension.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 11/30/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension TimerModel {
    
    var timeIntervals: Array<AVTimeIntervalModel> {
        var result = Array<AVTimeIntervalModel>()
        if self.warmupTime > 0 {
            result.append(AVTimeIntervalModel(name: "WARMUP", duration: Int(self.warmupTime)))
        }
        
        if let exercises = self.exercises, exercises.count > 0 {
            let exercisesLastIndex = exercises.count - 1
            let setsLastIndex = self.setsCount - 1
            for setsIterator in 0...(self.setsCount - 1) {
                for exerciseIterator in 0...(exercisesLastIndex) {
                    let name = (exercises[exerciseIterator] as! ExerciseModel).name ?? "Work"
                    let duration = (exercises[exerciseIterator] as! ExerciseModel).duration
                    result.append(AVTimeIntervalModel(name: name, duration: Int(duration)))
                    
                    if exercisesLastIndex != exerciseIterator {
                        result.append(AVTimeIntervalModel(name: "REST",
                                                     duration: Int(self.exerciseRestTime)))
                    } else if setsIterator != setsLastIndex {
                        if self.setRestTime == 0 {
                            result.append(AVTimeIntervalModel(name: "REST",
                                                         duration: Int(self.exerciseRestTime)))
                        } else {
                            result.append(AVTimeIntervalModel(name: "Next Set in:",
                                                         duration: Int(self.setRestTime)))
                        }
                    }
                }
                
            }
        }
        
        if self.coolDownTime > 0 {
            result.append(AVTimeIntervalModel(name: "COOL DOWN", duration: Int(self.coolDownTime)))
        }

        return result
    }
    
    var totalDuration: Int {
        var totalDuration = 0
        self.timeIntervals.forEach {
            totalDuration += $0.duration
        }
        
        return totalDuration
    }
    
    class func setupTestTabataTimer() {
        if let timer = TimerModel.mr_createEntity() {
            timer.id = 0
            timer.name = "Tabata Timer"
            timer.warmupTime = 30
            timer.setsCount = 8
            
            self.setupTestExercise(name: "Work", duration: 20, timerModel: timer)

            timer.exerciseRestTime = 10
            timer.setRestTime = 0
            timer.coolDownTime = 30
        }
    }
    
    class func setupTestScheduledTimer() {
        if let timer = TimerModel.mr_createEntity() {
            timer.id = 1
            timer.name = "Scheduled Timer"
            timer.warmupTime = 30
            timer.setsCount = 3
            
            self.setupTestExercise(name: "First Exercise", duration: 15, timerModel: timer)
            self.setupTestExercise(name: "Second Exercise", duration: 20, timerModel: timer)
            self.setupTestExercise(name: "Third Exercise", duration: 25, timerModel: timer)
            
            timer.exerciseRestTime = 10
            timer.setRestTime = 30
            timer.coolDownTime = 30
        }
    }
    
    class func setupTestExercise(name: String, duration: Int16, timerModel: TimerModel) {
        if let exercise = ExerciseModel.mr_createEntity() {
            exercise.duration = duration
            exercise.name = name
            exercise.timerModel = timerModel
        }
    }

}
