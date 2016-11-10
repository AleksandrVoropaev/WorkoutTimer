////
////  UITableView+AVExtension.swift
////  WorkoutTimer
////
////  Created by Aleksandr Voropaev on 11/9/16.
////  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
////
//
//import UIKit
//
//extension Array {
//    func filteredArrayUsingBlock(block: @escaping (Any?, [String : Any]?) -> Bool) -> NSArray {
//        let predicate = NSPredicate.init(block: block)
//        
//        return self.filtered(using: predicate) as NSArray
//    }
//    
//    func objects(withClass cls:AnyClass) -> NSArray {
//        return self.filteredArrayUsingBlock(block: { (evaluatedObject: Any?, bindings: [String : Any]?) -> Bool in
//            return type(of: evaluatedObject) == cls
//        })
//    }
//    
//    func firstObjectWithClass(cls:AnyClass) -> Any? {
//        return self.objects(withClass: cls).firstObject
//    }
//    
//    //    - (NSArray *)objectsWithClass:(Class)cls {
//    //    return [self filteredArrayUsingBlock:^BOOL(id object) {
//    //    return [object class] == cls;
//    //    }];
//    //    }
//    //
//    //    - (id)firstObjectWithClass:(Class)cls {
//    //      return [[self objectsWithClass:cls] firstObject];
//    //    }
//    
//    //    - (NSArray *)filteredArrayUsingBlock:(AVArrayFilterBlock)block {
//    //      if (!block) {
//    //          return self;
//    //      }
//    //
//    //      NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
//    //          return block(evaluatedObject);
//    //      }];
//    //
//    //      return [self filteredArrayUsingPredicate:predicate];
//    //    }
//}
//
//extension UITableView {
//    open func dequeueReusableCell(withClass cls: AnyClass) -> UITableViewCell? {
//        let identifier = NSStringFromClass(cls)
//        var cell = self.dequeueReusableCell(withIdentifier: identifier)
//        if cell == nil {
//            cell = UINib.object(withClass: cls)
//        }
//        
//        return cell
//    }
//}
//
//extension UINib {
//    class func nibWithClass(cls: AnyClass) -> UINib {
//        return self.nibWithClass(cls: cls, bundle: nil)
//    }
//    
//    class func nibWithClass(cls: AnyClass, bundle: Bundle?) -> UINib {
//        let nibName = NSStringFromClass(cls)
//        
//        return self.init(nibName:nibName, bundle:bundle)
//    }
//
//    class func object(withClass cls:AnyClass) -> AnyClass {
//        return self.object(withClass: cls, owner: nil)
//    }
//    
//    class func object(withClass cls:AnyClass, owner:Any?) -> AnyClass {
//        return self.object(withClass: cls, owner: owner, options: nil)
//    }
//    
//    class func object(withClass cls:AnyClass, owner:Any?, options:[AnyHashable : Any]?) -> AnyClass {
//        return self.nibWithClass(cls: cls).instantiate(withOwner: owner, options: options).
//    }
//    
////#pragma mark -
////#pragma mark Public
//    
//    func object(withClass cls:AnyClass) -> AnyClass {
//        return self.object(withClass: cls, owner: nil)
//    }
//    
//    func object(withClass cls:AnyClass, owner:AnyClass) -> AnyClass {
//        return self.object(withClass: cls, owner: owner, options: nil)
//    }
//    
//    func object(withClass cls:AnyClass, owner:Any?, options:[AnyHashable : Any]?) -> Any? {
//        return self.instantiate(withOwner: owner, options: options).firstObject()
//    }
//}
//
//
////#import "UINib+AVExtensions.h"
//
////#import "NSArray+AVExtensions.h"
//
////@implementation UINib (AVExtensions)
//
////#pragma mark -
////#pragma mark Class Methods
//
////+ (UINib *)nibWithClass:(Class)cls {
////    return [self nibWithClass:cls bundle:nil];
////    }
////    
////    + (UINib *)nibWithClass:(Class)cls bundle:(NSBundle *)bundleOrNil {
////        NSString *nibName = NSStringFromClass(cls);
////        
////        return [self nibWithNibName:nibName bundle:bundleOrNil];
////        }
////        
////        + (id)objectWithClass:(Class)class {
////            return [self objectWithClass:class owner:nil];
////            }
////            
////            + (id)objectWithClass:(Class)class owner:(nullable id)ownerOrNil {
////                return [self objectWithClass:class owner:ownerOrNil options:nil];
////}
////
////                + (id)objectWithClass:(Class)class owner:(nullable id)ownerOrNil options:(nullable NSDictionary *)optionsOrNil {
////                    return [[[self nibWithClass:class] instantiateWithOwner:ownerOrNil options:optionsOrNil] firstObjectWithClass:class];
////}
////
////#pragma mark -
////#pragma mark Public
////
////- (id)objectWithClass:(Class)class {
////    return [self objectWithClass:class owner:nil];
////    }
////    
////    - (id)objectWithClass:(Class)class owner:(nullable id)ownerOrNil {
////        return [self objectWithClass:class owner:ownerOrNil options:nil];
////        }
////        
////        - (id)objectWithClass:(Class)class owner:(nullable id)ownerOrNil options:(nullable NSDictionary *)optionsOrNil {
////            return [[self instantiateWithOwner:ownerOrNil options:optionsOrNil] firstObjectWithClass:class];
////}
////
////@end
//
//
//
