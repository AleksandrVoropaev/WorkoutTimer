//
//  AppDelegate.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 11/9/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import UIKit
import MagicalRecord

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let model = AVObservableTimersArrayModel()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        MagicalRecord.setupCoreDataStack(withStoreNamed: "AVWorkoutTimerModel")
        let model = self.model
//        model.erase()
        model.load()
        if model.timers.count == 0 {
            TimerModel.setupTestTabataTimer()
            TimerModel.setupTestScheduledTimer()
            model.load()
        }

        let viewController = AVWorkoutSelectionViewController()
        viewController.model = model
        let navigationController = UINavigationController(rootViewController: viewController)
        let window = self.window
        window?.rootViewController = navigationController

        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        self.saveModelInBackgroud(application)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        self.saveModelInBackgroud(application)
    }
    
    func saveModelInBackgroud(_ application: UIApplication) {
        let backgroundTask = application.beginBackgroundTask {}
        DispatchQueue.global().sync {
            self.model.save()
            application.endBackgroundTask(backgroundTask)
        }
    }
    
}
