//
//  AVYouTubeVideoModel.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 11/17/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import UIKit

class AVYouTubeVideoModel: NSObject {
    
    var thumbnailImageName: String?
    var title: String?
    var channel: AVYouTubeChannel?
    var numberOfViews: NSNumber?
    var uploadDate: NSDate?
    
}

class AVYouTubeChannel: NSObject {
    
    var name: String?
    var profileImageName: String?
    
}
