//
//  NewTopicTableViewController.swift
//  Youlv
//
//  Created by Lost on 23/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class NewTopicTableViewController: UITableViewController {

    @IBOutlet weak var selectedTopic: UILabel!
    
    @IBAction func buttonCancelClicked(sender: AnyObject) {
   
        self.dismissViewControllerAnimated(false,completion:nil);
    }
    
    @IBAction func newTopicGroupDidSelected(segue: UIStoryboardSegue)
    {
        
        let vc =  segue.sourceViewController as! TopicsTableViewController
        topicGroupId = vc.selectedGroupId
        selectedTopic.text = vc.selectedGroupName
    }
    
    @IBAction func newTopicGroupDidCancell(segue: UIStoryboardSegue)
    {
        topicGroupId = 0
    }
    
    @IBOutlet weak var contentTextView: CPTextViewPlaceholder!
    
    
    @IBAction func buttonPubClicked(sender: AnyObject) {
        if topicGroupId == 0
        {
            
        }
        else
        {
            postTopic()
        }
    }
    
    var topicGroupId = 0
    var topicGroupName : String?
    
    
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
    
    func postTopic()
    {
        httpClient.postNewTopic(topicGroupId, text: contentTextView.text!) { (dict, error) -> () in
            self.postTopicCompleted(dict,error:error)

        }
    }
    
    func postTopicCompleted(dict:NSDictionary?, error:NSError?)
    {
        KVNProgress.showSuccess()
        self.dismissViewControllerAnimated(false, completion:nil)
    }

    
}
