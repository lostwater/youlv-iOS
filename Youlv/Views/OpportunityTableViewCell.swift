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
    //@IBOutlet weak var itemUserCreditRate: UIView!
    @IBOutlet weak var opportunityLikedButton: UIButton!
    @IBOutlet var userCreditRate: RSTapRateView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    
    func resetTextViewSize() -> CGFloat
    {
        let size = CGSizeMake(self.frame.size.width - 20, CGFloat.max)
        
        let attributes : Dictionary = [NSFontAttributeName:UIFont(name: "HelveticaNeue", size: 14)]
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
