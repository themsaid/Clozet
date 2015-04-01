//
//  TabBarController.swift
//  clozet
//
//  Created by Mohamed Said on 3/27/15.
//  Copyright (c) 2015 Mohamed Said. All rights reserved.
//

import UIKit
import Swift

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.barTintColor = UIColor(red:0.12, green:0.15, blue:0.24, alpha:1)
        tabBar.selectedImageTintColor = UIColor.whiteColor()
        tabBar.translucent = false
        self.delegate = self
        
        let topSeparator = UIView(frame: CGRectMake(0, 0, tabBar.frame.width, 2))
        topSeparator.backgroundColor = UIColor(red:0.15, green:0.67, blue:0.65, alpha:1)
        
        tabBar.addSubview(topSeparator)
        
        let item1 = tabBar.items?[0] as UITabBarItem
        let item2 = tabBar.items?[1] as UITabBarItem
        let item3 = tabBar.items?[2] as UITabBarItem
        let item4 = tabBar.items?[3] as UITabBarItem
        
        item1.image = UIImage(named: "list")
        item2.image = UIImage(named: "map")
        item3.image = UIImage(named: "plus")
        item4.image = UIImage(named: "user")
        
        let itemWidth = tabBar.frame.width / 4
        
        for item in tabBar.items as [UITabBarItem] {
            item.setTitleTextAttributes(
                [
                    NSFontAttributeName:UIFont.boldSystemFontOfSize(12),
                    NSForegroundColorAttributeName:UIColor(red:0.56, green:0.6, blue:0.71, alpha:1)
                ],
                forState: UIControlState.Normal
            )
            
            item.setTitleTextAttributes(
                [
                    NSForegroundColorAttributeName:UIColor.whiteColor()
                ],
                forState: UIControlState.Selected
            )
            
            item.setTitlePositionAdjustment(UIOffsetMake(0, -10))
            item.imageInsets = UIEdgeInsetsMake(-6, 0, 6, 0)
            
            if item.tag < 1004{
                let separatorXPosition = (itemWidth * CGFloat(item.tag - 1000)) - CGFloat(0.75)
                let separatorView = UIView(frame: CGRectMake(separatorXPosition, 0, 1.5, 80))
                separatorView.backgroundColor = UIColor(red:0.56, green:0.6, blue:0.71, alpha:1)
                
                tabBar.insertSubview(separatorView, atIndex: 1)
            }
            
        }
        
    }
    
    override func viewWillLayoutSubviews()
    {
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = 80
        tabFrame.origin.y = self.view.frame.size.height - 80
        self.tabBar.frame = tabFrame
    }
    
    func tabBarController(tabBarController: UITabBarController, animationControllerForTransitionFromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let transitioningObject = TransitioningObject()
        
        transitioningObject.tabBarController = self
        return transitioningObject
    }
    
}


class TransitioningObject: NSObject, UIViewControllerAnimatedTransitioning {
    private weak var tabBarController: UITabBarController!
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let fromView: UIView = transitionContext.viewForKey(UITransitionContextFromViewKey)!
        let fromViewController: UIViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toView: UIView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        let toViewController: UIViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        
        transitionContext.containerView().addSubview(fromView)
        transitionContext.containerView().addSubview(toView)
        
        let fromViewControllerIndex = find(self.tabBarController.viewControllers! as [UIViewController], fromViewController)
        let toViewControllerIndex = find(self.tabBarController.viewControllers! as [UIViewController], toViewController)
        
        var directionInteger: CGFloat!
        if fromViewControllerIndex < toViewControllerIndex {
            directionInteger = 1
        } else {
            directionInteger = -1
        }
        
        toView.frame = CGRectMake(directionInteger * toView.frame.width, 0, toView.frame.width, toView.frame.height)
        let fromNewFrame = CGRectMake(-1 * directionInteger * fromView.frame.width, 0, fromView.frame.width, fromView.frame.height)
        
        UIView.animateWithDuration(
            transitionDuration(transitionContext),
            delay: 0,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 0.0,
            options: nil,
            animations: {
                toView.frame = fromView.frame
                fromView.frame = fromNewFrame
            },
            completion: {
                _ in
                
                transitionContext.completeTransition(true)
                
            }
        )
        
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.6
    }
}