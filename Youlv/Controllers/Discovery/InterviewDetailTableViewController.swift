//
//  InterviewDetailTableViewController.swift
//  Youlv
//
//  Created by Lost on 14/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class InterviewDetailViewController: BaseTableViewController {
    
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
    @IBOutlet var guestExpandButton: UIButton!
    @IBAction func guestExpandButtonClicked(sender: AnyObject) {
        guestExpandButton.selected = !guestExpandButton.selected
        displayExpandableViews()
    }


    @IBOutlet var interviewTextView: UITextView!
    @IBOutlet var interviewExpandButton: UIButton!
    @IBAction func interviewExpandButtonClicked(sender: AnyObject) {
        interviewExpandButton.selected = !interviewExpandButton.selected
        displayExpandableViews()
    }
    
    @IBOutlet weak var headerView: UIView!
    
    var interviewId : Int?
    var dataDict : NSDictionary?
    var dataDictFromList : NSDictionary?
    

    override func getDataArray(currentPage: Int, pageSize:Int)
    {
        getInterviewDetail(currentPage, pageSize:pageSize)
    }
    
    


    func getInterviewDetail(currentPage: Int, pageSize:Int)
    {
        DataClient().getInterviewDetail(interviewId!, currentPage:currentPage, pageSize:pageSize) { (dict, error) -> () in
            self.getInterviewDetailCompleted(dict,error: error)
        }
    }
    
    func getInterviewDetailCompleted(dict:NSDictionary?,error:NSError?)
    {
        let dictData = dict!.objectForKey("data") as! NSDictionary
        
        let array = dictData.objectForKey("viewDiscusses") as? NSArray
        if (array?.count ?? 0) > 0
        {
            dataArray.addObjectsFromArray(array! as Array)
            currentPage++
            
        }
        dataDict = dictData.objectForKey("viewDetail") as? NSDictionary
        dispatch_sync(dispatch_get_main_queue(), { () -> Void in
            self.displayData()
             self.endLoad()

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
        interviewImageView.sd_setImageWithURL(NSURL(string: dataDict?.objectForKey("view_imgUrl") as! String),placeholderImage:defualtPic)
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
        
        headerView.frame.size.height = 414 + getHeightConstaint(guestTextView) + getHeightConstaint(interviewTextView)
        self.tableView.tableHeaderView = headerView
        UIView.commitAnimations()
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
    
    

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("InterviewContactCell", forIndexPath: indexPath) as! InterviewQATableViewCell

        cell.displayData(dataArray.objectAtIndex(indexPath.item) as! NSDictionary)

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let basicHeight : CGFloat = 99
        let text = (dataArray.objectAtIndex(indexPath.item) as! NSDictionary).objectForKey("discuss_content") as! String
        let textHeight = calTextSizeWithDefualtFont(text, self.view.frame.width - 32).height
        return textHeight + basicHeight
    		
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    
    
//    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return headerView
//    }

    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.barTintColor = UIColor.clearColor()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named:"bgTransNavi"), forBarMetrics: UIBarMetrics.Default)
        
        self.navigationController?.navigationBar.translucent = true
        tableView.frame = CGRectMake(0,-64,self.view.frame.size.width,self.view.frame.size.height+64)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named:"alpha0"), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.barTintColor = appBlueColor
        self.navigationController?.navigationBar.translucent = false
        
    }


   

}
