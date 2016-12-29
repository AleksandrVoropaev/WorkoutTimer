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
        
//        self.model.erase()
        self.model.load()
        if self.model.timers.count == 0 {
            TimerModel.setupTestTabataTimer()
            TimerModel.setupTestScheduledTimer()
            self.model.load()
        }

        let viewController = AVWorkoutSelectionViewController()
        viewController.model = self.model
        let navigationController = UINavigationController(rootViewController: viewController)
        let window = self.window
        window?.rootViewController = navigationController

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        self.model.save()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        self.model.save()
    }
    
}
