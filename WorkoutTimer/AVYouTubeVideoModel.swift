//
//  AVYouTubeVideoModel.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 11/17/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import UIKit

class AVYouTubeVideoModel: NSObject {
    
    var thumbnailImage: String?
    var title: String?
    var id: String?
    var videoDecription: String?
    var publicationDate: String?
    var viewCount: Int?
    var channel: AVYouTubeChannel?

}

class AVYouTubeChannel: NSObject {
    
    var name: String?
    var id: String?
    var thumbnailImage: String?
    
}
