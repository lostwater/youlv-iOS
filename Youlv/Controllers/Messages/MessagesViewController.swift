//
//  MessagesViewController.swift
//  Youlv
//
//  Created by Lost on 13/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class MessagesViewController: EaseConversationListViewController, EaseConversationListViewControllerDataSource, EaseConversationListViewControllerDelegate {

    @IBAction func GroupCreated(segue: UIStoryboardSegue)
    {
        
    }
    @IBOutlet weak var newChatMenuView: UIView!
    @IBOutlet var UITapGR: UITapGestureRecognizer!
    @IBOutlet weak var newChatMenuButton: UIBarButtonItem!
    @IBAction func newChatMenuButtonClicked(sender: AnyObject) {
        newChatMenuView.layer.zPosition = 254
        newChatMenuView.hidden = false;
        //self.tableView.layer.zPosition = -1
        tableView.addSubview(newChatMenuView)
        view.layoutSubviews()
        view.layoutIfNeeded()
        //self.addChildViewController(ChatListViewController())
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        EaseMob.sharedInstance().chatManager.loadAllConversationsFromDatabaseWithAppend2Chat!(false)
        
        self.dataSource = self
        self.delegate = self
        //self.tableView.delegate = self
        EaseBaseMessageCell.appearance().sendBubbleBackgroundImage = UIImage(named:"bgtextblue")
        EaseBaseMessageCell.appearance().recvBubbleBackgroundImage = UIImage(named:"bgtextwhite")
        EaseBaseMessageCell.appearance().avatarSize = 40
        EaseBaseMessageCell.appearance().avatarCornerRadius = 20
        //EaseImageView.appearance().imageView.layer.cornerRadius = 20
        //EaseImageView.appearance().imageView.layer.masksToBounds = true        // Do any additional setup after loading the view.
        
        
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        super.tableView(tableView, didSelectRowAtIndexPath: indexPath)
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.showRefreshHeader = true
        
        self.tableViewDidTriggerHeaderRefresh()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func viewTapped(sender: AnyObject) {
        newChatMenuView.hidden = true;
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
         newChatMenuView.hidden = true;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAtIndexPath: indexPath) as! EaseConversationCell
        cell.avatarView.imageView.layer.masksToBounds = true
        cell.avatarView.imageView.layer.cornerRadius = 20
        
        //let tapRec =
        let cellSelected = UITapGestureRecognizer(target: self, action:Selector("cellSelected:"))
        cell.addGestureRecognizer(cellSelected)
        
        return cell
    }
    
    func cellSelected(sender : UITapGestureRecognizer)
    {
        let cell = sender.view as! EaseConversationCell
        cell.setSelected(true, animated: true)
        let conversationModel = cell.model
        pushToConversation(conversationModel)
    }
    
    func pushToConversation(conversationModel: IConversationModel)
    {
        if conversationModel.conversation.conversationType == EMConversationType.eConversationTypeChat
        {
            var userDict = getUser( conversationModel.conversation.chatter)
            if userDict == nil
            {
                httpClient.getUserInfoByEasemob(conversationModel.conversation.chatter, completion: { (dict, error) -> () in
                    userDict = dict
                    if userDict != nil
                    {
                        userList?.addObject(userDict!)
                        self.tableView.reloadData()
                    }
                })
            }
            
            if userDict != nil
            {
                let chatVC = PrivateChatViewController(conversationChatter: userDict!.objectForKey("huanxin_name") as! String, conversationType: EMConversationType.eConversationTypeChat)
                chatVC.hidesBottomBarWhenPushed = true
                chatVC.title = userDict?.objectForKey("name") as? String
                chatVC.userDict = userDict
                self.navigationController?.pushViewController(chatVC, animated: true)
            }
            else
            {
                let chatVC = PrivateChatViewController(conversationChatter: conversationModel.conversation.chatter, conversationType: EMConversationType.eConversationTypeChat)
                self.navigationController?.pushViewController(chatVC, animated: true)
            }
        }
        else if conversationModel.conversation.conversationType == EMConversationType.eConversationTypeGroupChat
        {
            let groupDict  = getGroup(conversationModel.conversation.chatter)
            if groupDict != nil
            {
                let huanxinId = groupDict!.objectForKey("groupid") as! NSNumber
                let chatVC = GroupChatViewController(conversationChatter: "\(huanxinId)", conversationType: EMConversationType.eConversationTypeGroupChat)
                chatVC.hidesBottomBarWhenPushed = true
                chatVC.title = groupDict?.objectForKey("groupname") as? String
                chatVC.groupDict = groupDict
                self.navigationController?.pushViewController(chatVC, animated: true)
            }
            else
            {
                let chatVC = GroupChatViewController(conversationChatter: conversationModel.conversation.chatter, conversationType: EMConversationType.eConversationTypeGroupChat)
                self.navigationController?.pushViewController(chatVC, animated: true)
            }
            
        }

    }
    
    
    func conversationListViewController(conversationListViewController: EaseConversationListViewController!, didSelectConversationModel conversationModel: IConversationModel!)
    {
        
        pushToConversation(conversationModel)
    }


    func conversationListViewController(conversationListViewController: EaseConversationListViewController!, modelForConversation conversation: EMConversation!) -> IConversationModel! {
        let model = EaseConversationModel(conversation: conversation)
        if model.conversation.conversationType == EMConversationType.eConversationTypeChat
        {
            var userDict = getUser(conversation.chatter)
            if userDict == nil
            {
                httpClient.getUserInfoByEasemob(model.conversation.chatter, completion: { (dict, error) -> () in
                    userDict = dict
                    if userDict != nil
                    {
                        userList?.addObject(userDict!)
                        self.tableView.reloadData()
                    }
                })
            }
            if userDict != nil
            {
                model.title = userDict?.objectForKey("name") as? String
                model.avatarURLPath = userDict?.objectForKey("avatar") as? String
            }

        }
        else if model.conversation.conversationType == EMConversationType.eConversationTypeGroupChat
        {
            let groupDict = getGroup(conversation.chatter)
            if groupDict != nil
            {
                //model.title = groupDict?.objectForKey("groupid") as? String
                model.title = groupDict?.objectForKey("groupname") as? String
                model.avatarURLPath = groupDict?.objectForKey("group_avatar") as? String
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
            let huanxinId = g.objectForKey("groupid") as! NSNumber
            if "\(huanxinId)" == easeNmae
            //if String(stringInterpolationSegment: ((g as! NSDictionary).objectForKey("groupid") as! Int64).description) == easeNmae
            {
                return g as? NSDictionary
            }
        }
        return nil
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
