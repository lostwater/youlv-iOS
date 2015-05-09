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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    
    override func viewDidLoad() {
        if dataDict != nil
        {
            let type = dataDict!.objectForKey("order_type") as! Int
           
            opportunityTitle.text = dataDict!.objectForKey("order_title") as?	 String
            opportunityTextView.text = dataDict!.objectForKey("order_content") as! String
            opportunityCityButton.setTitle(dataDict!.objectForKey("order_cityName") as? String, forState: UIControlState.Normal)
            opportunityValidUntil.text = dataDict!.objectForKey("order_deadDate") as? String
            opportunityPayment.text = "协作佣金: " + String(dataDict!.objectForKey("order_price") as! Int)
             opportunityTags.setTags(NSArray(object: dataDict!.objectForKey("order_keyWords")!) as [AnyObject])
            opportunityTags.display()
            //opportunityLikedButton.titleLabel?.text = String(dataDict!.objectForKey("order_interestCount") as! Int)
            textViewHeightConstraint.constant = resetTextViewSize()
            setOpportunityType(OpportunityType(rawValue: type)!)
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
