//
//  RightSideMenu.swift
//  clozet
//
//  Created by Mohamed Said on 3/29/15.
//  Copyright (c) 2015 Mohamed Said. All rights reserved.
//

import UIKit

@objc protocol SideBarDelegate{
    optional func sideBarWillClose()
    optional func sideBarWillOpen()
}

class RightSideMenu: UIView, UITableViewDelegate, UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
    
    var delegate:SideBarDelegate!
    var originalXPosition:CGFloat!
    
    override func awakeFromNib() {
        tableView.userInteractionEnabled = false
    }
    
    override func layoutSubviews() {
        var itemNib = UINib(nibName: "SideMenuItem", bundle: nil)
        tableView.registerNib(itemNib, forCellReuseIdentifier: "SideMenuItem")
        
        tableView.rowHeight = (self.frame.height - 80) / 9
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
    func manageSideMenuSwipe(menu: RightSideMenu){
        var swipeLeft = UISwipeGestureRecognizer(target: menu, action: "animateMenu:")
        swipeLeft.direction = UISwipeGestureRecognizerDirection.Left
        menu.addGestureRecognizer(swipeLeft)
        
        var swipeRight = UISwipeGestureRecognizer(target: menu, action: "animateMenu:")
        swipeRight.direction = UISwipeGestureRecognizerDirection.Right
        menu.addGestureRecognizer(swipeRight)
    }
    
    func animateMenu(reconginzer: UISwipeGestureRecognizer){
        
        if reconginzer.direction == UISwipeGestureRecognizerDirection.Left{
            delegate?.sideBarWillOpen?()
            
            UIView.animateWithDuration(
                0.6,
                delay: 0.0,
                usingSpringWithDamping: 0.6,
                initialSpringVelocity: 0.0,
                options: nil,
                animations: {
                    self.frame.origin.x = UIScreen.mainScreen().bounds.width - self.frame.width + 20
                }, completion: {
                    finished in
                    self.tableView.userInteractionEnabled = true
                }
            )
        }else{
            self.closeBar()
        }
    }
    
    func closeBar(){
        delegate?.sideBarWillClose?()
        UIView.animateWithDuration(
            0.6,
            delay: 0.0,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 0.0,
            options: nil,
            animations: {
                self.frame.origin.x = self.originalXPosition
            }, completion: {
                finished in
                self.tableView.userInteractionEnabled = false
            }
        )
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("SideMenuItem") as UITableViewCell
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        cell.backgroundColor = UIColor.clearColor()
        cell.frame.size.height = self.tableView.rowHeight
        cell.frame.size.width = self.frame.size.width
        
        var icon = cell.viewWithTag(1001) as UIImageView
        icon.image = icon.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        icon.tintColor = UIColor(red:0.55, green:0.6, blue:0.71, alpha:1)
        
        var badge = cell.viewWithTag(1002) as UILabel
        badge.layer.backgroundColor = UIColor(red:0.15, green:0.66, blue:0.68, alpha:1).CGColor
        badge.layer.cornerRadius = badge.frame.size.width / 2;
        badge.clipsToBounds = true;
        
        if indexPath.row < 8{
            let separatorView = UIView(frame: CGRectMake(0, cell.frame.height - 0.7, cell.frame.width, 1.4))
            separatorView.backgroundColor = UIColor(red:0.13, green:0.15, blue:0.24, alpha:1)
            
            cell.addSubview(separatorView)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        var icon = cell?.viewWithTag(1001) as UIImageView
        icon.image = icon.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        
        var badge = cell?.viewWithTag(1002) as UILabel
        
        UIView.animateWithDuration(0.3, animations: {
            icon.tintColor = UIColor.whiteColor()
            badge.layer.backgroundColor = UIColor.whiteColor().CGColor
            badge.textColor = UIColor(red:0.15, green:0.66, blue:0.68, alpha:1)
            
            cell?.contentView.layer.backgroundColor = UIColor(red:0.15, green:0.66, blue:0.68, alpha:1).CGColor
        })
        
        let delay = 0.15 * Double(NSEC_PER_SEC)
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
        
        dispatch_after(time, dispatch_get_main_queue(), {
            self.closeBar()
        })
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        var icon = cell?.viewWithTag(1001) as UIImageView
        icon.image = icon.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        
        var badge = cell?.viewWithTag(1002) as UILabel
        
        UIView.animateWithDuration(0.3, animations: {
            icon.tintColor = UIColor(red:0.55, green:0.6, blue:0.71, alpha:1)
            badge.layer.backgroundColor = UIColor(red:0.15, green:0.66, blue:0.68, alpha:1).CGColor
            badge.textColor = UIColor.whiteColor()
        })
        
        cell?.contentView.layer.backgroundColor = UIColor.clearColor().CGColor
    }
}
