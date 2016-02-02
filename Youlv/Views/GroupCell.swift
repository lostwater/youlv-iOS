//
//  GroupCell.swift
//  Youlv
//
//  Created by Lost on 03/02/2016.
//  Copyright © 2016 com.RamyTech. All rights reserved.
//


class GroupCell: UITableViewCell {

    @IBOutlet weak var avatar: AvatarImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var intro: UILabel!
    @IBOutlet weak var buttonJoin: UIButton?
    
    @IBAction func buttonJoinClicked(sender: AnyObject) {
    }
    
    
    func configure(dict:NSDictionary)
    {
        name.text = dict.objectForKey("groupname") as? String
        avatar.sd_setImageWithURL(NSURL(string: dict.objectForKey("avatar") as! String)!, placeholderImage: headImage)
        avatar.isPushEnabled = false
    }
    
    
}
