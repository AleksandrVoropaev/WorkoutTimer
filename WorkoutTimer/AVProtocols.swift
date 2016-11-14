//
//  AVProtocols.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 11/11/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import Foundation
import UIKit

protocol AVCellsFill {
    func timeLabelChangeWithFunction(oldValue: Int, function: (Int, Int) -> Int, label: UILabel) -> Int
    func secondsToTimeString(seconds value: Int) -> String
    func countLabelChangeWithFunction(oldValue: Int, function: (Int, Int) -> Int, label: UILabel) -> Int
}

extension AVCellsFill {
    func timeLabelChangeWithFunction(oldValue: Int, function: (Int, Int) -> Int, label: UILabel) -> Int {
        let newValue = function(oldValue, 1)
        label.text = self.secondsToTimeString(seconds: newValue)
        
        return newValue
    }

    func secondsToTimeString(seconds value: Int) -> String {
        let seconds = String(format:"%02d", value % 60)
        let minutes = String(format:"%02d", value / 60)
        
        return "\(minutes):\(seconds)"
    }
    
    func countLabelChangeWithFunction(oldValue: Int, function: (Int, Int) -> Int, label: UILabel) -> Int {
        let newValue = function(oldValue, 1)
        
        label.text = "\(newValue)"
        
        return newValue
    }
}
