//
//  listScreenPlusButton.swift
//  clozet
//
//  Created by Mohamed Said on 3/29/15.
//  Copyright (c) 2015 Mohamed Said. All rights reserved.
//

import UIKit

class ListScreenPlusButton: UIButton {

    override func drawRect(rect: CGRect) {
        var border = UIBezierPath(ovalInRect: rect)
        UIColor.whiteColor().setFill()
        border.fill()
        
        var path = UIBezierPath(ovalInRect: CGRectMake(rect.origin.x+2, rect.origin.x+2, rect.width-4, rect.height-4))
        UIColor(red:0.11, green:0.73, blue:0.65, alpha:1).setFill()
        path.fill()
    }
    
    
    
}
