//
//  GroupDetailTableViewController.swift
//  Youlv
//
//  Created by Lost on 04/02/2016.
//  Copyright © 2016 com.RamyTech. All rights reserved.
//



class GroupDetailTableViewController: UITableViewController {

    @IBOutlet weak var avatarView: AvatarImageView?
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var membersView: ImageListView!
    @IBOutlet weak var intro: UILabel!
    @IBOutlet weak var membersCount: UILabel!
    
    @IBOutlet weak var owner: UILabel!
    @IBOutlet weak var ownerAvatarView: AvatarImageView!

    
    var dict : NSDictionary?
    
    
    @IBAction func joinGroupClicked(sender: AnyObject) {
        httpClient.joinGroup(dict?.objectForKey("group_id") as! Int) { (dict, error) -> () in
            self.goToGroupChat()
        }
    }
    
    
    @IBAction func groupChatClicked(sender: AnyObject) {
        goToGroupChat()
    }
    
    func goToGroupChat()
    {
        let huanxinId = dict!.objectForKey("groupid") as! NSNumber
        let chatVC = GroupChatViewController(conversationChatter: "\(huanxinId)", conversationType: EMConversationType.eConversationTypeGroupChat)
        chatVC.title = dict?.objectForKey("groupname") as? String
        chatVC.groupDict = dict
        navigationController?.pushViewController(chatVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if dict != nil
        {
            configure(dict!)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //if dict != nil
        //{
            //configure(dict!)
        //}
    }
    
    
    
    func configure(dict : NSDictionary)
    {
        //name.text = dict.objectForKey("groupid") as? String
        name.text = dict.objectForKey("groupname") as? String
        intro.text = dict.objectForKey("desc") as? String
        membersCount.text = String(dict.objectForKey("total_num") as! Int) + "人"
        avatarView?.sd_setImageWithURL(NSURL(string:dict.objectForKey("group_avatar") as! String))
        let userArray = NSMutableArray()
        let ownerDict = dict.objectForKey("owner") as? NSDictionary
        owner.text = ownerDict?.objectForKey("name") as? String
        ownerAvatarView.sd_setImageWithURL(NSURL(string:ownerDict!.objectForKey("avatar") as! String))
        ownerAvatarView.userDict = ownerDict
        ownerAvatarView.userId = ownerDict?.objectForKey("uid") as! Int
        userArray.addObject(ownerDict!)
        let members = dict.objectForKey("members") as? NSArray ?? NSArray()
        userArray.addObjectsFromArray(members as [AnyObject])
        let userAvatars = userArray.mutableArrayValueForKey("avatar")
        membersView.setImages(userAvatars)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.destinationViewController.isKindOfClass(GroupMembersTableViewController)
        {
            let vc = segue.destinationViewController as! GroupMembersTableViewController
            //let selectedIndex = tableView.indexPathForSelectedRow?.item
            vc.membersArray = dict!.objectForKey("members") as? NSMutableArray ?? NSMutableArray()
            vc.ownerDict = dict!.objectForKey("owner") as! NSDictionary

        }
        
    }
    
    
    
    
}
