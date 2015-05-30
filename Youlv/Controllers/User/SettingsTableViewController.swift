//
//  SettingsTableViewController.swift
//  Youlv
//
//  Created by Lost on 22/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    
    @IBOutlet weak var footView: UIView!
    @IBAction func signOutButtonClicked(sender: AnyObject) {
        accountKeyWrapper.resetKeychainItem()
        passwordKeyWrapper.resetKeychainItem()
        
        let sb = UIStoryboard(name: "Login", bundle: nil)
        let vc = sb.instantiateInitialViewController() as! UIViewController
        presentViewController(vc, animated: true, completion: nil )
        
    }
    
    var accountKeyWrapper = KeychainItemWrapper(identifier: "account", accessGroup: serviceName)
    var passwordKeyWrapper = KeychainItemWrapper(identifier: "password", accessGroup: serviceName)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reDrawFoot()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func reDrawFoot()
    {
     
        tableView.tableFooterView!.frame = CGRectMake(0,tableView.contentSize.height, tableView.tableFooterView!.frame.size.width, self.view.frame.height - tableView.contentSize.height)
    }


}
