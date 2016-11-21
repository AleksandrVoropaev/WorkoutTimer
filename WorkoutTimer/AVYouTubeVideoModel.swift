//
//  AVYouTubeVideoModel.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 11/17/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import UIKit

class AVYouTubeVideoModel: NSObject {
    
    var thumbnail_image_name: String?
    var title: String?
    var channel: AVYouTubeChannel?
    var number_of_views: NSNumber?
    var uploadDate: NSDate?
    var duration: NSNumber?
    var videoId: String?
    var videoDecription: String?
    
}

class AVYouTubeChannel: NSObject {
    
    var name: String?
    var id: String?
    var profile_image_name: String?
    
}
