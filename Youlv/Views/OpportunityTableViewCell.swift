//
//  HomeItemTableViewCell.swift
//  Youlv
//
//  Created by Lost on 03/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

enum OpportunityType
{
    case Case
    case Outsourcing
    case Biz
}

class OpportunityTableViewCell: UITableViewCell {

    var opportunityType : OpportunityType?
    
    
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
        
        switch opportunityType!
        {
            case OpportunityType.Case:
                opportunityTagsList.hidden = true
                userPubulishedLable.hidden = true
            case OpportunityType.Outsourcing:
                opportunityTagsList.hidden = false
                userPubulishedLable.hidden = true
            case OpportunityType.Biz:
                opportunityTagsList.hidden = false
                userPubulishedLable.hidden = false
        }
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
