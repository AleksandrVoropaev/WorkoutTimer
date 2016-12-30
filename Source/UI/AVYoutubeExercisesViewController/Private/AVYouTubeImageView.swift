//
//  AVYouTubeImageView.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 11/18/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import UIKit

let imageCache  = NSCache<NSString, UIImage>()

class AVYouTubeImageView: UIImageView {

    var imageURLString: String? = nil
    
    func loadImageWithURLString(URLString: String) {
        self.imageURLString = URLString
        let url = NSURL(string: URLString)
        
        self.image = nil
        
        if let imageFromCache = imageCache.object(forKey: URLString as NSString) {
            self.image = imageFromCache
            return
        } else {
            self.addSubview(AVLoadingView.loadingView(with: self))
            URLSession.shared.dataTask(with: url as! URL, completionHandler: { (data, respones, error) in
                if error != nil {
                    print(error as Any)
                    
                    return
                }
                
                DispatchQueue.main.async {
                    if let cachedImage = UIImage(data: data!) {
                        imageCache.setObject(cachedImage, forKey: URLString as NSString)
                        
                        if self.imageURLString == URLString {
                            self.image = cachedImage
                        }
                    }
                }
            }).resume()
        }
    }
}
