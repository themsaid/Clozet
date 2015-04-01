//
//  ListViewCell.swift
//  clozet
//
//  Created by Mohamed Said on 3/29/15.
//  Copyright (c) 2015 Mohamed Said. All rights reserved.
//

import UIKit

class ListViewCell: UITableViewCell {
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var itemPlusButton: ListScreenPlusButton!
    @IBOutlet weak var itemTitleLabel: UILabel!
    @IBOutlet weak var itemInfoLabel: UILabel!
    
    
    var tableView:UITableView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        contentView.frame.size.width = tableView!.frame.width
        
        let separatorView = UIView(frame: CGRectMake(0, contentView.frame.height - 0.75, contentView.frame.width, 1.5))
        separatorView.backgroundColor = UIColor(red:0.89, green:0.89, blue:0.89, alpha:1)
        
        contentView.addSubview(separatorView)
    }
    
}
