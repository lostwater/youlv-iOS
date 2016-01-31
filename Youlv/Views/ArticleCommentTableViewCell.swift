
//
//  DiscussCommentTableViewCell.swift
//  Youlv
//
//  Created by Lost on 12/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//


import UIKit


class ArticleCommentTableViewCell: UITableViewCell {
    
    @IBOutlet var UserImageView: AvatarImageView!
    @IBOutlet var UserName: UILabel!
    @IBOutlet var CommentContent: UILabel!
    @IBOutlet var CommentTime: UILabel!
    @IBOutlet var LikedButton: UIButton?
    
    @IBAction func likedButtonClicked(sender: AnyObject) {
   
    }
    
    
    
    override func awakeFromNib() {
        LikedButton?.setImage(UIImage(named:"buttonlikecommentgrey"), forState: UIControlState.Normal)
        LikedButton?.setImage(UIImage(named:"buttonlikecommentblue"), forState: UIControlState.Selected)
    }
    
    func configure(dict : NSDictionary)
    {
        let userDict = dict.objectForKey("user") as! NSDictionary
        UserImageView.sd_setImageWithURL(NSURL(string: userDict.objectForKey("avatar") as! String), placeholderImage: UIImage(named:"pichead"))
        UserImageView.userId = userDict.objectForKey("uid") as! Int
        UserImageView.userDict = userDict
        
        CommentContent.text = dict.objectForKey("comment") as? String
    
        CommentTime.text = dateToText(NSDate(fromString: dict.objectForKey("ctime") as! String))
        //LikedButton.setTitle(dataDict.objectForKey("praiseCount") as? String, forState: UIControlState.Normal)
        //LikedButton.setTitle(dataDict.objectForKey("praiseCount") as? String, forState: UIControlState.Selected)
        
        LikedButton?.setTitleColor(appBlueColor, forState: UIControlState.Selected)
        LikedButton?.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        
        //let isMarked = (dataDict.objectForKey("isPraise") as! String).toInt()
        //let isMarked = dataDict.objectForKey("isPraise") as? Int
        //LikedButton.selected = Bool(isMarked!)
        
    }

}
