
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
    @IBOutlet var LikedButton: UIButton!
    
    @IBAction func likedButtonClicked(sender: AnyObject) {
        if !LikedButton.selected
        {
            likeReply()
            LikedButton.selected = true
            //var likedCount = LikedButton.titleLabel!.text!.toInt()! + 1
            //LikedButton.setTitle(String(likedCount), forState: UIControlState.Normal)
            //LikedButton.setTitle(String(likedCount), forState: UIControlState.Selected)
        }
    }
    
    
    
    override func awakeFromNib() {
        LikedButton.setImage(UIImage(named:"buttonlikecommentgrey"), forState: UIControlState.Normal)
        LikedButton.setImage(UIImage(named:"buttonlikecommentblue"), forState: UIControlState.Selected)
    }
    
    func displayData(dataDict : NSDictionary)
    {
        let commentString = dataDict.objectForKey("comment") as! String
        CommentContent.numberOfLines = 0
        CommentContent.lineBreakMode = NSLineBreakMode.ByWordWrapping
        CommentContent.text = commentString
        
        var attCommentStr = NSAttributedString(string: CommentContent.text!)
        var range = NSMakeRange(0,attCommentStr.length)
        var strDict = attCommentStr.attributesAtIndex(0, effectiveRange: &range)
        var commentTextSize = attCommentStr.boundingRectWithSize(CommentContent.frame.size, options: NSStringDrawingOptions.UsesFontLeading, context: nil).size
        CommentContent.frame.size = commentTextSize
        
        //self.tag = dataDict.objectForKey("id") as! Int
        //UserImageView.sd_setImageWithURL(NSURL(string: dataDict.objectForKey("photoUrl") as! String), placeholderImage: UIImage(named:"pichead"))
        UserImageView.image = UIImage(named:"pichead")
        UserImageView.userId = dataDict.objectForKey("lawyerId") as! Int
        UserName.text = dataDict.objectForKey("lawyerName") as? String
        
        
        //var commentSize = NSString(string: CommentContent.text!).sizeWithAttributes(attrs: [NSObject : AnyObject]?)
        
        
        CommentTime.text = dateToText(NSDate(fromString: dataDict.objectForKey("createTime") as! String))
        LikedButton.setTitle(dataDict.objectForKey("praiseCount") as? String, forState: UIControlState.Normal)
        LikedButton.setTitle(dataDict.objectForKey("praiseCount") as? String, forState: UIControlState.Selected)
        
        
        
        LikedButton.setTitleColor(appBlueColor, forState: UIControlState.Selected)
        LikedButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        
        //let isMarked = (dataDict.objectForKey("isPraise") as! String).toInt()
        let isMarked = dataDict.objectForKey("isPraise") as? Int
        LikedButton.selected = Bool(isMarked!)
        
    }
    
    func likeReply()
    {
        DataClient().postLikeTopicReply(self.tag) { (data, error) -> () in
            dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                self.likeReplyCompleted(data,error: error)
                
            })
        }
    }
    
    func likeReplyCompleted(data:NSDictionary?,error:NSError?)
    {
        
        
        
    }
    
}
