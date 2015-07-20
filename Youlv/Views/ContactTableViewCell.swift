//
//  ContactTableViewCell.swift
//  Youlv
//
//  Created by Lost on 22/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet weak var userHead: AvatarImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var intro : UILabel?
    @IBOutlet weak var selectButton: UIButton?
    @IBOutlet weak var selectPic: UIImageView?
    @IBAction func selectButtonClicked(sender: AnyObject) {
        //self.isSelected = true
        selected = !selected
    }
    
    var _headEnabledToPush = false
    var headEnabledToPush : Bool
    {
        get
        {
            return _headEnabledToPush
        }
        set (value)
        {
            _headEnabledToPush = value
            userHead.isPushEnabled = headEnabledToPush

        }
    }
    
    var isCheckOn: Bool
    {
        get
        {
            if selectButton == nil
            {
                return false
            }
            return selectButton!.selected
        }
        set (value)
        {
           // selected = value
            selectButton?.selected  = value


        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectButton?.setImage(UIImage(named:"checkoff"), forState: UIControlState.Normal)
        selectButton?.setImage(UIImage(named:"checkon"), forState: UIControlState.Selected)
        //selectButton?.enabled = false
        userHead.isPushEnabled = headEnabledToPush
        userHead.image = headImage

        
    }

   override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectButton?.selected  = selected
        if selected
        {
            selectPic?.image = UIImage(named:"checkon")
    }
    else
        {
            selectPic?.image = UIImage(named:"checkoff")
    }
        //isCheckOn = selected
        // Configure the view for the selected state
    }
    
    

}
