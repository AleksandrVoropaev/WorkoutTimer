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
    
//	MARK: Public

    public func timeLabelChangeWithFunction(oldValue: Int,
                                            function: (Int, Int) -> Int,
                                            label: UILabel) -> Int {
        return self.labelChangeWithFunction(oldValue: oldValue,
                                            function: function,
                                            label: label,
                                            isTimeIndicator: true)
    }
    
    public func countLabelChangeWithFunction(oldValue: Int,
                                             function: (Int, Int) -> Int,
                                             label: UILabel) -> Int {
        return self.labelChangeWithFunction(oldValue: oldValue,
                                            function: function,
                                            label: label,
                                            isTimeIndicator: false)
    }
    
    public func secondsToTimeString(seconds value: Int) -> String {
        let seconds = String(format:"%02d", value % 60)
        let minutes = String(format:"%02d", value / 60)
        
        return "\(minutes):\(seconds)"
    }
    
//	MARK: Private

    fileprivate func labelChangeWithFunction(oldValue: Int,
                                             function: (Int, Int) -> Int,
                                             label: UILabel,
                                             isTimeIndicator: Bool) -> Int {
        let newValue = oldValue  > 0 ? function(oldValue, 1) : 0
        label.text = isTimeIndicator ? self.secondsToTimeString(seconds: newValue) : "\(newValue)"
        
        return newValue
    }

}
