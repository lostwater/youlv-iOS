//
//  EventDetailViewController.swift
//  Youlv
//
//  Created by Lost on 13/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {
    
    @IBOutlet var eventImageView: UIImageView!
    @IBOutlet var eventName: UILabel!
    @IBOutlet var eventValid: UILabel!
    @IBOutlet var eventLocation: UILabel!
    @IBOutlet var eventTime: UILabel!
    @IBOutlet var eventTextView: UITextView!
    @IBOutlet var membersImageList: ImageListView!
    @IBOutlet var bookMarkButton: UIButton!
    
    @IBOutlet weak var shareMenu: UIView!
    @IBAction func viewTapped(sender: AnyObject) {
        shareMenu.hidden = true
    }
    
    @IBAction func shareClicked(sender: AnyObject) {
        shareMenu.hidden = !shareMenu.hidden
    }
   
    @IBAction func bookMarkButtonClicked(sender: AnyObject) {
            markEvent()
    }
    var dict : NSDictionary?
    var eventId : Int?
    
    func loadData()
    {
        eventImageView.sd_setImageWithURL(NSURL(string: dict?.objectForKey("activity_img") as! String),placeholderImage:defualtPic)
        eventName.text = dict?.objectForKey("name") as? String
        eventTextView.text = dict?.objectForKey("text") as? String
        eventLocation.text = dict?.objectForKey("location") as? String
        //eventLocation.text = dataDict?.objectForKey("content") as? String
        let eventTimeText = "开始: " + defaultDateFormatter.stringFromDate(NSDate(fromString: (dict!.objectForKey("start_time") as! String)))
        eventTime.text = eventTimeText
        
        let interestedUsers = dict?.objectForKey("interest_users") as? NSArray
        let avatars = interestedUsers?.mutableArrayValueForKey("avatar")
        
        if avatars != nil
        {
            membersImageList.setImages(avatars!)
        }
        
        bookMarkButton.selected = dict?.objectForKey("interest_or_not") as! Bool
        
        eventId = dict?.objectForKey("activity_id") as? Int
    }

    
    func markEvent()
    {
        httpClient.eventUp(eventId!) { (dict, error) -> () in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.bookMarkButton.selected = !self.bookMarkButton.selected
            })
        }
    }
    
    
    override func viewDidLoad() {
        //bookMarkButton.setImage(UIImage(named:""), forState: UIControlState.Normal)
        //bookMarkButton.setImage(UIImage(named:"buttoncollectedevent"), forState: UIControlState.Selected)
        loadData()


    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.barTintColor = UIColor.clearColor()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named:"bgTransNavi"), forBarMetrics: UIBarMetrics.Default)
        
        self.navigationController?.navigationBar.translucent = true
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named:"alpha0"), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.barTintColor = appBlueColor
        self.navigationController?.navigationBar.translucent = false
        
    }

}
