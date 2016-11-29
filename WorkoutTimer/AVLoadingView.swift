//
//  AVLoadingView.swift
//  WorkoutTimer
//
//  Created by Aleksandr Voropaev on 11/25/16.
//  Copyright © 2016 Aleksandr Voropayev. All rights reserved.
//

import UIKit

let animationDuration: TimeInterval = 0.0
let animationDelay: TimeInterval = 1.0
let animationOptions: UIViewAnimationOptions = .transitionCrossDissolve
let alphaVisible: CGFloat = 1.0
let alphaInvisible: CGFloat = 0.0

class AVLoadingView: UIView {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var visible: Bool = true
    
    static func loadingView(with view: UIView) -> AVLoadingView {
        var loadingView = self.initFromNib() as! AVLoadingView
        if loadingView.frame == CGRect.zero {
            loadingView = AVLoadingView()
        }
        
        loadingView.frame = view.bounds
        loadingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        loadingView.alpha = alphaInvisible

        view.addSubview(loadingView)
        
        return loadingView
    }
    
    func setVisible(visible:Bool) {
        self.setVisible(visible: visible, animated: true)
    }
    
    func setVisible(visible: Bool, animated: Bool) {
        self.setVisible(visible: visible, animated: animated, completion: nil)
    }
    
    func setVisible(visible: Bool, animated: Bool, completion: ((Bool) -> Void)?) {
        if visible != self.visible {
            self.visible = visible
            
            if visible {
                self.superview?.bringSubview(toFront: self)
            }
            
            UIView.animate(withDuration: animated ? animationDuration : 0,
                           delay: animationDelay,
                           options: animationOptions,
                           animations: { self.alpha = visible ? alphaVisible : alphaInvisible },
                           completion: { animationIsFinished in
                                if !visible {
                                    self.superview?.sendSubview(toBack: self)
                                }
                            
                                if let completionHandler = completion {
                                    completionHandler(animationIsFinished)
                                }
                            })
        }
        
        
    }
    
//    - (void)setVisible:(BOOL)visible {
//      [self setVisible:visible animated:YES];
//    }
//    
//    - (void)setVisible:(BOOL)visible animated:(BOOL)animated {
//      [self setVisible:visible animated:animated completionHandler:nil];
//    }
//    
//    - (void)setVisible:(BOOL)visible animated:(BOOL)animated completionHandler:(void (^)(void))completion {
//      if (_visible != visible) {
//          _visible = visible;
//    
//          if (visible) {
//              [self.superview bringSubviewToFront:self];
//          }
//    
//          [UIView animateWithDuration:animated ? kAVLoadingViewDurationWithAnimation : kAVLoadingViewDurationWithoutAnimation
//              delay:kAVLoadingViewDelay
//              options:UIViewAnimationOptionBeginFromCurrentState
//              animations:^{
//                  self.alpha = visible ? kAlphaVisible : kAlphaInvisible;
//              }
//              completion:^(BOOL finished) {
//                  if (!visible) {
//                      [self.superview sendSubviewToBack:self];
//                  }
//    
//                  if (completion) {
//                      completion();
//                  }
//              }];
//      }
//    }

    
}
