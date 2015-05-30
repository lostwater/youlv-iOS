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
        conversation = EaseMob.sharedInstance().chatManager.conversationForChatter!(groupId,isGroup: true)
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