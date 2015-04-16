//
//  newChatMenuView.swift
//  Youlv
//
//  Created by Lost on 16/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class newChatMenuView: UIView {

    @IBOutlet var menuView: UIView!
    
    override func awakeFromNib() {
        NSBundle.mainBundle().loadNibNamed("newChatMenuView", owner: self, options: nil)
        self.addSubview(menuView)
    }
    /*
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
