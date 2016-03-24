//
//  NewOpTableViewController.swift
//  Youlv
//
//  Created by Lost on 23/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class NewOpportunityTableViewController: UITableViewController {

    @IBAction func opportunityOptionsSet(segue: UIStoryboardSegue)
    {
        
    }
    
    @IBAction func buttonPubClicked(sender: AnyObject) {
        thetitle = titleTextField.text!
        content = contentContainer.text!
        let postDict = NSMutableDictionary()
        postDict.setValue(thetitle, forKey: "title")
        postDict.setValue(content, forKey: "text")
        postDict.setValue(type, forKey: "type")
        postDict.setValue(target, forKey: "target")
        postDict.setValue(formatter.stringFromDate(deadDate), forKey: "deadline")
        postDict.setValue(tagList as [AnyObject], forKey: "tag")
    
        
        // postDict = NSDictionary(objects: [thetitle, content, privilege, tagList, blackList, whiteList,cityId, cityName,deadDate, sessionId], forKeys: ["tile","content","type","keyWords","blackList","whiteList","cityId","cityName","deaddate","sessionId"])
        httpClient.postNewCase(postDict, completion: { (dict, error) -> () in
            self.postOrderCompleted(dict, error: error)
        })
    }
    
    @IBAction func buttonCancelClicked(sender: AnyObject) {
        //let newVC: AnyObject! = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("NewVC")
        //let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        self.dismissViewControllerAnimated(true, completion:nil)
    }
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var typeSegment: UISegmentedControl!
    @IBOutlet var contentContainer: UITextField!

    @IBAction func typeSegmentChanged(sender: AnyObject) {
        privilege = typeSegment.selectedSegmentIndex
    }
    
    @IBAction func contentEnd(sender: AnyObject) {
        contentContainer.resignFirstResponder()
    }
    
    @IBAction func titleEnded(sender: AnyObject) {
        titleTextField.resignFirstResponder()

    }
    
    var thetitle = ""
    var content = ""
    var type = 1
    var target = ""

    
    
    var privilege = 0
    
    var tagList = NSMutableArray()
    var blackList = NSArray()
    var whiteList = NSArray()
    var deadDate = NSDate()
    var formatter = NSDateFormatter()
    var deadDateString = ""
    //var cityList : NSArray?
    //var cityId = 1
    

    
  
    
    func postOrderCompleted(dict:NSDictionary?, error:NSError?)
    {
        KVNProgress.showSuccess()
        self.dismissViewControllerAnimated(true, completion:nil)

            //let newVC: AnyObject! = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("NewVC")
            //let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        
            
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        typeSegment.selectedSegmentIndex = privilege
        titleTextField.text = thetitle
        contentContainer.text = content
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goOpSettings"
        {
            let vc = segue.destinationViewController as! NewOpportunityOptionsViewController
            vc.thetitle = thetitle
            vc.content = content
            vc.privilege = privilege
            vc.tagList = tagList
            vc.deadDateString = deadDateString
            vc.target = target
        }
    }



}
