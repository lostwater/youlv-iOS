//
//  MyHomeTableViewController.swift
//  Youlv
//
//  Created by Lost on 19/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//



class MyHomeTableViewController: UITableViewController {

    @IBOutlet var userImageView: AvatarImageView!
    @IBOutlet weak var userName: UILabel!

    @IBOutlet weak var location: UILabel!
    
    @IBOutlet weak var fellowsCount: UIButton!
    @IBOutlet weak var fansCount: UIButton!

    
    func displayData()
    {
        userImageView.sd_setImageWithURL(NSURL(string: myUserInfo!.objectForKey("avatar") as! String), placeholderImage: headImage)
        userName.text = myUserInfo!.objectForKey("name") as? String
        location.text = myUserInfo!.objectForKey("location") as? String
        let office = myUserInfo!.objectForKey("agency") as? String
        if office ?? "" != ""
        {
            location.text = location.text! + ", " + office!
        }

        var fellowstitle = String(myUserInfo!.objectForKey("follow_num")as! Int)
        fellowstitle = "关注 " + fellowstitle
        fellowsCount.setTitle(fellowstitle, forState: UIControlState.Normal)
        var fanstitle = String(myUserInfo!.objectForKey("followed_num")as! Int)
        fanstitle = "粉丝 " + fanstitle
        fansCount.setTitle(fanstitle, forState: UIControlState.Normal)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userImageView.isPushEnabled = false
        //displayData()

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        displayData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
