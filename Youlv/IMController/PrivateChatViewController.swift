//
//  PrivateChatViewController.swift
//  Youlv
//
//  Created by Lost on 22/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//



class PrivateChatViewController: ChatViewController {
    var userId = ""
    var userName = ""
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
        conversation = EaseMob.sharedInstance().chatManager.conversationForChatter!(userId,isGroup: false)
    }
    
    func emSendText(message : String)
    {
       let emmessage = ChatSendHelper.sendTextMessageWithString(message, toUsername: userName, isChatGroup: false, requireEncryption: false, ext: nil)

    }
    
    func emSendImage(image : UIImage)
    {
        let emmessage = ChatSendHelper.sendImageMessageWithImage(image, toUsername: userName, isChatGroup: false, requireEncryption: false, ext: nil)
    }
    
    func emSendVoice(voice : EMChatVoice)
    {
         let emmessage = ChatSendHelper.sendVoice(voice, toUsername: userName, isChatGroup: false, requireEncryption: false, ext: nil)

    }

    

}
