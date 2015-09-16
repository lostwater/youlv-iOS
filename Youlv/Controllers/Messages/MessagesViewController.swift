//
//  MessagesViewController.swift
//  Youlv
//
//  Created by Lost on 13/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {


    @IBOutlet weak var newChatMenuView: UIView!
    @IBOutlet var UITapGR: UITapGestureRecognizer!
    @IBOutlet weak var newChatMenuButton: UIBarButtonItem!
    @IBAction func newChatMenuButtonClicked(sender: AnyObject) {
        newChatMenuView.hidden = false;
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.item == 1
        {
            return tableView.dequeueReusableCellWithIdentifier("MessageCell2", forIndexPath: indexPath) as! UITableViewCell
        }
        if indexPath.item == 2
        {
            return tableView.dequeueReusableCellWithIdentifier("MessageCell3", forIndexPath: indexPath) as! UITableViewCell
        }
        if indexPath.item == 3
        {
            return tableView.dequeueReusableCellWithIdentifier("MessageCell4", forIndexPath: indexPath) as! UITableViewCell
        }
        return tableView.dequeueReusableCellWithIdentifier("MessageCell1", forIndexPath: indexPath) as! UITableViewCell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 64
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
