//
//  HomeItemTableViewCell.swift
//  Youlv
//
//  Created by Lost on 03/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

enum OpportunityType: Int
{
    case Case = 1, Outsourcing, Biz
}


class OpportunityTableViewCell: UITableViewCell {

    var opportunityType : OpportunityType?
    
    var contentHeight : CGFloat {
        get
        {
            return 160+resetTextViewSize()         }
    }
    
    @IBOutlet weak var opportunityTitleLable: UILabel!
    @IBOutlet weak var userPubulishedLable: UILabel!
    @IBOutlet weak var opportunityIconImageView: UIImageView!
    @IBOutlet weak var opportunityValidUntilLable: UILabel!
    @IBOutlet weak var opportunityLocalButton: UIButton!
    @IBOutlet weak var opportunityTextView: UITextView!
    @IBOutlet weak var opportunityTagsList: DWTagList!
    @IBOutlet weak var opportunityLikedButton: UIButton!
    @IBOutlet var userCreditRate: RSTapRateView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        // Initialization code
    }
    
    func displayData(dataDict : NSDictionary)
    {
        let type = dataDict.objectForKey("order_type") as! Int
        setOpportunityType(OpportunityType(rawValue: type)!,dataDict: dataDict)
        opportunityTextView.text = dataDict.objectForKey("order_content") as! String
        opportunityLocalButton.setTitle(dataDict.objectForKey("order_cityName") as? String, forState: UIControlState.Normal)
        opportunityValidUntilLable.text = defaultDateFormatter.stringFromDate(NSDate(fromString: dataDict.objectForKey("order_deadDate") as! String))
        opportunityLikedButton.setTitle( String(dataDict.objectForKey("order_interestCount") as! Int), forState: UIControlState.Normal)
        opportunityLikedButton.setTitle( String(dataDict.objectForKey("order_interestCount") as! Int), forState: UIControlState.Selected)
        
        opportunityTextView.frame.size = CGSize(width:opportunityTextView.frame.size.width, height:opportunityTextView.contentSize.height)
        opportunityTagsList.setTags(NSArray(object: dataDict.objectForKey("order_keyWords")!) as [AnyObject])
      
        
        userCreditRate.rating = 5
        opportunityTagsList.display()
        frame.size = CGSize(width:frame.size.width, height:contentHeight)

    }
    
    func resetTextViewSize() -> CGFloat
    {
        let size = CGSizeMake(self.frame.size.width - 20, CGFloat.max)
        
        let textSize = opportunityTextView.text.sizeWithAttributes([NSFontAttributeName:UIFont.systemFontOfSize(14)])
        opportunityTextView.frame.size = textSize
        return textSize.height
    }
    
    func setOpportunityType(opportunityType : OpportunityType,dataDict : NSDictionary )
    {
        self.opportunityType = opportunityType
        if(self.opportunityType != nil)
        {
            switch self.opportunityType!
            {
            case OpportunityType.Case:
                opportunityTagsList.hidden = true
                userPubulishedLable.hidden = true
                opportunityIconImageView.image = UIImage(named: "iconcase")
                opportunityTitleLable.text = dataDict.objectForKey("order_title") as? String
            case OpportunityType.Outsourcing:
                opportunityTagsList.hidden = false
                userPubulishedLable.hidden = true
                opportunityIconImageView.image = UIImage(named: "iconcooperation")
                opportunityTitleLable.text = dataDict.objectForKey("order_title") as? String
            case OpportunityType.Biz:
                opportunityTagsList.hidden = false
                userPubulishedLable.hidden = false
                  opportunityIconImageView.sd_setImageWithURL(NSURL(string:dataDict.objectForKey("lawyer_photoUrl") as! String)!, placeholderImage: headImage)
                opportunityTitleLable.text = dataDict.objectForKey("lawyer_name") as? String



            }
        }

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
