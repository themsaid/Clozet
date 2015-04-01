//
//  CustomSegue.swift
//  clozet
//
//  Created by Mohamed Said on 3/27/15.
//  Copyright (c) 2015 Mohamed Said. All rights reserved.
//

import UIKit

class CustomSegue: UIStoryboardSegue {
    
    override func perform() {
        var fromView = self.sourceViewController.view as UIView!
        var toView = self.destinationViewController.view as UIView!
        
        let offScreenHorizontalStart = CGAffineTransformMakeRotation(CGFloat(M_PI / 2))
        let offScreenHorizontalEnd = CGAffineTransformMakeRotation(CGFloat(-M_PI / 2))
        
        fromView.layer.anchorPoint = CGPoint(x:0, y:0)
        fromView.layer.position = CGPoint(x:0, y:0)
        
        UIApplication.sharedApplication().keyWindow?.insertSubview(toView, belowSubview: fromView)
        
        
        UIView.animateWithDuration(0.7, delay: 0.0, usingSpringWithDamping: 1.6, initialSpringVelocity: 0.0, options: nil, animations: {
            
            fromView.transform = offScreenHorizontalEnd
            
            }, completion: { finished in
                self.sourceViewController.presentViewController(self.destinationViewController as UIViewController, animated: false, completion: nil)
                
        })
    }
   
}
