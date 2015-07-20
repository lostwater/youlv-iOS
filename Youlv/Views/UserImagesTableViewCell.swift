//
//  UsersTableViewCell.swift
//  Youlv
//
//  Created by Lost on 09/07/2015.
//  Copyright (c) 2015 com.RamyTech. All rights reserved.
//

import UIKit

class UserImagesTableViewCell: UITableViewCell {

    @IBOutlet weak var imagesView: ImageListView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func displayImages(imageUrls : NSArray)
    {
        imagesView.setImages(imageUrls)
    }

}
