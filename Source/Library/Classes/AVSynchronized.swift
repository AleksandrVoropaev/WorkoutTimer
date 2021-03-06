//
//  File.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 12/30/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import Foundation

class AVSynchronized {
    
//	MARK: Class methods

    static func sync(lock: AnyObject, closure: () -> Void) {
        objc_sync_enter(lock)
        closure()
        objc_sync_exit(lock)
    }
    
    static func syncAndReturn<T>(lock: AnyObject, closure: () -> T) -> T {
        objc_sync_enter(lock)
        let result: T = closure()
        objc_sync_exit(lock)
        
        return result
    }
    
}
