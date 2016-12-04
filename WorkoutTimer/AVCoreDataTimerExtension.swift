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
    var timeIntervals: Array<AVExerciseModel> {
        var result: Array<AVExerciseModel> = [AVExerciseModel.init(name: "WARMUP", duration: Int(self.warmupTime))]
        if let exercises = self.exercises {
            
            for setsIterator in 0...(self.setsCount - 1) {
                for exerciseIterator in 0...(exercises.count - 1) {
                    result.append(exercises[exerciseIterator] as! AVExerciseModel)
                    let exercisesLastIndex = exercises.count - 1
                    if exercisesLastIndex != exerciseIterator {
                        result.append(AVExerciseModel.init(name: "REST", duration: Int(self.exerciseRestTime)))
                    } else if setsIterator != (self.setsCount - 1) {
                        result.append(AVExerciseModel.init(name: "Next Set in:", duration: Int(self.setRestTime)))
                    } else {
                        result.append(AVExerciseModel.init(name: "COOL DOWN", duration: Int(self.coolDownTime)))
                    }
                }
            }
        }
        
        return result
    }
    
//    func addExercise(exerciseName: String, exerciseDuration: Int) {
//        self.exercises.append(AVExerciseModel(name: exerciseName, duration: exerciseDuration))
//    }
    
    func setupTestTabataTimer() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = delegate.persistentContainer.viewContext
        let timer = NSEntityDescription.insertNewObject(forEntityName: "TimerModel", into: context) as! TimerModel
        
        timer.name = "Tabata Timer"
        timer.warmupTime = 30
        timer.setsCount = 8
        
        self.setupTestExercise(context: context, name: "Work", duration: 20, timerModel: timer)

        timer.exerciseRestTime = 10
        timer.setRestTime = 30
        timer.coolDownTime = 30
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func setupTestScheduledTimer() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = delegate.persistentContainer.viewContext
        let timer = NSEntityDescription.insertNewObject(forEntityName: "TimerModel", into: context) as! TimerModel
        
        timer.name = "Scheduled Timer"
        timer.warmupTime = 30
        timer.setsCount = 3
        
        self.setupTestExercise(context: context, name: "First Exercise", duration: 15, timerModel: timer)
        self.setupTestExercise(context: context, name: "Second Exercise", duration: 20, timerModel: timer)
        self.setupTestExercise(context: context, name: "Third Exercise", duration: 25, timerModel: timer)
        
        timer.exerciseRestTime = 10
        timer.setRestTime = 30
        timer.coolDownTime = 30
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func setupTestExercise(context: NSManagedObjectContext, name: String, duration: Int16, timerModel: TimerModel) {
        let exercise = NSEntityDescription.insertNewObject(forEntityName: "ExerciseModel", into: context) as! ExerciseModel
        exercise.duration = duration
        exercise.name = name
        exercise.timerModel = timerModel
    }
    
}

extension ExerciseModel {
}
