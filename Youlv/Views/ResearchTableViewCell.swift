//
//  ResearchTableViewCell.swift
//  Youlv
//
//  Created by Lost on 16/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class ResearchTableViewCell: UITableViewCell {


    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var publishTime: UILabel!
    @IBOutlet var isLiveImageView: UIImageView!
    @IBOutlet var researchTextView: UITextView!
    
    func displayData(dataDict : NSDictionary)
    {
        userName.text = dataDict.objectForKey("vote_title") as? String
        publishTime.text = dataDict.objectForKey("vote_createDate") as? String
        
        var voteContent = dataDict.objectForKey("vote_content") as! String
        let voteOptions = dataDict.objectForKey("vote_options") as! NSArray
        for o in voteOptions
        {
            voteContent = voteContent + "\n\n" + ((o as! NSDictionary).objectForKey("option_content") as! String)
        }
        

        researchTextView.text = voteContent
        researchTextView.font = UIFont.systemFontOfSize(15)
        researchTextView.textColor = UIColor.darkGrayColor()
        
        if dataDict.objectForKey("vote_isEnd") as! Bool
        {
            isLiveImageView.image = UIImage(named:"iconover")
        }
        else
        {
            isLiveImageView.image = UIImage(named:"icononlive")
        }
        
        resizeTextView(researchTextView)

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
