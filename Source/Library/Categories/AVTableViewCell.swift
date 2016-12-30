//
//  AVTableViewCell.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 11/9/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import UIKit

class AVTableViewCell: UITableViewCell {

    override var reuseIdentifier: String? {
        return NSStringFromClass(type(of: self))
    }

}
