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
    @IBOutlet var opportunityTextView: UITextView!
    @IBOutlet var opportunityValidUntil: UILabel!
    @IBOutlet var opportunityCityButton: UIButton!
    @IBOutlet var opportunityPayment: UILabel!
    @IBOutlet var opportunityPaymentImageView: UIImageView!
    
    
    @IBOutlet var textViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var paymentHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet var publisherCreditView: RSTapRateView!
    @IBOutlet var publisherImageView: UIImageView!
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
        likeOpportunity()


    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    func likeOpportunity()
    {
        var parameters : NSDictionary = ["orderId":opportunityId, "sessionId":sessionId]
        DataClient().postLikeOpportunity(parameters) { (data, error) -> () in
            dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                self.likeOpportunityCompleted(data,error: error)
                
            })
        }
    }
    
    func likeOpportunityCompleted(data:NSDictionary?,error:NSError?)
    {
        UIAlertView(title: data?.objectForKey("errmessage") as? String, message: nil, delegate: nil, cancelButtonTitle: "ok").show()
        if data?.objectForKey("errcode") as? Int == 0
        {
            likeButton.hidden = true
            commentButton.hidden = false
        }
        
    }
    
    /*
    "lawyerRelate":{
    "lawyer_id":1,
    "lawyer_name":"zhangsan",
    "lawyer_photoUrl":"111111",
    "fansCount":3,
    "issueCount":2,
    "interestCountMy":5
    */
    func getPubishUser()
    {
        DataClient().getOrderDetail(opportunityId, completion: { (data, error) -> () in
            self.getPubishUserCompleted(data,error: error)
        })
    }
    
    func getPubishUserCompleted(data:NSData?,error:NSError?)
    {
        if error != nil
        {
            return
        }
        let errorPointer = NSErrorPointer()
        let dict = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves, error: errorPointer) as? NSDictionary
        if dict == nil
        {
           return
        }
        if dict?.objectForKey("errcode") as? Int == 1
        {
            return
        }
        
        let userData = (dict!.objectForKey("data") as! NSDictionary).objectForKey("lawyerRelate") as! NSDictionary
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.displayData(userData)
        })
        
    }
    
    func displayData(dataDict : NSDictionary)
    {
        publisherCreditView.rating = 5
        publisherImageView.sd_setImageWithURL(NSURL(string:dataDict.objectForKey("lawyer_photoUrl") as! String), placeholderImage: headImage)
        publisherFansCount.text = String(dataDict.objectForKey("fansCount") as! Int)
        publisherPublicationsCount.text = String(dataDict.objectForKey("issueCount") as! Int)
        publisherInterestsCount.text = String(dataDict.objectForKey("interestCountMy") as! Int)
    }
    
    
    
    override func viewDidLoad() {
        if dataDict != nil
        {
            let type = dataDict!.objectForKey("order_type") as! Int
           
            opportunityTitle.text = dataDict!.objectForKey("order_title") as?	 String
            opportunityTextView.text = dataDict!.objectForKey("order_content") as! String
            opportunityCityButton.setTitle(dataDict!.objectForKey("order_cityName") as? String, forState: UIControlState.Normal)
            opportunityValidUntil.text = "截止到: " + defaultDateFormatter.stringFromDate(NSDate(fromString: dataDict!.objectForKey("order_deadDate") as! String))

            opportunityPayment.text = "协作佣金: " + String(dataDict!.objectForKey("order_price") as! Int)
             opportunityTags.setTags(NSArray(object: dataDict!.objectForKey("order_keyWords")!) as [AnyObject])
            opportunityTags.display()
            //opportunityLikedButton.titleLabel?.text = String(dataDict!.objectForKey("order_interestCount") as! Int)
            textViewHeightConstraint.constant = resetTextViewSize()
            setOpportunityType(OpportunityType(rawValue: type)!)
            
            
            if (dataDict!.objectForKey("order_isInterest") as! Bool)
            {
                likeButton.hidden = true
                commentButton.hidden = false
            }
            else
            {
                likeButton.hidden = false
                commentButton.hidden = true
            }
            
            getPubishUser()
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
                naviItem.title = "案源流转"
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
                naviItem.title = "商业信息"
                paymentHeightConstraint.constant = 0

            }
        }
        
    }
    
    func resetTextViewSize() -> CGFloat
    {
        let size = CGSizeMake(self.view.frame.size.width - 20, CGFloat.max)
        
        let textSize = opportunityTextView.text.sizeWithAttributes([NSFontAttributeName:UIFont.systemFontOfSize(14)])
        opportunityTextView.frame.size = textSize
        return textSize.height
    }

}
