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
    
    
    func setData(dataDict : NSDictionary)
    {
        var isLive = true
        if isLive
        {
            isLiveImageView.image = UIImage(named:"icononlive")
        }
        else
        {
            isLiveImageView.image = UIImage(named:"iconover")
        }
        
    }
    
    func resizeTextView()
    {
        let size = CGSizeMake(self.frame.size.width - 20, CGFloat.max)
        
        let textSize = interviewTextView.text.sizeWithAttributes([NSFontAttributeName:UIFont.systemFontOfSize(14)])
        interviewTextView.frame.size = textSize
        
    }

}
