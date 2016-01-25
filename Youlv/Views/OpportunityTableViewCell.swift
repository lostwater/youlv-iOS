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
    
    @IBOutlet weak var opportunityTitleLable: UILabel!
    @IBOutlet weak var userPubulishedLable: UILabel?
    @IBOutlet weak var opportunityIconImageView: UIImageView?
    @IBOutlet weak var opportunityValidUntilLable: UILabel!
    @IBOutlet weak var opportunityLocalButton: UIButton!
    @IBOutlet weak var opportunityText:UILabel!
    @IBOutlet weak var opportunityTagsList: DWTagList?
    @IBOutlet weak var opportunityLikedButton: UIButton!
    @IBOutlet var userCreditRate: RSTapRateView!
    @IBOutlet weak var userIconImageView: UIImageView?
    
    @IBOutlet weak var tagHeight: NSLayoutConstraint?
    override func awakeFromNib() {
        super.awakeFromNib()

        // Initialization code
    }
    
    func configure(dataDict : NSDictionary)
    {
        
        
        let type = dataDict.objectForKey("type") as! Int
        let userDict = dataDict.objectForKey("user") as! NSDictionary
        
        let tagList = dataDict.objectForKey("tag") as! NSArray
        let tagnames = tagList.mutableArrayValueForKey("name")
        opportunityTagsList?.setTags(tagnames as [AnyObject])

        opportunityTagsList?.display()
        tagHeight?.constant = opportunityTagsList?.fittedSize().height ?? 0
        //let h = opportunityTagsList?.fittedSize().height ?? 0
        //tagHeight?.constant =
        setNeedsUpdateConstraints()
        setNeedsLayout()
        updateConstraintsIfNeeded()
        layoutIfNeeded()
        
    
        
        opportunityText.text = dataDict.objectForKey("text") as? String
        
        //opportunityLocalButton.setTitle(dataDict.objectForKey("order_cityName") as? String, forState: UIControlState.Normal)
        opportunityValidUntilLable.text = "截止日期" + defaultDateFormatter.stringFromDate(NSDate(fromString: dataDict.objectForKey("deadline") as! String))
        opportunityLikedButton.setImage(UIImage(named:"buttonheartoutline"), forState: UIControlState.Normal)
        opportunityLikedButton.setImage(UIImage(named:"buttonheart"), forState: UIControlState.Selected)
        opportunityLikedButton.setTitle( String(dataDict.objectForKey("interest_num") as! Int), forState: UIControlState.Normal)
        opportunityLikedButton.setTitle( String(dataDict.objectForKey("interest_num") as! Int), forState: UIControlState.Selected)
        
                if type == 1
        {
            opportunityIconImageView?.image = UIImage(named: "iconcase")
        }
        if type == 2
        {
            opportunityIconImageView?.image = UIImage(named: "iconcooperation")
        }
        userIconImageView?.sd_setImageWithURL(NSURL(string: userDict.objectForKey("avatar") as! String), placeholderImage: headImage)

        userCreditRate.rating = 5
        
        
        opportunityLikedButton.selected = dataDict.objectForKey("interest_or_not") as! Bool
        
        if (opportunityTitleLable.text!).characters.count > 11
        {
            opportunityTitleLable.text = opportunityTitleLable.text!.substringToIndex(opportunityTitleLable.text!.startIndex.advancedBy(10)) + "..."
        }
        
        
        
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
