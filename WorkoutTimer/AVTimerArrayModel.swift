//
//  AVTimerArrayModel.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 12/2/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import UIKit
import CoreData
import MagicalRecord

class AVTimerArrayModel: AVArrayModel {
    
    func load() {
        if let timers = TimerModel.mr_findAllSorted(by: "id", ascending: true) {
            self.replaceAllObjects(with: timers)
        }
    }
    
    func save() {
        var timerId: Int16 = 0
        self.objects.forEach {
            ($0 as! NSManagedObject).mr_deleteEntity()
            if let timer = TimerModel.mr_createEntity() {
                timer.id = timerId
                timerId += 1
                timer.name = ($0 as! TimerModel).name
                timer.warmupTime = ($0 as! TimerModel).warmupTime
                timer.setsCount = ($0 as! TimerModel).setsCount
                
                var exerciseId: Int16 = 0
                ($0 as! TimerModel).exercises?.forEach {
                    if let exercise = ExerciseModel.mr_createEntity() {
                        exercise.id = exerciseId
                        exerciseId += 1
                        exercise.name = ($0 as! ExerciseModel).name
                        exercise.duration = ($0 as! ExerciseModel).duration
                        exercise.timerModel = timer
                    }
                }

                timer.exerciseRestTime = ($0 as! TimerModel).exerciseRestTime
                timer.setRestTime = ($0 as! TimerModel).setRestTime
                timer.coolDownTime = ($0 as! TimerModel).coolDownTime
            }
            
            NSManagedObjectContext.mr_default().mr_saveToPersistentStoreAndWait()
        }
    }
    
    func addTimer(name: String,
                  warmupTime: Int64,
                  setsCount: Int16,
                  exercises: [AVTimeInterval],
                  exerciseRestTime: Int16,
                  setRestTime: Int16,
                  coolDownTime: Int16)
    {
        if let timer = TimerModel.mr_createEntity() {
            timer.id = Int16(TimerModel.mr_countOfEntities())
            timer.name = name
            timer.warmupTime = warmupTime
            timer.setsCount = setsCount

            exercises.forEach {
                if let exercise = ExerciseModel.mr_createEntity() {
                    exercise.duration = Int16($0.duration)
                    exercise.name = $0.name
                    exercise.timerModel = timer
                }
            }

            timer.exerciseRestTime = exerciseRestTime
            timer.setRestTime = setRestTime
            timer.coolDownTime = coolDownTime
        }
    }
    
    func delete(timer: TimerModel) {
        timer.mr_deleteEntity()
        self.remove(object: timer)
    }
    
    func erase() {
        TimerModel.mr_truncateAll()
        self.removeAllObjects()
    }
    
}
