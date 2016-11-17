//
//  UITableView+AVExtension.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 11/9/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import UIKit

extension Array {
    func firstObjectWithClass(cls:AnyClass) -> Any? {
        return self.first(where: { (evaluatedObject) -> Bool in
            return type(of: evaluatedObject) == cls
        })
    }
}

extension UINib {
    class func nibWithClass(cls: AnyClass) -> UINib {
        return self.nibWithClass(cls: cls, bundle: nil)
    }
    
    class func nibWithClass(cls: AnyClass, bundle: Bundle?) -> UINib {
        let nibName = NSStringFromClass(cls).components(separatedBy: ".").last
        
        return self.init(nibName:nibName!, bundle:bundle)
    }
    
    class func object(withClass cls:AnyClass) -> Any? {
        return self.object(withClass: cls, owner: nil)
    }
    
    class func object(withClass cls:AnyClass, owner:Any?) -> Any? {
        return self.object(withClass: cls, owner: owner, options: nil)
    }
    
    class func object(withClass cls:AnyClass, owner:Any?, options:[AnyHashable : Any]?) -> Any? {
        return self.nibWithClass(cls: cls).instantiate(withOwner: owner, options: options).firstObjectWithClass(cls: cls)
    }

    func object(withClass cls:AnyClass) -> Any? {
        return self.object(withClass: cls, owner: nil)
    }
    
    func object(withClass cls:AnyClass, owner:Any?) -> Any? {
        return self.object(withClass: cls, owner: owner, options: nil)
    }
    
    func object(withClass cls:AnyClass, owner:Any?, options:[AnyHashable : Any]?) -> Any? {
        return self.instantiate(withOwner: owner, options: options).firstObjectWithClass(cls: cls)
    }
}

extension UITableView {
    func dequeueReusableCell(withClass cls: AnyClass) -> UITableViewCell? {
        let identifier = NSStringFromClass(cls)
        var cell = self.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UINib.object(withClass: cls) as! UITableViewCell?
        }
        
        return cell
    }
}

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
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

extension UIColor {
    static func RGB(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
    }
}

extension UIImageView {
    func loadImageWithURLString(URLString: String) {
        let url = NSURL(string: URLString)
        URLSession.shared.dataTask(with: url as! URL, completionHandler: { (data, respones, error) in
            if error != nil {
                print(error as Any)
                
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
        }).resume()
    }
}

