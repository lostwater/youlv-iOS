//
//  OpportunityDetailViewController.swift
//  Youlv
//
//  Created by Lost on 09/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class OpportunityDetailViewController: UIViewController {
    
    var dataDict : NSDictionary?
    var opportunityType : OpportunityType?
    var opportunityId = 0
    
    @IBOutlet var naviItem: UINavigationItem!
    @IBOutlet var naviEditButton: UIBarButtonItem!
    @IBOutlet var naviHelpButton: UIBarButtonItem!
    @IBOutlet var opportunityImageView: UIImageView!
    @IBOutlet var opportunityTitle: UILabel!
    @IBOutlet var opportunityTags: DWTagList!
    @IBOutlet var opportunityTextView: UILabel!
    @IBOutlet var opportunityValidUntil: UILabel!
    @IBOutlet var opportunityCityButton: UIButton!
    @IBOutlet var opportunityPayment: UILabel!
    @IBOutlet var opportunityPaymentImageView: UIImageView!
    
     @IBOutlet weak var tagHeight: NSLayoutConstraint!
    
    @IBOutlet var textViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var paymentHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet var publisherCreditView: RSTapRateView!
    @IBOutlet var publisherImageView: AvatarImageView!
    @IBOutlet var publisherFansCount: UILabel!
    @IBOutlet var publisherPublicationsCount: UILabel!
    @IBOutlet var publisherInterestsCount: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentButton: UIButton!
    @IBAction func sendAndUnwindFromComment(segue: UIStoryboardSegue)
    {
        //performSegueWithIdentifier("UnwindToGroupTopics", sender: self)
    }
    @IBAction func likeButtonClicked(sender: AnyObject) {
        httpClient.opportunityUp(caseId) { (dict, error) -> () in
            self.likeButton.selected = !self.likeButton.selected
        }
    }
    @IBAction func btnHelpClicked(sender: AnyObject) {
        let av = UIAlertView(title: nil, message: "更多疑问，可以拨打客服电话4400-865-8605，或发送邮件给我info@iruyi.com", delegate: nil, cancelButtonTitle: "确定")
        av.show()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
   
    var caseId = 0
    func configure(dict : NSDictionary)
    {
        caseId = dict.objectForKey("case_id") as! Int
        var type = dict.objectForKey("type") as! Int
        opportunityTitle.text = dict.objectForKey("title") as? String
        
        let tagList = dict.objectForKey("tag") as! NSArray
        let tagnames = tagList.mutableArrayValueForKey("name")
        
        if tagnames.count > 0
        {
            opportunityTags.setTags(tagnames as [AnyObject])
            opportunityTags.display()
            tagHeight?.constant = opportunityTags.fittedSize().height ?? 0
            
            if tagHeight?.constant < 30
            {
                tagHeight?.constant = 30
            }
            view.setNeedsUpdateConstraints()
            view.setNeedsLayout()
            view.updateConstraintsIfNeeded()
            view.layoutIfNeeded()
        }

        
        opportunityTextView.text = dict.objectForKey("text") as? String
        
        opportunityCityButton.setTitle(dict.objectForKey("target") as? String, forState: UIControlState.Normal)
        opportunityValidUntil.text = "截止到: " + defaultDateFormatter.stringFromDate(NSDate(fromString: dict.objectForKey("deadline") as! String))
        
        //opportunityPayment.text = "协作佣金: " + String(dataDict!.objectForKey("order_price") as! Int)
        //opportunityLikedButton.titleLabel?.text = String(dataDict!.objectForKey("order_interestCount") as! Int)
        //resizeTextView(opportunityTextView)
        if type == 0
        {
            type = 1
        }
        setOpportunityType(OpportunityType(rawValue: type)!)
        
        
        let userDict = dict.objectForKey("user") as! NSDictionary
        publisherCreditView.rating = userDict.objectForKey("credit") as! Int
        publisherImageView.sd_setImageWithURL(NSURL(string:userDict.objectForKey("avatar") as! String), placeholderImage: headImage)
        publisherFansCount.text = String(userDict.objectForKey("followed_num") as! Int)
        publisherImageView.userId = userDict.objectForKey("uid") as! Int
        publisherImageView.userDict = userDict
        publisherPublicationsCount.text = String(userDict.objectForKey("casesource_upload_num") as! Int)
        publisherInterestsCount.text = String(userDict.objectForKey("casesource_interest_num") as! Int)
        
    }
  

    
    
    override func viewDidLoad() {
        
        //likeButton.hidden = true
        //commentButton.hidden = true
        likeButton.setImage(UIImage(named:"buttonheartoutline"), forState: UIControlState.Normal)
        likeButton.setImage(UIImage(named:"buttonheart"), forState: UIControlState.Selected)
        likeButton.setTitle( "我感兴趣", forState: UIControlState.Normal)
        likeButton.setTitle( "不感兴趣", forState: UIControlState.Selected)


        if dataDict != nil
        {
            configure(dataDict!)
        }
        
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goOpportunityComment"
        {
            let vc = segue.destinationViewController as! OpportunityCommentViewController
            vc.opportunityId = opportunityId
        }
    }

    
    func setOpportunityType(opportunityType : OpportunityType)
    {
        self.opportunityType = opportunityType
        if(self.opportunityType != nil)
        {
            switch self.opportunityType!
            {
            case OpportunityType.Case:
                opportunityTags.hidden = true
                opportunityPayment.hidden = true
                opportunityPaymentImageView.hidden = true
                opportunityImageView.image = UIImage(named: "iconcase")
                naviItem.rightBarButtonItem = naviEditButton
                //naviItem.title = "案源流转"
                paymentHeightConstraint.constant = 0


            case OpportunityType.Outsourcing:
                opportunityTags.hidden = false
                opportunityPayment.hidden = false
                opportunityPaymentImageView.hidden = false
                opportunityImageView.image = UIImage(named: "iconcooperation")
                naviItem.rightBarButtonItem = naviHelpButton
                naviItem.title = "协作外包"
                paymentHeightConstraint.constant = 20

            case OpportunityType.Biz:
                opportunityTags.hidden = false
                opportunityPayment.hidden = true
                opportunityPaymentImageView.hidden = true
                naviItem.rightBarButtonItem = naviEditButton
                //naviItem.title = "商业信息"
                paymentHeightConstraint.constant = 0

            }
        }
        
    }

    



}
