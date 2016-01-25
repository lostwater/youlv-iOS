//
//  EventTableViewCell.swift
//  Youlv
//
//  Created by Lost on 04/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet var eventImageView: UIImageView!
    @IBOutlet var eventName: UILabel!
    @IBOutlet var eventValid: UILabel!
    @IBOutlet var eventLikedButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        eventLikedButton.setImage(UIImage(named:"buttonheartoutline"), forState: UIControlState.Normal)
        eventLikedButton.setImage(UIImage(named:"buttonheart"), forState: UIControlState.Selected)
        // Initialization code
    }
    
   
    func configure(dataDict : NSDictionary)
    {
        eventImageView.sd_setImageWithURL(NSURL(string: dataDict.objectForKey("activity_img") as! String),placeholderImage:defualtPic)
        eventName.text = dataDict.objectForKey("name") as? String
        eventValid.text = "截止到 " + defaultDateFormatter.stringFromDate(NSDate(fromString: dataDict.objectForKey("start_time") as! String))

        //eventLikedButton.setTitle(String(dataDict.objectForKey("praiseCount") as! Int), forState: UIControlState.Normal)
        //eventLikedButton.setTitle(String(dataDict.objectForKey("praiseCount") as! Int), forState: UIControlState.Selected)
        
        eventLikedButton.selected = dataDict.objectForKey("interest_or_not") as! Bool
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
