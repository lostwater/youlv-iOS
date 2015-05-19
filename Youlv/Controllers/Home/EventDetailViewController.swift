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
    
    var dataDict : NSDictionary?
    var eventId : Int?
    
    func loadData()
    {
        eventImageView.sd_setImageWithURL(NSURL(string: dataDict?.objectForKey("photoUrl") as! String))
        eventName.text = dataDict?.objectForKey("title") as? String
        eventTextView.text = dataDict?.objectForKey("content") as? String
        //eventLocation.text = dataDict?.objectForKey("content") as? String
        let eventTimeText = "开始: " + (dataDict!.objectForKey("activeTime") as! String)
        eventTime.text = eventTimeText
        let photoDicts = dataDict?.objectForKey("attentionPhotos") as? NSArray
        var photoUrls = NSArray()
        for photo in photoDicts!
        {
            photoUrls = photoUrls.arrayByAddingObject((photo as! NSDictionary).objectForKey("photoUrl") as! String)
        }
        membersImageList.setImages(photoUrls)
        

    }
    
    func getEventDetail()
    {
        DataClient().getEventDetail(eventId!, completion: { (data, error) -> () in
            self.getEventDetailCompleted(data,error: error)
        })
    }
    
    func getEventDetailCompleted(data:NSData?,error:NSError?)
    {
        if error != nil
        {
            return
        }
        let errorPointer = NSErrorPointer()
        let dict = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves, error: errorPointer) as! NSDictionary
        
        self.dataDict = dict.objectForKey("data") as? NSDictionary
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.loadData()
        })
        
    }

    
    
    override func viewDidLoad() {
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
