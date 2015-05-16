//
//  InterViewTableViewCell.swift
//  Youlv
//
//  Created by Lost on 14/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class InterviewTableViewCell: UITableViewCell {

    @IBOutlet var interviewImageView: UIImageView!
    @IBOutlet var interviewName: UILabel!
    @IBOutlet var guestImageView: UIImageView!
    @IBOutlet var guestName: UILabel!
    @IBOutlet var interviewTextView: UITextView!
    @IBOutlet var interviewTime: UILabel!
    @IBOutlet var fellowButton: UIButton!
    @IBOutlet var isLiveImageView: UIImageView!
    
    @IBOutlet var textViewHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        fellowButton.setImage(UIImage(named:"iconfavoriteoutline"), forState: UIControlState.Normal)
        fellowButton.setImage(UIImage(named:"iconfavorite"), forState: UIControlState.Selected)
        fellowButton.setTitle("关注", forState: UIControlState.Normal)
        fellowButton.setTitle("已关注", forState: UIControlState.Selected)
        fellowButton.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        fellowButton.setTitleColor(appBlueColor, forState: UIControlState.Selected)


        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func displayData(dataDict : NSDictionary)
    {
        var isLive = dataDict.objectForKey("view_isLive") as! Bool
        if isLive
        {
            isLiveImageView.image = UIImage(named:"icononlive")
        }
        else
        {
            isLiveImageView.image = UIImage(named:"iconover")
        }
        //interviewImageView.sd_setImageWithURL(NSURL(string:dataDict.objectForKey("view_imgUrl") as! String)!)
        interviewName.text = dataDict.objectForKey("view_title") as? String
        guestImageView.sd_setImageWithURL(NSURL(string:dataDict.objectForKey("view_lawyerPhotoUrl") as! String)!)
        guestName.text = "做客嘉宾: " + (dataDict.objectForKey("view_lawyerName") as? String!)!
        interviewTextView.text = dataDict.objectForKey("view_content") as? String
        interviewTime.text = (dataDict.objectForKey("view_viewTime") as? String)! + " - " + (dataDict.objectForKey("view_endTime") as? String)!
        fellowButton.selected = dataDict.objectForKey("view_isAtten") as! Bool

        resizeTextView(interviewTextView)
    }
    
}
