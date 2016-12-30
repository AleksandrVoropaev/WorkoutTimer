//
//  AVObservableTimersArrayModel.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 12/28/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import UIKit
import CoreData
import MagicalRecord

class AVObservableTimersArrayModel {
    
    var timers = ObservableArray<TimerModel>()
    
    func load() {
        if let timers = TimerModel.mr_findAllSorted(by: "id", ascending: true) {
            self.timers.removeAll(keepingCapacity: false)
            self.timers.appendContentsOf(timers as! [TimerModel])
        }
    }
    
    func save() {
        var timerId: Int16 = 0
        self.timers.forEach {
            $0.mr_deleteEntity()
            if let timer = TimerModel.mr_createEntity() {
                timer.id = timerId
                timerId += 1
                timer.name = $0.name
                timer.warmupTime = $0.warmupTime
                timer.setsCount = $0.setsCount
                
                var exerciseId: Int16 = 0
                $0.exercises?.forEach {
                    if let exercise = ExerciseModel.mr_createEntity() {
                        exercise.id = exerciseId
                        exerciseId += 1
                        exercise.name = ($0 as! ExerciseModel).name
                        exercise.duration = ($0 as! ExerciseModel).duration
                        exercise.timerModel = timer
                    }
                }
                
                timer.exerciseRestTime = $0.exerciseRestTime
                timer.setRestTime = $0.setRestTime
                timer.coolDownTime = $0.coolDownTime
            }
            
            NSManagedObjectContext.mr_default().mr_saveToPersistentStoreAndWait()
        }
    }
    
    func addTimer(name: String,
                  warmupTime: Int64,
                  setsCount: Int16,
                  exercises: [AVTimeIntervalModel],
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
            
            self.timers.append(timer)
        }
    }
    
    func remove(timer: TimerModel) {
        timer.mr_deleteEntity()
        if let index = self.timers.index(of: timer) {
            _ = self.timers.remove(at: index)
        }
    }
    
    func removeTimer(at index: Int) {
        self.timers[index].mr_deleteEntity()
        _ = self.timers.remove(at: index)
    }
    
    func erase() {
        TimerModel.mr_truncateAll()
        self.timers.removeAll(keepingCapacity: false)
    }
    
    func moveTimer(from index: Int, to targetIndex: Int) {
        self.timers.insert(self.timers.remove(at: index), at: targetIndex)
    }
    
}
