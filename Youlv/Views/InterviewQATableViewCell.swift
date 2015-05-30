//
//  InterviewQATableViewCell.swift
//  Youlv
//
//  Created by Lost on 15/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class InterviewQATableViewCell: UITableViewCell {

    @IBOutlet var userImageView: AvatarImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var likedButton: UIButton!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var qOrALabel: UILabel!
    @IBOutlet var contentTextView: UITextView!
    
    @IBAction func likedButtonClicked(sender: AnyObject) {
        if !likedButton.selected
        {
            likeComment()
        }
    }
    
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
        self.tag = dataDict.objectForKey("discuss_id") as! Int
        userImageView.userId = dataDict.objectForKey("discuss_lawyerId") as! Int
        userImageView.sd_setImageWithURL(NSURL(string:dataDict.objectForKey("discuss_lawyerPhotoUrl") as! String)!, placeholderImage: headImage)
        
        userName.text = dataDict.objectForKey("discuss_lawyerName") as? String
        likedButton.setTitle(String(dataDict.objectForKey("discuss_praiseCount") as! Int), forState: UIControlState.Selected)
        likedButton.setTitle(String(dataDict.objectForKey("discuss_praiseCount") as! Int), forState: UIControlState.Normal)
        likedButton.selected  = dataDict.objectForKey("discuss_isPraise") as! Bool
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
        timeLabel.text = dateToText(NSDate(fromString: dataDict.objectForKey("discuss_createDate") as! String))
        contentTextView.text = dataDict.objectForKey("discuss_content") as? String
        
        resizeTextView(contentTextView)
    }
    
    
    func likeComment()
    {
            DataClient().postLikeInterviewComment(self.tag) { (data, error) -> () in
                dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                    self.likeCommentCompleted(data,error: error)})
        }
    }
    
    func likeCommentCompleted(data:NSDictionary?,error:NSError?)
    {
        if data?.objectForKey("errcode") as? Int == 0
        {
            let count = likedButton.titleLabel!.text!.toInt()! + 1
            likedButton.setTitle(String(count), forState: UIControlState.Selected)
            likedButton.selected = true
        }
      
    }

}
