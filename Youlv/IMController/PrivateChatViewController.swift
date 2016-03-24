//
//  PrivateChatViewController.swift
//  Youlv
//
//  Created by Lost on 22/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit


class PrivateChatViewController: EaseMessageViewController,EaseMessageViewControllerDataSource{
    

    var userDict : NSDictionary?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        hidesBottomBarWhenPushed = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //super.messsagesSource.addObjectsFromArray(conversation.loadAllMessages())
        super.tableViewDidTriggerHeaderRefresh()
        self.dataSource = self
    }
    
    func messageViewController(viewController: EaseMessageViewController!, modelForMessage message: EMMessage!) -> IMessageModel! {
        let model = EaseMessageModel(message: message)
        if message.from == myUserInfo?.objectForKey("huanxin_name") as? String
        {
            model.avatarImage = headImage
            model.avatarURLPath = myUserInfo?.objectForKey("avatar") as? String
            model.nickname  = myUserInfo?.objectForKey("name") as? String
        }
        else
        {
            userDict = getUser(conversation.chatter)
            if userDict != nil
            {
                model.nickname = userDict?.objectForKey("name") as? String
                model.avatarURLPath = userDict?.objectForKey("avatar") as? String
            }
        }
        return model
    }
    
    func getUser(easeNmae : String) -> NSDictionary?
    {
        for u in userList!
        {
            if (u as! NSDictionary).objectForKey("huanxin_name") as! String == easeNmae
            {
                return u as? NSDictionary
            }
        }
        return nil
    }
    
    func getGroup(easeNmae : String) -> NSDictionary?
    {
        for g in groupList!
        {
            if String((g as! NSDictionary).objectForKey("groupid") as! Int) == easeNmae
            {
                return g as? NSDictionary
            }
        }
        return nil
    }

}
