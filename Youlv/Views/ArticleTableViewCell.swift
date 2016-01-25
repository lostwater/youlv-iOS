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
    //@IBOutlet var articleTextView: UITextView!
    @IBOutlet weak var articleContent: UILabel!
    
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
    
    
    func configure(dataDict : NSDictionary)
    {
        let userDict = dataDict.objectForKey("user") as! NSDictionary
        self.tag = (dataDict.objectForKey("article_id") as? Int)!
        
        articleImageView.sd_setImageWithURL(NSURL(string: dataDict.objectForKey("article_img") as! String),placeholderImage:defualtPic)
        articleTitle.text = dataDict.objectForKey("title") as? String
        articleContent.text =  dataDict.objectForKey("text") as? String

        userName.text = userDict.objectForKey("name") as? String
        articleTime.text =  defaultDateFormatter.stringFromDate(NSDate(fromString: (dataDict.objectForKey("ctime") as! String)))
        
        //commentButton.setTitle(String(dataDict.objectForKey("commentCount") as! Int), forState: UIControlState.Normal)
        //commentButton.setTitle(String(dataDict.objectForKey("commentCount") as! Int), forState: UIControlState.Selected)
        //likedButton.setTitle(String(dataDict.objectForKey("storeCount") as! Int), forState: UIControlState.Normal)
        //likedButton.setTitle(String(dataDict.objectForKey("storeCount") as! Int), forState: UIControlState.Selected)
        likedButton.selected  = dataDict.objectForKey("up_or_not") as! Bool

    }

    
}
