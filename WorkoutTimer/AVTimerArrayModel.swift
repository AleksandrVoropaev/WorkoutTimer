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
    
//    var objects: NSMutableArray<TimerModel>
    
    func load() {
        
//        let moc = managedObjectContext
//        let employeesFetch = NSFetchRequest(entityName: "Employee")
//        
//        do {
//            let fetchedEmployees = try moc.executeFetchRequest(employeesFetch) as! [AAAEmployeeMO]
//        } catch {
//            fatalError("Failed to fetch employees: \(error)")
//        }
//
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TimerModel")
        let fetchRequest: NSFetchRequest<TimerModel> = TimerModel.fetchRequest()

        do {
            let timers = try(context.execute(fetchRequest))// as! [TimerModel]
            self.objects.addObjects(from: timers.accessibilityElements as! [TimerModel])
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
    
}
