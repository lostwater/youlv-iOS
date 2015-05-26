//
//  InterviewQATableViewCell.swift
//  Youlv
//
//  Created by Lost on 15/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class InterviewQATableViewCell: UITableViewCell {

    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var likedButton: UIButton!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var qOrALabel: UILabel!
    @IBOutlet var contentTextView: UITextView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        likedButton.setImage(UIImage(named:"buttonlikecommentblue"), forState: UIControlState.Selected)
        likedButton.setImage(UIImage(named:"buttonlikecommentgrey"), forState: UIControlState.Normal)
        likedButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        likedButton.setTitleColor(appBlueColor, forState: UIControlState.Selected)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func displayData(dataDict : NSDictionary)
    {
        userImageView.sd_setImageWithURL(NSURL(string:dataDict.objectForKey("discuss_lawyerPhotoUrl") as! String)!, placeholderImage: headImage)
        
        userName.text = dataDict.objectForKey("discuss_lawyerName") as? String
        likedButton.setTitle(String(dataDict.objectForKey("discuss_praiseCount") as! Int), forState: UIControlState.Selected)
        likedButton.setTitle(String(dataDict.objectForKey("discuss_praiseCount") as! Int), forState: UIControlState.Normal)
        let isLiked = dataDict.objectForKey("discuss_isPraise") as! Bool
        if isLiked
        {
            likedButton.selected = true
        }
        if (dataDict.objectForKey("discuss_type") as! String) == "1"
        {
            qOrALabel.text = "Q:"
            qOrALabel.textColor = UIColor.orangeColor()
        }
        else
        {
            qOrALabel.text = "A:"
            qOrALabel.textColor = appBlueColor
        }
        timeLabel.text = dataDict.objectForKey("discuss_createDate") as? String
        contentTextView.text = dataDict.objectForKey("discuss_content") as? String
        
        resizeTextView(contentTextView)
    }

}
