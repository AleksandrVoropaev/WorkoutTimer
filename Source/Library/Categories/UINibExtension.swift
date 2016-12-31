//
//  UITableView+AVExtension.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 11/9/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import UIKit

extension UINib {
    
//	MARK: Class methods

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

//	MARK: Public

    public func object(withClass cls:AnyClass) -> Any? {
        return self.object(withClass: cls, owner: nil)
    }
    
    public func object(withClass cls:AnyClass, owner:Any?) -> Any? {
        return self.object(withClass: cls, owner: owner, options: nil)
    }
    
    public func object(withClass cls:AnyClass, owner:Any?, options:[AnyHashable : Any]?) -> Any? {
        return self.instantiate(withOwner: owner, options: options).firstObjectWithClass(cls: cls)
    }
    
}




