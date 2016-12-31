//
//  UIViewExtension.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 12/30/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import UIKit

extension UIView {
    
//	MARK: Class methods

    class func initFromNib() -> UIView {
        let mainBundle = Bundle.main
        let className = NSStringFromClass(self).components(separatedBy: ".").last ?? ""
        if mainBundle.path(forResource: className, ofType: "nib") != nil {
            if let objects = mainBundle.loadNibNamed(className, owner: self, options: [:]) {
                for object in objects {
                    if let view = object as? UIView {
                        return view
                    }
                }
            }
        }
        
        return UIView(frame: CGRect.zero)
    }

//	MARK: Public

    public func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String : UIView]()
        for (index, view) in views.enumerated() {
            view.translatesAutoresizingMaskIntoConstraints = false
            let key = "v\(index)"
            viewsDictionary[key] = view
        }
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format,
                                                           options: NSLayoutFormatOptions(),
                                                           metrics: nil,
                                                           views: viewsDictionary))
    }
    
}
