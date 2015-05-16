
//
//  DiscussCommentTableViewCell.swift
//  Youlv
//
//  Created by Lost on 12/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//


import UIKit


class DiscussCommentTableViewCell: UITableViewCell {

    @IBOutlet var UserImageView: UIImageView!
    @IBOutlet var UserName: UILabel!
    @IBOutlet var CommentContent: UILabel!
    @IBOutlet var CommentTime: UILabel!
    @IBOutlet var LikedButton: UIButton!
    

    
    override func awakeFromNib() {
        LikedButton.setImage(UIImage(named:"buttonlikecommentgrey"), forState: UIControlState.Normal)
        LikedButton.setImage(UIImage(named:"buttonlikecommentblue"), forState: UIControlState.Selected)
    }
    
    func displayData(dataDict : NSDictionary)
    {

        UserImageView.sd_setImageWithURL(NSURL(string: dataDict.objectForKey("photoUrl") as! String))
        UserName.text = dataDict.objectForKey("lawyerName") as? String
        CommentContent.text = dataDict.objectForKey("content") as? String
        CommentTime.text = dataDict.objectForKey("operate_createDate") as? String
        LikedButton.setTitle(nil, forState: UIControlState.Normal)
        LikedButton.setTitle(dataDict.objectForKey("praiseCount") as? String, forState: UIControlState.Selected)
    
        let isMarked = (dataDict.objectForKey("isPraise") as! String).toInt()
        if Bool(isMarked!)
        {
            LikedButton.selected = true
        }
        else
        {
            LikedButton.selected = false
        }
        
    }
}
