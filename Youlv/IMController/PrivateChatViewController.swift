//
//  PrivateChatViewController.swift
//  Youlv
//
//  Created by Lost on 22/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit


class PrivateChatViewController: UUChatViewController{
    var userPhone = ""

    override func headImageDidClick(cell: UUMessageCell!, userId: String!)
    {
            let vc = UIStoryboard(name: "Messages", bundle: nil).instantiateViewControllerWithIdentifier("userVC") as! UserViewController
            vc.userId = 1
            self.navigationController?.pushViewController(vc, animated:true)
    }
    
    var conversation : EMConversation?
    override func viewDidLoad() {
        self.navigationItem.title = self.chattitle
        super.viewDidLoad()
        EaseMob.sharedInstance().chatManager.conversationForChatter!(userPhone, conversationType: EMConversationType.eConversationTypeChat)
    
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
    
    override func inputView(inputView: UUInputFunctionView!, sendMessage message: String!) {
        super.inputView(inputView,sendMessage:message)
        emSendText(	message)

    }
    
    override func inputView(inputView: UUInputFunctionView!, sendPicture image: UIImage!) {
       super.inputView(inputView,sendPicture:image)
        emSendImage(image)
    }
    
    override func inputView(inputView: UUInputFunctionView!, sendVoice voice: NSData!, time second: Int) {
        super.inputView(inputView,sendVoice:voice,time:second)
    }

}
