//
//  MyFriendsTableViewController.swift
//  Youlv
//
//  Created by Lost on 21/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//



class MyFriendsViewController: ViewControllerWithPagedTableView {
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView  = tableView
        //self.navigationItem.titleView = searchBar
        //tableView.
        //var textfield = searchBar.valueForKey("_searchField") as! UITextField
        //textfield.setValue(appBlueColor, forKeyPath: "_placeholderLabel.textColor")

    }
    
    
    override func httpGet() {
        httpClient.getMyFollowedUsers { (dict, error) -> () in
            self.httpGetCompleted(dict, error: error)
        }
    }

    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.destinationViewController.isKindOfClass(UserHomeTableViewController)
        {
            let vc = segue.destinationViewController as! UserHomeTableViewController
            let selectedIndex = tableView.indexPathForSelectedRow!.item
            let dict = dataArray.objectAtIndex(selectedIndex) as! NSDictionary
            vc.userId = dict.objectForKey("uid") as! Int
            vc.userDict = dict
        }
    }
    
     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
 
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ContactCell", forIndexPath: indexPath)  as! ContactTableViewCell
        let dict = dataArray.objectAtIndex(indexPath.item) as! NSDictionary
        cell.userHead.sd_setImageWithURL(NSURL(string:dict.objectForKey("avatar") as! String))
        cell.userName.text =  dict.objectForKey("name") as? String
        cell.intro?.text = dict.objectForKey("about") as? String
        //cell.detailTextLabel!.text = dataDict.objectForKey("") as? String
        cell.tag = dict.objectForKey("uid") as! Int
        
        return cell
    }
    

}
