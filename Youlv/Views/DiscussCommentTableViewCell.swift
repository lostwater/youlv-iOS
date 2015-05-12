
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
    
    var dataDict : NSDictionary?
    
    override func awakeFromNib() {
        LikedButton.setImage(UIImage(named:"buttonlikecommentgrey"), forState: UIControlState.Normal)
        LikedButton.setImage(UIImage(named:"buttonlikecommentblue"), forState: UIControlState.Selected)
    }
    
    func setData(dataDict : NSDictionary)
    {
        self.dataDict = dataDict
        UserImageView.sd_setImageWithURL(NSURL(string: self.dataDict!.objectForKey("photoUrl") as! String))
        UserName.text = self.dataDict!.objectForKey("lawyerName") as? String
        CommentContent.text = self.dataDict!.objectForKey("content") as? String
        CommentTime.text = self.dataDict!.objectForKey("operate_createDate") as? String
        LikedButton.setTitle(nil, forState: UIControlState.Normal)
        LikedButton.setTitle(self.dataDict!.objectForKey("praiseCount") as? String, forState: UIControlState.Selected)
    
        let isMarked = (self.dataDict!.objectForKey("isPraise") as! String).toInt()
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