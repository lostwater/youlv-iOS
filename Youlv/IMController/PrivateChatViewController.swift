//
//  PrivateChatViewController.swift
//  Youlv
//
//  Created by Lost on 22/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit


class PrivateChatViewController: ChatViewController{
    var userPhone = ""
    var username = ""

    var conversation : EMConversation?
    override func viewDidLoad() {
        self.navigationItem.title = self.username
        super.viewDidLoad()
        setupChatVCWithChatter( userPhone, conversationType: EMConversationType.eConversationTypeChat)
        //EaseMob.sharedInstance().chatManager.conversationForChatter!(userPhone, conversationType: EMConversationType.eConversationTypeChat)
    
    }
    
    func emSendText(message : String)
    {
       let emmessage = ChatSendHelper.sendTextMessageWithString(message, toUsername: userPhone, isChatGroup: false, requireEncryption: false, ext: nil)

    }
    
    func emSendImage(image : UIImage)
    {
        let emmessage = ChatSendHelper.sendImageMessageWithImage(image, toUsername: userPhone, isChatGroup: false, requireEncryption: false, ext: nil)
    }
    
    func emSendVoice(voice : EMChatVoice)
    {
         let emmessage = ChatSendHelper.sendVoice(voice, toUsername: userPhone, isChatGroup: false, requireEncryption: false, ext: nil)

    }


}
