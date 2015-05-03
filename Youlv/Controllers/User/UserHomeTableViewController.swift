//
//  UserHomeTableViewController.swift
//  Youlv
//
//  Created by Lost on 03/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class UserHomeTableViewController: UITableViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userIntroTextView: UITextView!
    @IBOutlet weak var buttonFellows: UIButton!
    @IBOutlet weak var buttonFans: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 0
    }
    
    override func tableView(tableView: UITableView, didEndDisplayingCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if(self.tableView.contentOffset.y > 0)
        {
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.shortHeader()
            })
        }
        else
        {
            UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.fullHeader()
            })
        }
        
    }
    
    func fullHeader()
    {
        headerView.frame = CGRectMake(headerView.frame.origin.x,
            headerView.frame.origin.y,
            headerView.frame.size.width,
            385
        )
        
        buttonFellows.hidden = false
        buttonFans.hidden = false
        userIntroTextView.frame.size = CGSize(width: userIntroTextView.frame.size.width, height: 0)
        userIntroTextView.hidden = false
        userImageView.frame.size = CGSize(width: 80, height: 80)
    }
    
    func shortHeader()
    {
        headerView.frame = CGRectMake(headerView.frame.origin.x,
            headerView.frame.origin.y,
            headerView.frame.size.width,
            180
        )
        buttonFellows.hidden = true
        buttonFans.hidden = true
        userIntroTextView.frame.size = CGSize(width: userIntroTextView.frame.size.width, height: 95)
        userIntroTextView.hidden = true
        userImageView.frame.size = CGSize(width: 50, height: 50)

    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
