//
//  ArticleTableViewCell.swift
//  Youlv
//
//  Created by Lost on 04/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet var userName: UILabel!
    @IBOutlet var articleTime: UILabel!
    @IBOutlet var articleImageView: UIImageView!
    @IBOutlet var articleTitle: UILabel!
    @IBOutlet var articleTextView: UITextView!
    
    @IBOutlet var commentButton: UIButton!
    @IBOutlet var likedButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commentButton.setImage(UIImage(named:"buttoncommentoutline"), forState: UIControlState.Normal)
        commentButton.setImage(UIImage(named:"buttoncomment"), forState: UIControlState.Selected)
        likedButton.setImage(UIImage(named:"buttonheartoutline"), forState: UIControlState.Normal)
        likedButton.setImage(UIImage(named:"buttonheart"), forState: UIControlState.Selected)
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
        self.tag = (dataDict.objectForKey("articleId") as? Int)!
        articleImageView.sd_setImageWithURL(NSURL(string: dataDict.objectForKey("url") as! String))
        articleTitle.text = dataDict.objectForKey("title") as? String
        articleTextView.text =  dataDict.objectForKey("acro") as? String
        userName.text = dataDict.objectForKey("lawyerName") as? String
        articleTime.text =  defaultDateFormatter.stringFromDate(NSDate(fromString: (dataDict.objectForKey("createDate") as! String)))
        commentButton.setTitle(String(dataDict.objectForKey("commentCount") as! Int), forState: UIControlState.Normal)
        commentButton.setTitle(String(dataDict.objectForKey("commentCount") as! Int), forState: UIControlState.Selected)
        likedButton.setTitle(String(dataDict.objectForKey("storeCount") as! Int), forState: UIControlState.Normal)
        likedButton.setTitle(String(dataDict.objectForKey("storeCount") as! Int), forState: UIControlState.Selected)
        let isLiked = dataDict.objectForKey("isStore") as! Bool
        if isLiked
        {
            likedButton.selected = true
        }
        else
        {
            likedButton.selected = false
        }
        
    }

    
}
