//
//  AVTimerArrayModel.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 12/2/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import UIKit
import CoreData

class AVTimerArrayModel: AVArrayModel {
    
    func load() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<TimerModel> = TimerModel.fetchRequest()

        do {
            let timers = try context.fetch(fetchRequest)
            self.replaceAllObjects(with: timers)
        } catch {
            print(error)
        }
    }
    
    func save() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        self.objects.forEach {
            let timer = NSEntityDescription.insertNewObject(forEntityName: "TimerModel", into: context) as! TimerModel
            
            timer.name = ($0 as! TimerModel).name
            timer.warmupTime = ($0 as! TimerModel).warmupTime
            timer.setsCount = ($0 as! TimerModel).setsCount
            
            ($0 as! TimerModel).exercises?.forEach {
                let exercise = NSEntityDescription.insertNewObject(forEntityName: "ExerciseModel", into: context) as! ExerciseModel
                
                exercise.name = ($0 as! ExerciseModel).name
                exercise.duration = ($0 as! ExerciseModel).duration
                exercise.timerModel = timer
            }
            
            timer.exerciseRestTime = ($0 as! TimerModel).exerciseRestTime
            timer.setRestTime = ($0 as! TimerModel).setRestTime
            timer.coolDownTime = ($0 as! TimerModel).coolDownTime
            
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
    
    func erase() {
        self.load()
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        self.objects.forEach {
            context.delete($0 as! NSManagedObject)
        }
        
        
//        do {
//            self.objects.forEach {
//                try context.delete($0 as! NSManagedObject)
//            }
//        } catch {
//            print(error)
//        }
    }
    
}
