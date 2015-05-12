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
    
     var dataDict : NSDictionary?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        eventLikedButton.setImage(UIImage(named:"buttonheartoutline"), forState: UIControlState.Normal)
        eventLikedButton.setImage(UIImage(named:"buttonheart"), forState: UIControlState.Selected)
        // Initialization code
    }
    
   
    func setData(dataDict : NSDictionary)
    {
        self.dataDict = dataDict
        eventImageView.sd_setImageWithURL(NSURL(string: self.dataDict!.objectForKey("photoUrl") as! String))
        eventName.text = String(self.dataDict!.objectForKey("title") as! Int)
        eventValid.text = self.dataDict!.objectForKey("activeTime") as? String
        eventLikedButton.setTitle(String(self.dataDict!.objectForKey("praiseCount") as! Int), forState: UIControlState.Normal)
        eventLikedButton.setTitle(String(self.dataDict!.objectForKey("praiseCount") as! Int), forState: UIControlState.Selected)
        
        let isMarked = false
        if Bool(isMarked)
        {
            eventLikedButton.selected = true
        }
        else
        {
            eventLikedButton.selected = false
        }
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
