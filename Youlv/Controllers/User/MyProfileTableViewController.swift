//
//  UserProfileTableViewController.swift
//  Youlv
//
//  Created by Lost on 21/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class MyProfileTableViewController: UITableViewController,FSMediaPickerDelegate  {

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
        httpClient.updateMyProfile(userImageView.image!, name: userName.text ?? "",  agency: orgName.text ?? "", location: location.text ?? "") { (dict, error) -> () in
           //myUserInfo?.d
            //myUserInfo?.
            myUserInfo?.setValue(dict?.valueForKey("avatar") as! String, forKey: "avatar")
             myUserInfo?.setValue(self.userName.text, forKey: "name")
             myUserInfo?.setValue(self.orgName.text, forKey: "agency")
             myUserInfo?.setValue(self.location.text, forKey: "location")
             //myUserInfo?.setValue(userImageView.image!, forKey: "avatar")
        }
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
        
        userImageView.userInteractionEnabled = true
        let singleTap = UITapGestureRecognizer(target: self, action:Selector("avatarTapped"))
        userImageView.addGestureRecognizer(singleTap)

    }
    
    func avatarTapped()
    {
        if editEabled
        {
            let mediaPicker = FSMediaPicker();
            mediaPicker.mediaType = FSMediaTypePhoto
            mediaPicker.editMode = FSEditModeCircular
            mediaPicker.delegate = self;
            mediaPicker.showFromView(self.view);
        }
    }
    
    func mediaPicker(mediaPicker: FSMediaPicker!, didFinishWithMediaInfo mediaInfo: [NSObject : AnyObject]!) {
        let m = mediaInfo as NSDictionary;
        let pic =  m.circularEditedImage;
        userImageView.image = pic
    }
    
    func mediaPicker(mediaPicker: FSMediaPicker!, willPresentImagePickerController imagePicker: UIImagePickerController!) {
        
    }
    
    func mediaPickerDidCancel(mediaPicker: FSMediaPicker!) {
        
    }




}
