//
//  GroupTableViewCell.swift
//  Youlv
//
//  Created by Lost on 25/07/2015.
//  Copyright (c) 2015 com.RamyTech. All rights reserved.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

    @IBOutlet weak var groupButton: UIButton!
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupIntro: UILabel!
    
    
    @IBAction func groupJoinClicked(sender: AnyObject) {
    }
    
    @IBAction func groupButtonClicked(sender: AnyObject) {
    }
    
    var groupId = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func displayData(dict : NSDictionary)
    {
        groupId =  dict.objectForKey("group_id") as! String
        groupButton.imageView?.sd_setImageWithURL(NSURL(string: dict.objectForKey("group_photoUrl") as! String), placeholderImage: headImage)
        groupName.text = dict.objectForKey("group_name") as? String
        var intro =  String(dict.objectForKey("group_affiliationsCount") as! Int) + "人，"
        intro = intro + String(dict.objectForKey("group_friendNum") as! Int) + "个好友在群内"
        groupIntro.text = intro
    }
    

}
