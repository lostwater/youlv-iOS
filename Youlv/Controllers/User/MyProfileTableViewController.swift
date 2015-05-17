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
        DataClient().getMyProfile({ (data, error) -> () in
            self.getMyProfileCompleted(data,error: error)
        })
    }
    
    func getMyProfileCompleted(data:NSData?,error:NSError?)
    {
        if error != nil
        {
            return
        }
        let errorPointer = NSErrorPointer()
        let dict = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves, error: errorPointer) as! NSDictionary
        
        self.dataDict = dict.objectForKey("data") as? NSDictionary
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
