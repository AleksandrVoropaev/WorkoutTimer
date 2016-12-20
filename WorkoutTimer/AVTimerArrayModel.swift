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
//        if let timers = TimerModel.mr_find(byAttribute: "createdDate", withValue: "", andOrderBy: nil, ascending: true) {
//            self.replaceAllObjects(with: timers)
//
//        }

        if let timers = TimerModel.mr_findAllSorted(by: "id", ascending: true) {
            self.replaceAllObjects(with: timers)
        }
        
        let anotherTimers = TimerModel.mr_findAll() as! [TimerModel]
//        self.replaceAllObjects(with: timers)
        
//        let delegate = UIApplication.shared.delegate as! AppDelegate
//        let context = delegate.persistentContainer.viewContext
//        let fetchRequest: NSFetchRequest<TimerModel> = TimerModel.fetchRequest()
//
//        do {
//            let timers = try context.fetch(fetchRequest)
//            self.replaceAllObjects(with: timers)
//        } catch {
//            print(error)
//        }
    }
    
    func save() {
//        TimerModel.mr_truncateAll()
        var timerId: Int16 = 0
        self.objects.forEach {
            ($0 as! NSManagedObject).mr_deleteEntity()
            if let timer = TimerModel.mr_createEntity() {
//                let timerid = TimerModel.mr_countOfEntities()
//                timer.id = Int16(TimerModel.mr_countOfEntities())
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
            
//            NSManagedObjectContext.defaultContext().saveToPersistentStoreAndWait()
//            NSManagedObjectContext.mr_default().save()
            NSManagedObjectContext.mr_default().mr_saveToPersistentStoreAndWait()
        }
        
//        let delegate = UIApplication.shared.delegate as! AppDelegate
//        let context = delegate.persistentContainer.viewContext
//        
//        self.objects.forEach {
//            context.delete($0 as! NSManagedObject)
//
//            let timer = NSEntityDescription.insertNewObject(forEntityName: "TimerModel", into: context) as! TimerModel
//            
//            timer.name = ($0 as! TimerModel).name
//            timer.warmupTime = ($0 as! TimerModel).warmupTime
//            timer.setsCount = ($0 as! TimerModel).setsCount
//            
//            ($0 as! TimerModel).exercises?.forEach {
//                let exercise = NSEntityDescription.insertNewObject(forEntityName: "ExerciseModel", into: context) as! ExerciseModel
//                
//                exercise.name = ($0 as! ExerciseModel).name
//                exercise.duration = ($0 as! ExerciseModel).duration
//                exercise.timerModel = timer
//            }
//            
//            timer.exerciseRestTime = ($0 as! TimerModel).exerciseRestTime
//            timer.setRestTime = ($0 as! TimerModel).setRestTime
//            timer.coolDownTime = ($0 as! TimerModel).coolDownTime
//            
//            do {
//                try context.save()
//            } catch {
//                print(error)
//            }
//        }
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
//        let delegate = UIApplication.shared.delegate as! AppDelegate
//        let context = delegate.persistentContainer.viewContext
//        
//        let timer = NSEntityDescription.insertNewObject(forEntityName: "TimerModel", into: context) as! TimerModel
//        
//        timer.name = name
//        timer.warmupTime = warmupTime
//        timer.setsCount = setsCount
//        
//        exercises.forEach {
//            let exercise = NSEntityDescription.insertNewObject(forEntityName: "ExerciseModel", into: context) as! ExerciseModel
//            exercise.duration = Int16($0.duration)
//            exercise.name = $0.name
//            exercise.timerModel = timer
//
//        }
//        
//        timer.exerciseRestTime = exerciseRestTime
//        timer.setRestTime = setRestTime
//        timer.coolDownTime = coolDownTime
//        
//        do {
//            try context.save()
//        } catch {
//            print(error)
//        }
    }
    
    func delete(timer: TimerModel) {
        timer.mr_deleteEntity()
        self.remove(object: timer)
//        let delegate = UIApplication.shared.delegate as! AppDelegate
//        let context = delegate.persistentContainer.viewContext
//        
//        context.delete(timer)
//        self.remove(object: timer)
    }
    
    func erase() {
        TimerModel.mr_truncateAll()
        self.removeAllObjects()
//        self.load()
//        let delegate = UIApplication.shared.delegate as! AppDelegate
//        let context = delegate.persistentContainer.viewContext
//        
//        self.objects.forEach {
//            context.delete($0 as! NSManagedObject)
//        }
    }
    
}
