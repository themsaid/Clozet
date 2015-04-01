//
//  ViewController.swift
//  clozet
//
//  Created by Mohamed Said on 3/26/15.
//  Copyright (c) 2015 Mohamed Said. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return false
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Background color
        UIGraphicsBeginImageContext(self.view.frame.size);
        UIImage(named: "splashBG")!.drawInRect(self.view.bounds)
        var backgroundImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        view.backgroundColor = UIColor(patternImage: backgroundImage!)
        
        // Add the blur visual effect on the background color
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
        var blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.frame
        view.addSubview(blurEffectView)
        view.sendSubviewToBack(blurEffectView)
        
        loginButton.layer.cornerRadius = 5.0
        
        usernameField.alpha = 0
        usernameField.frame.origin.x = -15
        
        passwordField.alpha = 0
        passwordField.frame.origin.x = -15
        
        loginButton.alpha = 0
        loginButton.frame.origin.x = -15
        
        UIView.animateKeyframesWithDuration(
            1.0,
            delay: 0,
            options: nil,
            animations: {
                UIView.addKeyframeWithRelativeStartTime(0.2, relativeDuration: 1/3, animations: {
                    self.usernameField.alpha = 1
                    self.usernameField.frame.origin.x = 15
                })
                
                UIView.addKeyframeWithRelativeStartTime(0.3, relativeDuration: 1/3, animations: {
                    self.passwordField.alpha = 1
                    self.passwordField.frame.origin.x = 15
                })
                
                UIView.addKeyframeWithRelativeStartTime(0.4, relativeDuration: 1/3, animations: {
                    self.loginButton.alpha = 1
                    self.loginButton.frame.origin.x = 15
                })
            },
            completion: {finished in
            
            }
        )
        
        
    }


}

