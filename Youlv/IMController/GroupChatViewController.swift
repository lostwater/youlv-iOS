//
//  PrivateChatViewController.swift
//  Youlv
//
//  Created by Lost on 22/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//



class GroupChatViewController: ChatViewController {
    var groupId = ""
    var groupName = ""

    
    var conversation : EMConversation?
    override func viewDidLoad() {
        self.navigationItem.title = self.groupName
        super.viewDidLoad()
        setupChatVCWithChatter(groupName, conversationType: EMConversationType.eConversationTypeChat)
        //EaseMob.sharedInstance().chatManager.conversationForChatter!(groupId, conversationType: EMConversationType.eConversationTypeGroupChat)
    }
    
    func emSendText(message : String)
    {
        let emmessage = ChatSendHelper.sendTextMessageWithString(message, toUsername: groupId, isChatGroup: true, requireEncryption: false, ext: nil)
        
    }
    
    func emSendImage(image : UIImage)
    {
        let emmessage = ChatSendHelper.sendImageMessageWithImage(image, toUsername: groupId, isChatGroup: true, requireEncryption: false, ext: nil)
    }
    
    func emSendVoice(voice : EMChatVoice)
    {
        let emmessage = ChatSendHelper.sendVoice(voice, toUsername: groupId, isChatGroup: false, requireEncryption: true, ext: nil)
        
    }
    
    
    
}