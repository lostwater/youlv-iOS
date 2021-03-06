
//
//  DiscussCommentTableViewCell.swift
//  Youlv
//
//  Created by Lost on 12/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//


import UIKit


class DiscussCommentTableViewCell: UITableViewCell {

    @IBOutlet var UserImageView: AvatarImageView!
    @IBOutlet var UserName: UILabel!
    @IBOutlet var CommentContent: UILabel!
    @IBOutlet var CommentTime: UILabel!
    @IBOutlet var LikedButton: UIButton!
    
    @IBAction func likedButtonClicked(sender: AnyObject) {
        likeReply()
    }
    
   
    
    override func awakeFromNib() {
        LikedButton.setImage(UIImage(named:"buttonlikecommentgrey"), forState: UIControlState.Normal)
        LikedButton.setImage(UIImage(named:"buttonlikecommentblue"), forState: UIControlState.Selected)
    }
    
    func configure(dict : NSDictionary)
    {
        let userDict = dict.objectForKey("user") as! NSDictionary
        CommentContent.text = dict.objectForKey("comment") as? String
        tag = dict.objectForKey("topicevent_id") as! Int
        
        UserImageView.sd_setImageWithURL(NSURL(string: userDict.objectForKey("avatar") as! String), placeholderImage: UIImage(named:"pichead"))
        UserImageView.userId = userDict.objectForKey("uid") as! Int
        UserName.text = userDict.objectForKey("name") as? String
        UserImageView.userDict = userDict
        
        CommentTime.text = dateToText(NSDate(fromString: dict.objectForKey("ctime") as! String))
        LikedButton.setTitle(dict.objectForKey("up_num") as? String, forState: UIControlState.Normal)
        LikedButton.setTitle(dict.objectForKey("up_num") as? String, forState: UIControlState.Selected)
        
        LikedButton.setTitleColor(appBlueColor, forState: UIControlState.Selected)
        LikedButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        
        LikedButton.selected = dict.objectForKey("up_or_not") as! Bool


    }
    
    
    func likeReply()
    {
        httpClient.topicEventUp(tag) { (dict, error) -> () in
            self.likeReplyCompleted(dict, error: error)
        }
    }
    
    func likeReplyCompleted(data:NSDictionary?,error:NSError?)
    {

        if !LikedButton.selected
        {
            LikedButton.selected = true
            //let likedCount = Int(LikedButton.titleLabel!.text!)! + 1
            //LikedButton.setTitle(String(likedCount), forState: UIControlState.Normal)
            //LikedButton.setTitle(String(likedCount), forState: UIControlState.Selected)
        }
        else
        {
            LikedButton.selected = false
            //let likedCount = Int(LikedButton.titleLabel!.text!)! - 1
            //LikedButton.setTitle(String(likedCount), forState: UIControlState.Normal)
           // LikedButton.setTitle(String(likedCount), forState: UIControlState.Selected)
        }
        
    }

}
