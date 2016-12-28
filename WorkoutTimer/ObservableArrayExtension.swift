//
//  ObservableArrayExtension.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 12/28/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import Foundation

extension ObservableArray {
    public mutating func replaceAllElements(_ newElements: [Element], atIndex i: Int) {
        self.removeAll(keepingCapacity: false)
        self.appendContentsOf(newElements)
    }

//    public mutating func removeObject(_ element: Element) {
////        let index = self.index(of: element)
////        elements.remove(element)
////        arrayDidChange(ArrayChangeEvent(deleted: [index]))
//        if let index = self.index(of: element) {
//            _ = self.remove(at: index)
//        }
////        _ = self.remove(at: self.index(of: element)!)
//    }
    
//    public mutating func remove(at index: Int) -> Element {
//        let e = elements.remove(at: index)
//        arrayDidChange(ArrayChangeEvent(deleted: [index]))
//        return e
//    }

}
