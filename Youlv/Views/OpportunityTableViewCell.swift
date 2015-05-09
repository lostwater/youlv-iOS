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
    var dataDict : NSDictionary?
    
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
    
    func setData(_dataDict : NSDictionary)
    {
        self.dataDict = _dataDict
        let type = dataDict!.objectForKey("order_type") as! Int
        setOpportunityType(OpportunityType(rawValue: type)!)
        opportunityTitleLable.text = dataDict!.objectForKey("order_title") as? String
        opportunityTextView.text = dataDict!.objectForKey("order_content") as! String
        opportunityLocalButton.setTitle(dataDict!.objectForKey("order_cityName") as? String, forState: UIControlState.Normal)
        opportunityValidUntilLable.text = dataDict!.objectForKey("order_deadDate") as? String
        opportunityLikedButton.titleLabel?.text = String(dataDict!.objectForKey("order_interestCount") as! Int)
        opportunityTextView.frame.size = CGSize(width:opportunityTextView.frame.size.width, height:opportunityTextView.contentSize.height)
        opportunityTagsList.setTags(NSArray(object: dataDict!.objectForKey("order_keyWords")!) as [AnyObject])

        
     
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
    
    func setOpportunityType(opportunityType : OpportunityType)
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
                
            case OpportunityType.Outsourcing:
                opportunityTagsList.hidden = false
                userPubulishedLable.hidden = true
                opportunityIconImageView.image = UIImage(named: "iconcooperation")
            case OpportunityType.Biz:
                opportunityTagsList.hidden = false
                userPubulishedLable.hidden = false


            }
        }

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
