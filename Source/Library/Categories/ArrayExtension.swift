//
//  ArrayExtension.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 12/30/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import Foundation

extension Array {
    
    func firstObjectWithClass(cls:AnyClass) -> Any? {
        return self.first(where: { (evaluatedObject) -> Bool in
            return type(of: evaluatedObject) == cls
        })
    }
    
}
