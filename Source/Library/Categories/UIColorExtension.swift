//
//  UIColorExtension.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 12/30/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import UIKit

extension UIColor {

//	MARK: Class methods

    class func RGB(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
    }
    
}
