//
//  AVYouTubeImageView.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 11/18/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import UIKit

//let imageCache  = NSCache<AnyObject, AnyObject>()

class AVYouTubeImageView: UIImageView {
    
    let imageCache  = NSCache<NSString, UIImage>()

    var imageURLString: String? = nil
    
    func loadImageWithURLString(URLString: String) {
        self.imageURLString = URLString
        let url = NSURL(string: URLString)
        
        self.image = nil
        
        if let imageFromCache = imageCache.object(forKey: URLString as NSString) {
            self.image = imageFromCache
            return
        } else {
            URLSession.shared.dataTask(with: url as! URL, completionHandler: { (data, respones, error) in
                if error != nil {
                    print(error as Any)
                    
                    return
                }
                
//                if let cachedImage = UIImage(data: data!) {
//                    self.imageCache.setObject(cachedImage, forKey: URLString as NSString)
//                    
//                    if self.imageURLString == URLString {
//                        self.image = cachedImage
//                    }
//                }
                
                DispatchQueue.main.async {
                    if let cachedImage = UIImage(data: data!) {
                        self.imageCache.setObject(cachedImage, forKey: URLString as NSString)
                        
                        if self.imageURLString == URLString {
                            self.image = cachedImage
                        }
                    }
                }
            }).resume()
        }
    }
}
