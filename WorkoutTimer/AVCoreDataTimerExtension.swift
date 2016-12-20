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
    
    var timeIntervals: Array<AVTimeInterval> {
        var result = Array<AVTimeInterval>()
        if self.warmupTime > 0 {
            result.append(AVTimeInterval(name: "WARMUP", duration: Int(self.warmupTime)))
        }
        
        if let exercises = self.exercises, exercises.count > 0 {
            let exercisesLastIndex = exercises.count - 1
            for setsIterator in 0...(self.setsCount - 1) {
                for exerciseIterator in 0...(exercisesLastIndex) {
                    let name = (exercises[exerciseIterator] as! ExerciseModel).name ?? "no name"
                    let duration = (exercises[exerciseIterator] as! ExerciseModel).duration
                    result.append(AVTimeInterval(name: name, duration: Int(duration)))
                    
                    if exercisesLastIndex != exerciseIterator {
                        result.append(AVTimeInterval(name: "REST", duration: Int(self.exerciseRestTime)))
                    } else if setsIterator != (self.setsCount - 1) {
                        if self.setRestTime == 0 {
                            result.append(AVTimeInterval(name: "REST", duration: Int(self.exerciseRestTime)))
                        } else {
                            result.append(AVTimeInterval(name: "Next Set in:", duration: Int(self.setRestTime)))
                        }
                    }
                }
                
                if self.coolDownTime > 0 {
                    result.append(AVTimeInterval(name: "COOL DOWN", duration: Int(self.coolDownTime)))
                }
            }
        }
        
        return result
    }
    
//    private func timeInterval(name: String, duration: Int16) -> ExerciseModel {
//        let result = ExerciseModel()
//        result.name = name
//        result.duration = duration
//        
//        return result
//    }
    
//    func addExercise(exerciseName: String, exerciseDuration: Int) {
//        self.exercises.append(AVExerciseModel(name: exerciseName, duration: exerciseDuration))
//    }
    
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
//        let delegate = UIApplication.shared.delegate as! AppDelegate
//        
//        let context = delegate.persistentContainer.viewContext
//        let timer = NSEntityDescription.insertNewObject(forEntityName: "TimerModel", into: context) as! TimerModel
//        
//        timer.name = "Tabata Timer"
//        timer.warmupTime = 30
//        timer.setsCount = 8
//        
//        self.setupTestExercise(context: context, name: "Work", duration: 20, timerModel: timer)
//
//        timer.exerciseRestTime = 10
//        timer.setRestTime = 0
//        timer.coolDownTime = 30
//        
//        do {
//            try context.save()
//        } catch {
//            print(error)
//        }
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
        
//        let delegate = UIApplication.shared.delegate as! AppDelegate
//        
//        let context = delegate.persistentContainer.viewContext
//        let timer = NSEntityDescription.insertNewObject(forEntityName: "TimerModel", into: context) as! TimerModel
//        
//        timer.name = "Scheduled Timer"
//        timer.warmupTime = 30
//        timer.setsCount = 3
//        
//        self.setupTestExercise(context: context, name: "First Exercise", duration: 15, timerModel: timer)
//        self.setupTestExercise(context: context, name: "Second Exercise", duration: 20, timerModel: timer)
//        self.setupTestExercise(context: context, name: "Third Exercise", duration: 25, timerModel: timer)
//        
//        timer.exerciseRestTime = 10
//        timer.setRestTime = 30
//        timer.coolDownTime = 30
//        
//        do {
//            try context.save()
//        } catch {
//            print(error)
//        }
    }
    
    class func setupTestExercise(name: String, duration: Int16, timerModel: TimerModel) {
        if let exercise = ExerciseModel.mr_createEntity() {
            exercise.duration = duration
            exercise.name = name
            exercise.timerModel = timerModel
        }
    }

//    class func setupTestExercise(context: NSManagedObjectContext, name: String, duration: Int16, timerModel: TimerModel) {
//        let exercise = NSEntityDescription.insertNewObject(forEntityName: "ExerciseModel", into: context) as! ExerciseModel
//        exercise.duration = duration
//        exercise.name = name
//        exercise.timerModel = timerModel
//    }
    
}

extension ExerciseModel {
}
