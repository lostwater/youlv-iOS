//
//  OpportunityReplyTableViewCell.swift
//  Youlv
//
//  Created by Lost on 29/06/2015.
//  Copyright (c) 2015 com.RamyTech. All rights reserved.
//

import UIKit

class OpportunityReplyTableViewCell: UITableViewCell {

    @IBOutlet weak var userImage: AvatarImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var replyTime: UILabel!
    
    @IBOutlet weak var replyText: UITextView!
    @IBOutlet weak var opportunityTitle: UILabel!
    @IBOutlet weak var opportunityText: UITextView!
    
    func displayData(dataDict : NSDictionary)
    {
        userImage.userId = dataDict.objectForKey("lawyerId") as? Int ?? 0
        userImage.sd_setImageWithURL(NSURL(string:dataDict.objectForKey("photoUrl") as! String)!, placeholderImage: headImage)
        userName.text = dataDict.objectForKey("lawyerName") as? String
        replyText.text = dataDict.objectForKey("replyContent") as? String
        opportunityTitle.text = dataDict.objectForKey("orderTitle") as? String
        opportunityText.text = dataDict.objectForKey("orderContent") as? String
        resizeTextView(replyText)
        resizeTextView(opportunityText)

    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
