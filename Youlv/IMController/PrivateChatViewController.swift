//
//  PrivateChatViewController.swift
//  Youlv
//
//  Created by Lost on 22/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit


class PrivateChatViewController: EaseMessageViewController,EaseMessageViewControllerDataSource{
    
    var myUserDict : NSDictionary?
    var userDict : NSDictionary?
    
    func messageViewController(viewController: EaseMessageViewController!, modelForMessage message: EMMessage!) -> IMessageModel! {
        let model = EaseMessageModel(message: message)
        if message.from == myUserDict?.objectForKey("name") as! String
        {
            model.avatarImage = headImage
            model.avatarURLPath = myUserDict?.objectForKey("avatar") as! String
            model.nickname  = myUserDict?.objectForKey("name") as! String
        }
        else
        {
            model.avatarImage = headImage
            model.avatarURLPath = userDict?.objectForKey("avatar") as! String
            model.nickname  = userDict?.objectForKey("name") as! String
        }
        return model
    }

}
