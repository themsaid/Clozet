//
//  ListViewController.swift
//  clozet
//
//  Created by Mohamed Said on 3/27/15.
//  Copyright (c) 2015 Mohamed Said. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SideBarDelegate, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var tapGestureRecognizer:UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.clipsToBounds = true
        
        tableView.allowsSelection = false
        
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissSearchBarKeyboard")
        
        searchBar.layer.borderWidth = 2
        searchBar.layer.borderColor = UIColor(red:0.89, green:0.89, blue:0.9, alpha:1).CGColor
        
        
        let cellNib = UINib(nibName: "ListViewCell", bundle: nil)
        tableView.registerNib(cellNib, forCellReuseIdentifier: "ListViewCell")
        
        let rightSideMenuNib = NSBundle.mainBundle().loadNibNamed("RightSideMenu", owner: self, options: nil)[0] as RightSideMenu
        rightSideMenuNib.frame = CGRectMake(view.frame.width-40, 42, view.frame.width - 90, view.frame.height - 42)
        rightSideMenuNib
        rightSideMenuNib.delegate = self
        rightSideMenuNib.originalXPosition = rightSideMenuNib.frame.origin.x
        rightSideMenuNib.manageSideMenuSwipe(rightSideMenuNib)
        view.addSubview(rightSideMenuNib)
        
        tableView.rowHeight = 100
        tableView.separatorStyle = UITableViewCellSeparatorStyle.None
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    // MARK: Search bar
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        view.addGestureRecognizer(tapGestureRecognizer)
        
        return true
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func dismissSearchBarKeyboard(){
        searchBar.resignFirstResponder()
        view.removeGestureRecognizer(self.tapGestureRecognizer)
    }
    
    
    // MARK: Table View
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("ListViewCell") as ListViewCell
        
        cell.tableView = tableView
        
        return cell
    }
    
    // MARK: Side bar controls
    func sideBarWillOpen() {
        tableView.userInteractionEnabled = false
        
        var cells = tableView.visibleCells() as [ListViewCell]
        for cell:ListViewCell in cells{
            UIView.animateWithDuration(0.2, animations: {
                cell.itemPlusButton.alpha = 0
            })
        }
    }
    
    func sideBarWillClose() {
        tableView.userInteractionEnabled = true
        
        var cells = tableView.visibleCells() as [ListViewCell]
        for cell:ListViewCell in cells{
            UIView.animateWithDuration(0.2, animations: {
                cell.itemPlusButton.alpha = 1
            })
        }
    }
    
}