//
//  ArticleTableViewCell.swift
//  Youlv
//
//  Created by Lost on 04/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var articleTime: UILabel!
    @IBOutlet var userTextView: UITextView!
    @IBOutlet var articleImageView: UIImageView!
    @IBOutlet var articleTitle: UILabel!
    @IBOutlet var articleTextView: UITextView!
    
    @IBOutlet var commentButton: UIButton!
    @IBOutlet var likedButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commentButton.setImage(UIImage(named:"buttoncommentoutline"), forState: UIControlState.Normal)
        commentButton.setImage(UIImage(named:"buttoncomment"), forState: UIControlState.Selected)
        likedButton.setImage(UIImage(named:"buttonlikeoutline"), forState: UIControlState.Normal)
        likedButton.setImage(UIImage(named:"buttonlike"), forState: UIControlState.Selected)
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
