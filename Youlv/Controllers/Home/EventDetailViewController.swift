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
    
    @IBAction func bookMarkButtonClicked(sender: AnyObject) {
        if !bookMarkButton.selected
        {
            markEvent()
        }
    }
    var dataDict : NSDictionary?
    var eventId : Int?
    
    func loadData()
    {
        eventImageView.sd_setImageWithURL(NSURL(string: dataDict?.objectForKey("photoUrl") as! String))
        eventName.text = dataDict?.objectForKey("title") as? String
        eventTextView.text = dataDict?.objectForKey("content") as? String
        //eventLocation.text = dataDict?.objectForKey("content") as? String
        let eventTimeText = "开始: " + defaultDateFormatter.stringFromDate(NSDate(fromString: (dataDict!.objectForKey("activeTime") as! String)))
        eventTime.text = eventTimeText
        let photoDicts = dataDict?.objectForKey("attentionPhotos") as? NSArray
        if photoDicts != nil
        {
            var photoUrls = NSArray()
            for photo in photoDicts!
            {
                photoUrls = photoUrls.arrayByAddingObject((photo as! NSDictionary).objectForKey("photoUrl") as! String)
            }
            membersImageList.setImages(photoUrls)
        }
        bookMarkButton.selected = dataDict?.objectForKey("isCollect") as! Bool
    }
    
    func getEventDetail()
    {
        DataClient().getEventDetail(eventId!, completion: { (dict, error) -> () in
            self.getEventDetailCompleted(dict,error: error)
        })
    }
    
    func getEventDetailCompleted(dict:NSDictionary?,error:NSError?)
    {
        self.dataDict = dict!.objectForKey("data") as? NSDictionary
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.loadData()
        })
        
    }
    
    func markEvent()
    {
        var parameters : NSDictionary = ["activeId":eventId!
            , "sessionId":sessionId]
        DataClient().postMarkEvent(parameters) { (data, error) -> () in
            dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                self.markEventCompleted(data,error: error)
                
            })
        }
    }
    
    func markEventCompleted(data:NSDictionary?,error:NSError?)
    {
        if data?.objectForKey("errcode") as? Int == 0
        {
            bookMarkButton.selected = true
        }
        
        
    }
    
    
    override func viewDidLoad() {
        //bookMarkButton.setImage(UIImage(named:""), forState: UIControlState.Normal)
        bookMarkButton.setImage(UIImage(named:"buttoncollectedevent"), forState: UIControlState.Selected)
        getEventDetail()
        
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
