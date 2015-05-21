//
//  MyFriendsTableViewController.swift
//  Youlv
//
//  Created by Lost on 21/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//



class MyFriendsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    
    var contactsArrayt : NSArray?
    var currentPage = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationItem.titleView = searchBar
        //tableView.
        getFriendsList()
    }
    
    
    
    let client = DataClient()
    func  getFriendsList()
    {
        client.getMyFollowedUsers({ (data, error) -> () in
            self.getFriendsListCompleted(data, error: error)
        })
    }
    
    func getFriendsListCompleted(data:NSData?,error:NSError?)
    {
        if error != nil
        {
            return
        }
        let errorPointer = NSErrorPointer()
        let ds = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String
        NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves, error: errorPointer)
        print(errorPointer.debugDescription)
        let dict = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves, error: errorPointer) as! NSDictionary
        
        let dictData = dict.objectForKey("data") as! NSDictionary
        contactsArrayt = (dictData.objectForKey("lawyerList") as? NSArray)!
        dispatch_sync(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goUserHome"
        {
            let vc = segue.destinationViewController as! UserViewController
            let selectedIndex = tableView.indexPathForSelectedRow()!.item
            vc.userId = (contactsArrayt?.objectAtIndex(selectedIndex) as! NSDictionary).objectForKey("lawyer_id") as! Int
        }
    }
    
     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return contactsArrayt?.count ?? 0
    }
    
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ContactCell", forIndexPath: indexPath) as! UITableViewCell
        let dataDict = contactsArrayt!.objectAtIndex(indexPath.item) as! NSDictionary
        cell.imageView?.sd_setImageWithURL(NSURL(string:dataDict.objectForKey("lawyer_photoUrl") as! String))
        cell.textLabel!.text =  dataDict.objectForKey("lawyer_name") as? String
        //cell.detailTextLabel!.text = dataDict.objectForKey("") as? String
        cell.tag = dataDict.objectForKey("lawyer_id") as! Int
        
        return cell
    }
    

}
