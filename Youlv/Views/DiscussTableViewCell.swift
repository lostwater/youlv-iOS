//
//  DiscussTableViewCell.swift
//  Youlv
//
//  Created by Lost on 11/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit


enum DiscussOperateType: Int
{
    case Post = 0, Reply, Bookmark
}

class DiscussTableViewCell: UITableViewCell
{
    var discussOperateType : DiscussOperateType?
    var dataDict : NSDictionary?

    @IBOutlet var topicUserImageViewer: UIImageView?
    @IBOutlet var operatorImageView: UIImageView?
    @IBOutlet var topicUserName: UILabel?
    @IBOutlet var operatorName: UILabel?
    @IBOutlet var operatorTime: UILabel!
    @IBOutlet var bookMarkedButton: UIButton!
    @IBOutlet var topicTextView: UITextView!
    @IBOutlet var operatorTextView: UITextView?
    
    @IBOutlet var topicTextHeightConstraint: NSLayoutConstraint!
    @IBOutlet var operatorTextHeightConstraint: NSLayoutConstraint?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    func setData(dataDict : NSDictionary)
    {
        self.dataDict = dataDict
        discussOperateType = DiscussOperateType(rawValue: dataDict.objectForKey("operate_type") as! Int)
        let topic_photoUrl = dataDict.objectForKey("topic_photoUrl") as! String
        let operate_photoUrl = dataDict.objectForKey("operate_photoUrl") as! String
       // topicUserImageViewer?.sd_setImageWithURL(NSURL(string: topic_photoUrl))
        //operatorImageView?.sd_setImageWithURL(NSURL(string: operate_photoUrl))
        topicUserName?.text = dataDict.objectForKey("topic_lawyerName") as? String
        operatorName?.text = dataDict.objectForKey("operate__lawyerName") as? String
        operatorTime.text = dataDict.objectForKey("operate_createDate") as? String
        bookMarkedButton.setTitle(String(dataDict.objectForKey("topic_praiseCount") as! Int)
, forState: UIControlState.Normal)
        bookMarkedButton.setTitle(String(dataDict.objectForKey("topic_praiseCount") as! Int)
            , forState: UIControlState.Normal)
        bookMarkedButton.setImage(UIImage(named: "iconfavorite"), forState: UIControlState.Selected)
        bookMarkedButton.setImage(UIImage(named: "iconfavoriteoutline"), forState: UIControlState.Normal)
        let isMarked = dataDict.objectForKey("topic_isPraise") as! Bool
        if isMarked
        {
            bookMarkedButton.selected = true
        }
        else
        {
            bookMarkedButton.selected = false
        }
        topicTextView.text = dataDict.objectForKey("topic_content") as? String
        operatorTextView?.text = dataDict.objectForKey("operate_content") as? String
        resetTextViewSize()


    }
    
    func resetTextViewSize()
    {

            let topicContentText = dataDict!.objectForKey("topic_content") as! NSString
            let topicSize = CGSizeMake(topicTextView.frame.size.width, CGFloat.max)
            let topicTextSize = topicContentText.sizeWithAttributes([NSFontAttributeName:UIFont.systemFontOfSize(14)])
            topicTextHeightConstraint.constant = topicTextSize.height+8
            //topicTextView.frame.size = topicTextSize
                //CGSizeMake(topicTextView.frame.size.width, topicTextSize.height)


        if operatorTextView != nil
        {
            let operatorContentText = dataDict!.objectForKey("operate_content") as! NSString
            let operatorSize = CGSizeMake(operatorTextView!.frame.size.width, CGFloat.max)
            let operatorTextSize = topicContentText.sizeWithAttributes([NSFontAttributeName:UIFont.systemFontOfSize(14)])
            operatorTextHeightConstraint?.constant=operatorTextSize.height+8
            //operatorTextView?.frame.size = operatorTextSize
            //CGSizeMake(operatorTextView!.frame.size.width, operatorTextSize.height)
        }
        
    }
}
