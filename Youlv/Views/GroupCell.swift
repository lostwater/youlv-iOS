//
//  GroupCell.swift
//  Youlv
//
//  Created by Lost on 03/02/2016.
//  Copyright © 2016 com.RamyTech. All rights reserved.
//


class GroupCell: UITableViewCell {

    @IBOutlet weak var avatar: AvatarImageView?
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var intro: UILabel!
    @IBOutlet weak var buttonJoin: UIButton?
    
    @IBAction func buttonJoinClicked(sender: AnyObject) {
        httpClient.joinGroup(dict?.objectForKey("group_id") as! Int) { (dict, error) -> () in
            self.goToGroupChat()
        }
    }
    
    var dict : NSDictionary?
    
    func goToGroupChat()
    {
        let huanxinId = dict!.objectForKey("groupid") as! NSNumber
        let chatVC = GroupChatViewController(conversationChatter: "\(huanxinId)", conversationType: EMConversationType.eConversationTypeGroupChat)
        chatVC.title = dict?.objectForKey("groupname") as? String
        chatVC.groupDict = dict
        viewController?.navigationController?.pushViewController(chatVC, animated: true)
    }
    
    
    //let groupid
    
    func configure(dict:NSDictionary)
    {
        name.text = dict.objectForKey("groupname") as? String
        avatar?.sd_setImageWithURL(NSURL(string: dict.objectForKey("group_avatar") as! String)!, placeholderImage: headImage)
        avatar?.isPushEnabled = false
        intro.text = "\(String(dict.objectForKey("total_num") as! Int))人，\(String(dict.objectForKey("friend_num") as! Int))个好友在群内"
    }
    
    
    
    
}
