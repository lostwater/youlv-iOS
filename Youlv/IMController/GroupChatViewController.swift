//
//  PrivateChatViewController.swift
//  Youlv
//
//  Created by Lost on 22/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//


import UIKit


class GroupChatViewController: EaseMessageViewController,EaseMessageViewControllerDataSource{
    
    var groupDict : NSDictionary?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        hidesBottomBarWhenPushed = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hidesBottomBarWhenPushed = true
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
            model.avatarImage = headImage
            model.avatarURLPath = groupDict?.objectForKey("group_avatar") as? String
            model.nickname  = groupDict?.objectForKey("groupname") as? String
        }
        return model
    }
    
}
