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
    
    @IBOutlet weak var shareMenuView: UIView!
    @IBOutlet var gesture: UITapGestureRecognizer!
    
    @IBAction func shareClicked(sender: AnyObject) {
        shareMenuView.hidden = !shareMenuView.hidden
    }
    
    @IBAction func viewTapped(sender: AnyObject) {
        shareMenuView.hidden = true
    }
    @IBAction func likedButtonClicked(sender: AnyObject) {
        httpClient.articleUp(articleId!) { (dict, error) -> () in
            self.likedButton.selected = !self.likedButton.selected
        }

    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(dataDict != nil)
        {
            displayData(dataDict!)
        }
        likedButton.setTitle("点赞", forState: UIControlState.Normal)
        likedButton.setTitle("取消点赞", forState: UIControlState.Selected)

        likedButton.setImage(UIImage(named:"buttonlikeoutline"), forState: UIControlState.Normal)
        likedButton.setImage(UIImage(named:"buttonlike"), forState: UIControlState.Selected)
    }
    
    func displayData(dataDict : NSDictionary)
    {
        let userDict = dataDict.objectForKey("user") as! NSDictionary
        articleId = (dataDict.objectForKey("article_id") as? Int)!
        userImageView.image = headImage
        userName.text = userDict.objectForKey("name") as? String
        
        articleTime.text = defaultDateFormatter.stringFromDate(NSDate(fromString: (dataDict.objectForKey("ctime") as! String)))
        articleImageView.sd_setImageWithURL(NSURL(string: dataDict.objectForKey("article_img") as! String),placeholderImage:defualtPic)
        articleTitle.text = dataDict.objectForKey("title") as? String
        articleTextView.text =  dataDict.objectForKey("text") as? String
        //commentButton.setTitle(String(dataDict.objectForKey("comment_num") as! Int) + "条评论", forState: UIControlState.Normal)
        //commentButton.setTitle(String(dataDict.objectForKey("comment_num") as! Int) + "条评论", forState: UIControlState.Selected)
        likedButton.selected  = dataDict.objectForKey("up_or_not") as! Bool


    }

    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goArticleComments"
        {
            let vc = segue.destinationViewController as!ArticleCommentsTableViewController
            vc.articleId = articleId
        }
    }

    
}
