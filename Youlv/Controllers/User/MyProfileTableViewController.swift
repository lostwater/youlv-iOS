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
    
    @IBOutlet var userImageView: UIImageView!
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

    var dataDict : NSDictionary?
    
    
    func getMyProfile()
    {
        DataClient().getMyProfile({ (dict, error) -> () in
            self.getMyProfileCompleted(dict,error: error)
        })
    }
    
    
    func getMyProfileCompleted(dict:NSDictionary?,error:NSError?)
    {
        
        self.dataDict = dict!.objectForKey("data") as? NSDictionary
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.displayData()
        })
        
    }
    
    func updateProfile()
    {
        
    }
    
    func displayData()
    {
        userImageView.sd_setImageWithURL(NSURL(string: dataDict!.objectForKey("lawyer_photoUrl") as! String),placeholderImage:headImage)
        userName.text = dataDict!.objectForKey("lawyer_name") as? String
        userIntro.text = dataDict!.objectForKey("lawyer_introduction") as? String
        userIntroTextView.text = dataDict!.objectForKey("lawyer_introduction") as? String
        orgName.text = dataDict!.objectForKey("lawyer_lawOffice") as? String
        location.text = dataDict!.objectForKey("lawyer_cityName") as? String
        
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
        userName.enabled = false
        userIntro.enabled = false
        orgName.enabled = false
        location.enabled = false
        getMyProfile()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
