//
//  StartGroupChat2ViewController.swift
//  Youlv
//
//  Created by Lost on 28/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//



class StartGroupChat2ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var footview: UIView!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func finishClicked(sender: AnyObject) {
    }
    
    let optionsArray = ["开放加入","需要申请","输入密码"]
    var selected = 0
    
    var groupPic : UIImage?
    var groupName = ""
    var groupDesc = ""
    var pw = ""
    var isPublic = true
    var isApproval = false
    var invitees = NSMutableArray()
    
    var isCreated = false
    
    override func viewDidLoad() {
        //footview.hidden = true
        password.hidden = true

    }
    
    
    func createGroup()
    {
        if selected == 2
        {
            pw = password.text!
        }

    }
    
    func createGroupCompleted(dict:NSDictionary? , error:NSError?)
    {
        emCreateGroup()
        self.isCreated = true
        self.performSegueWithIdentifier("goMessagesVC", sender: self)

    }
    
    func emCreateGroup()
    {
        let groupStyleSetting = EMGroupStyleSetting()
        groupStyleSetting.groupMaxUsersCount = groupMaxUsers
        groupStyleSetting.groupStyle = EMGroupStyle.eGroupStyle_PublicOpenJoin
        //groupStyleSetting.groupStyle = eGroupStyle_PublicOpenJoin
        EaseMob.sharedInstance().chatManager.asyncCreateGroupWithSubject(groupName, description: groupDesc, invitees: invitees as [AnyObject], initialWelcomeMessage: "", styleSetting: groupStyleSetting, completion: { (group, error) -> Void in
            if error == nil
            {
                NSLog("创建成功 -- &@",group)
                    self.isCreated = true
                    self.performSegueWithIdentifier("goMessagesVC", sender: self)

            }
        }, onQueue: nil)
        

    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if identifier == "goMessagesVC" && !isCreated
        {
            createGroup()
            return false
        }
        return true
    }
    

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GroupCell", forIndexPath: indexPath) 
        
        cell.imageView?.image = UIImage(named: "checkoff")
        cell.textLabel?.text = optionsArray[indexPath.item]
        if indexPath.item == selected
        {
            cell.imageView?.image = UIImage(named: "checkon")
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        selected = indexPath.item
        if selected == 0
        {
            password.hidden = true
            password.resignFirstResponder()
            isPublic = true
            isApproval = false
            pw = ""

        }
        if selected == 1
        {
            password.hidden = true
            password.resignFirstResponder()
            isPublic = false
            isApproval = true
            pw = ""

        }
        if selected == 2
        {
            password.hidden = false
            password.becomeFirstResponder()
            isPublic = false
            isApproval = false
            //footview.hidden = false
           
        }

        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
}
