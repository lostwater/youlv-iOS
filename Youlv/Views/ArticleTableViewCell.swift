//
//  ArticleTableViewCell.swift
//  Youlv
//
//  Created by Lost on 04/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var articleTime: UILabel!
    @IBOutlet var userTextView: UITextView!
    @IBOutlet var articleImageView: UIImageView!
    @IBOutlet var articleTitle: UILabel!
    @IBOutlet var articleTextView: UITextView!
    
    @IBOutlet var commentButton: UIButton!
    @IBOutlet var likedButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commentButton.setImage(UIImage(named:"buttoncommentoutline"), forState: UIControlState.Normal)
        commentButton.setImage(UIImage(named:"buttoncomment"), forState: UIControlState.Selected)
        likedButton.setImage(UIImage(named:"buttonlikeoutline"), forState: UIControlState.Normal)
        likedButton.setImage(UIImage(named:"buttonlike"), forState: UIControlState.Selected)
        commentButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        commentButton.setTitleColor(appBlueColor, forState: UIControlState.Selected)
        likedButton.setTitleColor(UIColor.grayColor(), forState: UIControlState.Normal)
        likedButton.setTitleColor(appBlueColor, forState: UIControlState.Selected)
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func displayData(dataDict : NSDictionary)
    {
        
        //userImageView.sd_setImageWithURL(NSURL(string: dataDict.objectForKey("photoUrl") as! String))
        //userName.text = dataDict.objectForKey("lawyerName") as? String
        articleTextView.text =  dataDict.objectForKey("acro") as? String
        //CommentContent.text = dataDict.objectForKey("content") as? String
        //CommentTime.text = dataDict.objectForKey("operate_createDate") as? String
        likedButton.setTitle(dataDict.objectForKey("praiseCount") as? String, forState: UIControlState.Normal)
        likedButton.setTitle(dataDict.objectForKey("praiseCount") as? String, forState: UIControlState.Selected)
        commentButton.setTitle(dataDict.objectForKey("commentCount") as? String, forState: UIControlState.Normal)
        commentButton.setTitle(dataDict.objectForKey("commentCount") as? String, forState: UIControlState.Selected)
        let isLiked = (dataDict.objectForKey("isPraise") as! String).toInt()
        if Bool(isLiked!)
        {
            likedButton.selected = true
        }
        else
        {
            likedButton.selected = false
        }
        
    }

    
}
