//
//  ArticleDetailViewController.swift
//  Youlv
//
//  Created by Lost on 13/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class ArticleDetailViewController: UIViewController {

    var articleId : Int?
    var dataDict : NSDictionary?
    
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var articleTime: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleTextView: UITextView!
    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var likedButton: UIButton!
    
    @IBAction func likedButtonClicked(sender: AnyObject) {
        if  !likedButton.selected
        {
            likeThis()
        }

    }
    
    
    override func viewDidLoad() {
        if(dataDict != nil)
        {
            displayData(dataDict!)
        }
        likedButton.setImage(UIImage(named:"buttoninterestlargeoutline"), forState: UIControlState.Normal)
        likedButton.setImage(UIImage(named:"buttoninterestlarge"), forState: UIControlState.Selected)
    }
    
    func displayData(dataDict : NSDictionary)
    {
        articleId = (dataDict.objectForKey("articleId") as? Int)!
        userImageView.image = headImage
        userName.text = dataDict.objectForKey("lawyerName") as? String
        
        articleTime.text = defaultDateFormatter.stringFromDate(NSDate(fromString: (dataDict.objectForKey("createDate") as! String)))
        articleImageView.sd_setImageWithURL(NSURL(string: dataDict.objectForKey("url") as! String),placeholderImage:defualtPic)
        articleTitle.text = dataDict.objectForKey("title") as? String
        articleTextView.text =  dataDict.objectForKey("acro") as? String
        //commentButton.setTitle(String(dataDict.objectForKey("commentCount") as! Int), forState: UIControlState.Normal)
        //commentButton.setTitle(String(dataDict.objectForKey("commentCount") as! Int), forState: UIControlState.Selected)
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
    
    func likeThis()
    {
        var parameters : NSDictionary = ["articleId":articleId!,"sessionId":sessionId]
        DataClient().postLikeArticle(parameters) { (data, error) -> () in
                self.likeThisCompleted(data,error: error)
        }
    }
    
    func likeThisCompleted(data:NSDictionary?,error:NSError?)
    {
        if data?.objectForKey("errcode") as? Int == 0
        {
            dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                self.likedButton.selected = true
            })
          
        }       
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goArticleComments"
        {
            let vc = segue.destinationViewController as!ArticleCommentsTableViewController
            vc.articleId = articleId
        }
    }

    
}
