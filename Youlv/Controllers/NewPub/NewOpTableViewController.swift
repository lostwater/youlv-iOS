//
//  NewOpTableViewController.swift
//  Youlv
//
//  Created by Lost on 23/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class NewOpTableViewController: UITableViewController {

    @IBAction func buttonPubClicked(sender: AnyObject) {
        thetitle = titleTextField.text
        content = contentContainer.text
         postDict = NSDictionary(objects: [thetitle, content, type, tagList, blackList, whiteList,cityId, cityName,curDate, sessionId], forKeys: ["tile","content","type","keyWords","blackList","whiteList","cityId","cityName","deaddate","sessionId"])
        DataClient().postOrder(postDict!, completion: { (data, error) -> () in
            
        })
    }
    
    @IBAction func buttonCancelClicked(sender: AnyObject) {
        let newVC: AnyObject! = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("NewVC")
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        isCancellingNew = true
        self.dismissViewControllerAnimated(false, completion:nil)
    }
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var typeSegment: UISegmentedControl!
    @IBOutlet var contentContainer: UITextField!

    @IBAction func typeSegmentChanged(sender: AnyObject) {
        type = typeSegment.selectedSegmentIndex
    }
    
    @IBAction func contentEnd(sender: AnyObject) {
        contentContainer.resignFirstResponder()
    }
    
    @IBAction func titleEnded(sender: AnyObject) {
        titleTextField.resignFirstResponder()

    }
    
    var thetitle = ""
    var content = ""
    var type = 0
    
    var tagList = NSArray()
    var blackList = NSArray()
    var whiteList = NSArray()
    var curDate = NSDate()
    var formatter = NSDateFormatter()
    
    var cityList : NSArray?
    var cityId = 1
    var cityName = "北京市"
    var postDict : NSDictionary?
    
  
    
    func postOrderCompleted(data:NSData?, error:NSError?)
    {
        if data != nil
        {
            let newVC: AnyObject! = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("NewVC")
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            isCancellingNew = true
            self.dismissViewControllerAnimated(false, completion:nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        typeSegment.selectedSegmentIndex = type
        titleTextField.text = thetitle
        contentContainer.text = content
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
            vc.type = type
        }
    }



}
