//
//  InterviewDetailTableViewController.swift
//  Youlv
//
//  Created by Lost on 14/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class InterviewDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBAction func unwindToInterviewDetail(segue: UIStoryboardSegue)
    {
        //performSegueWithIdentifier("UnwindToGroupTopics", sender: self)
    }
    
    @IBOutlet var interviewImageView: UIImageView!
    @IBOutlet var guestImageView: UIImageView!
    @IBOutlet var guestName: UILabel!
    @IBOutlet var guestFansCount: UILabel!
    @IBOutlet var fellowGuestButton: UIButton!
    
    @IBAction func fellowGuestButtonClicked(sender: AnyObject) {
        if !fellowGuestButton.selected
        {
             markInterview()
        }
    }
    
    
    @IBOutlet var guestTextView: UITextView!
    @IBOutlet var guestTextViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet var guestExpandButton: UIButton!
    @IBAction func guestExpandButtonClicked(sender: AnyObject) {
        guestExpandButton.selected = !guestExpandButton.selected
        displayExpandableViews()
    }


    @IBOutlet var interviewTextView: UITextView!
    @IBOutlet var interviewTextViewHeightContraint: UITextView!
    @IBOutlet var interviewExpandButton: UIButton!
    @IBAction func interviewExpandButtonClicked(sender: AnyObject) {
        interviewExpandButton.selected = !interviewExpandButton.selected
        displayExpandableViews()
    }
    
    @IBOutlet var tableView: UITableView!
    
    var interviewId : Int?
    var qAndAArray : NSArray?
    var currentPage = 1
    var dataDict : NSDictionary?
    var dataDictFromList : NSDictionary?
    

    func getInterviewDetail()
    {
        DataClient().getInterviewDetail(interviewId!, currentPage: currentPage, pageSize: 10) { (data, error) -> () in
            self.getInterviewDetailCompleted(data,error: error)
        }
    }
    
    func getInterviewDetailCompleted(data:NSData?,error:NSError?)
    {
        if error != nil
        {
            return
        }
        let errorPointer = NSErrorPointer()
        let dict = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves, error: errorPointer) as! NSDictionary
        
        dataDict = dict.objectForKey("data") as? NSDictionary
        qAndAArray = (dataDict!.objectForKey("viewDiscusses") as? NSArray)!
        
        dataDict = dataDict!.objectForKey("viewDetail") as? NSDictionary
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
          self.displayData()
        })
    }
    
    func markInterview()
    {
        DataClient().postMarkInterview(interviewId!) { (dict, error) -> () in
            self.markInterviewCompleted(dict, error: error)
        }
    }
    
    func markInterviewCompleted(dict:NSDictionary?, error:NSError?)
    {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.fellowGuestButton.selected = true
        })
        
    }

    
    
    func displayData()
    {
        
        if (dataDictFromList!.objectForKey("view_isAtten") as! Int) > 0
        {
            fellowGuestButton.selected = true
        }
        interviewImageView.sd_setImageWithURL(NSURL(string: dataDict?.objectForKey("view_imgUrl") as! String))
        guestImageView.sd_setImageWithURL(NSURL(string: dataDictFromList?.objectForKey("view_lawyerPhotoUrl") as! String),placeholderImage:headImage)
        guestName.text = dataDictFromList?.objectForKey("view_lawyerName") as? String
        guestFansCount.text = "粉丝: " + String(dataDict?.objectForKey("lawyer_fansCount") as! Int)
        guestTextView.text = dataDict?.objectForKey("lawyer_introduction") as! String
        interviewTextView.text = dataDictFromList?.objectForKey("view_content") as! String
        displayExpandableViews()
        tableView.reloadData()
    }
    
    func displayExpandableViews()
    {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.3)
        if guestExpandButton.selected
        {
            resizeTextView(guestTextView)
        }
        else
        {
            collapseView(guestTextView)
        }
        if interviewExpandButton.selected
        {
            resizeTextView(interviewTextView)
        }
        else
        {
            collapseView(interviewTextView)
        }
         UIView.commitAnimations()

    }
    
    
    override func viewWillAppear(animated: Bool) {
        getInterviewDetail()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        guestExpandButton.setImage(UIImage(named:"buttonarrowdown"), forState: UIControlState.Normal)
        guestExpandButton.setImage(UIImage(named:"buttonarrowup"), forState: UIControlState.Selected)
        interviewExpandButton.setImage(UIImage(named:"buttonarrowdown"), forState: UIControlState.Normal)
        interviewExpandButton.setImage(UIImage(named:"buttonarrowup"), forState: UIControlState.Selected)
        //fellowGuestButton.setImage(UIImage(named:"buttonarrowdown"), forState: UIControlState.Normal)
        fellowGuestButton.setImage(UIImage(named:"buttoncollectedevent"), forState: UIControlState.Selected)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goInterviewAsk"
        {
            let vc = segue.destinationViewController as! InterviewAskViewController
            vc.interviewId = self.interviewId!
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return qAndAArray?.count ?? 0
    }


    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("InterviewContactCell", forIndexPath: indexPath) as! InterviewQATableViewCell

        cell.displayData(qAndAArray?.objectAtIndex(indexPath.item) as! NSDictionary)

        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let basicHeight : CGFloat = 99
        let text = (qAndAArray?.objectAtIndex(indexPath.item) as! NSDictionary).objectForKey("discuss_content") as! String
        let textHeight = calTextSizeWithDefualtFont(text, self.view.frame.width - 32).height
        return textHeight + basicHeight
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.barTintColor = UIColor.clearColor()
        self.navigationController?.navigationBar.translucent = true
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.barTintColor = appBlueColor
        self.navigationController?.navigationBar.translucent = false
        
    }


   

}
