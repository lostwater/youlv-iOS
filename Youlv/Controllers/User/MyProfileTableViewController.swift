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
    @IBOutlet var orgName: UITextField!
    @IBOutlet var location: UITextField!
    

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
    
    func displayData()
    {
        userImageView.sd_setImageWithURL(NSURL(string: dataDict!.objectForKey("lawyer_photoUrl") as! String))
        userName.text = dataDict!.objectForKey("lawyer_name") as? String
        userIntroTextView.text = dataDict!.objectForKey("lawyer_introduction") as? String
        orgName.text = dataDict!.objectForKey("lawyer_lawOffice") as? String
        location.text = dataDict!.objectForKey("lawyer_cityName") as? String
        
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        getMyProfile()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
