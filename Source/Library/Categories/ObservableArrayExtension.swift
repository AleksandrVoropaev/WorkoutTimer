//
//  ObservableArrayExtension.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 12/28/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import Foundation

extension ObservableArray {

//	MARK: Public
    
    public mutating func replaceAllElements(_ newElements: [Element], atIndex i: Int) {
        self.removeAll(keepingCapacity: false)
        self.appendContentsOf(newElements)
    }

}
