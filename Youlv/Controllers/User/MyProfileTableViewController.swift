//
//  UserProfileTableViewController.swift
//  Youlv
//
//  Created by Lost on 21/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class MyProfileTableViewController: UITableViewController {

    @IBOutlet weak var tableViewCellIntro: UITableViewCell!
    @IBOutlet weak var textViewIntro: UITextView!
    
    @IBOutlet var userImageView: AvatarImageView!
    @IBOutlet var userName: UITextField!
    @IBOutlet var userIntroTextView: UITextView!
    @IBOutlet weak var userIntro: UITextField!
    @IBOutlet var orgName: UITextField!
    @IBOutlet var location: UITextField!
    
    @IBOutlet weak var editButton: UIBarButtonItem!
    @IBAction func editClicked(sender: AnyObject) {
        if editEabled
        {
            updateProfile()
        }
        switchEditMode()
        
    }
    
    var editEabled = false

    
    func updateProfile()
    {
        
    }
    
    func displayData()
    {
        userImageView.sd_setImageWithURL(NSURL(string: myUserInfo!.objectForKey("avatar") as! String),placeholderImage:headImage)
        userName.text = myUserInfo!.objectForKey("name") as? String
        userIntro.text = myUserInfo!.objectForKey("about") as? String
        //userIntroTextView.text = dataDict!.objectForKey("lawyer_introduction") as? String
        orgName.text = myUserInfo!.objectForKey("agency") as? String
        location.text = myUserInfo!.objectForKey("location") as? String
        
    }
    
    func switchEditMode()
    {
        editEabled = !editEabled
        if editEabled
        {
            editButton.title = "完成"
            
           
            userName.enabled = true
            userIntro.enabled = true
            orgName.enabled = true
            location.enabled = true
        
            userName.becomeFirstResponder()

        }
        else
        {
            
            editButton.title = "编辑"
            userName.enabled = false
            userIntro.enabled = false
            orgName.enabled = false
            location.enabled = false
           
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        userImageView.isPushEnabled = false
        userName.enabled = false
        userIntro.enabled = false
        orgName.enabled = false
        location.enabled = false
        displayData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
