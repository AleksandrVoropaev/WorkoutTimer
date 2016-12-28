//
//  AppDelegate.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 11/9/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import UIKit
import CoreData
import MagicalRecord

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let model = AVTimerArrayModel()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        MagicalRecord.setupCoreDataStack(withStoreNamed: "AVWorkoutTimerModel")
        
//        self.model.erase()
//        TimerModel.setupTestTabataTimer()
//        TimerModel.setupTestScheduledTimer()
        self.model.load()

        let viewController = AVWorkoutSelectionViewController()
        viewController.model = self.model
        let navigationController = UINavigationController(rootViewController: viewController)
        
        let window = self.window
        window?.rootViewController = navigationController
//        application.statusBarStyle = UIStatusBarStyle.lightContent
//        window?.makeKeyAndVisible()

//        self.window = UIWindow(frame: UIScreen.main.bounds)
//        self.window?.rootViewController = UINavigationController(rootViewController: AVWorkoutTimerViewController())
//        self.window?.makeKeyAndVisible()

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        self.model.save()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        self.model.save()
    }
    
}
