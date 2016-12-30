//
//  AVArrayModel.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 12/2/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import UIKit

class AVArrayModel: NSObject {
    
    var objects = NSMutableArray()
        
    func count() -> Int {
        return self.objects.count 
    }
    
    func object(at index: Int) -> Any? {
        return self.objects.object(at: index)
    }
    
    func add(object: Any) {
        self.objects.add(object)
    }
    
    func insert(object: Any, at index: Int) {
        self.objects.insert(object, at: index)
    }
    
    func add(objects: [Any]) {
        self.objects.addObjects(from: objects)
    }
    
    func remove(object: Any) {
        self.objects.remove(object)
    }
    
    func remove(objects: [Any]) {
        self.objects.removeObjects(in: objects)
    }
    
    func removeObject(at index: Int) {
        self.objects.removeObject(at: index)
    }
    
    func removeAllObjects() {
        self.objects.removeAllObjects()
    }
    
    func replaceAllObjects(with objects: [Any]) {
        self.removeAllObjects()
        self.add(objects: objects)
    }
    
    func moveObject(from baseIndex: Int, to targetIndex: Int) {
        if targetIndex < self.objects.count && baseIndex < self.objects.count {
            let object = self.object(at: baseIndex)
            self.objects.removeObject(at: baseIndex)
            self.objects.insert(object as Any, at: targetIndex)
        }
    }

}
