//
//  UITableViewExtension.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 12/30/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import UIKit

extension UITableView {
    
//	MARK: Public
    
    public func dequeueReusableCell(withClass cls: AnyClass) -> UITableViewCell? {
        let identifier = NSStringFromClass(cls)
        var cell = self.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UINib.object(withClass: cls) as! UITableViewCell?
        }
        
        return cell
    }
    
}
