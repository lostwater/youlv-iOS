//
//  DiscoveryTableViewController.swift
//  Youlv
//
//  Created by Lost on 20/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//



class DiscoveryTableViewController: UITableViewController,ImagePlayerViewDelegate {

    @IBOutlet weak var topicButton1: UIButton!
    @IBOutlet weak var topicButton2: UIButton!
    @IBOutlet weak var topicButton3: UIButton!
    @IBOutlet weak var topicButton4: UIButton!
    @IBOutlet weak var adsPageControl: UIPageControl!
    @IBOutlet var topicButtons: [UIButton]!
    @IBOutlet weak var adScroll: UIScrollView!
    
    @IBOutlet weak var imagePlayer: ImagePlayerView!
    
    
    var currentPage = 1
    var topicsArray : NSArray?
    var adsArray : NSArray?
    
    var adsUrlsArray = NSMutableArray()
    
    let client = DataClient()
    func getTopics(currentPage: Int, pageSize:Int)
    {
        client.getHotTopicGroup(currentPage, pageSize: pageSize, completion: { (dict, error) -> () in
            self.getTopicsCompleted(dict, error: error)
        })
    }
    
    func getTopicsCompleted(dict:NSDictionary?,error:NSError?)
    {
        
        let dictData = dict!.objectForKey("data") as! NSDictionary
        topicsArray = (dictData.objectForKey("hotTopicGroups") as? NSArray)!
        dispatch_sync(dispatch_get_main_queue(), { () -> Void in
            self.displayTopics()
        })
    
    }
    
    
    func getAds()
    {
        client.getAds({ (data, error) -> () in
            self.getAdsCompleted(data, error: error)
        })
    }
    
    func getAdsCompleted(data:NSData?,error:NSError?)
    {
        if error != nil
        {
            return
        }
        
        let errorPointer = NSErrorPointer()
        let dict = (try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves)) as! NSDictionary
        
        let dictData = dict.objectForKey("data") as! NSDictionary
        adsArray = (dictData.objectForKey("adList") as? NSArray)!
        for a in adsArray!
        {
            let adict = a as! NSDictionary
             adsUrlsArray.addObject(NSURL(string: adict.objectForKey("photoUrl") as! String)!)
        }

        dispatch_sync(dispatch_get_main_queue(), { () -> Void in
            self.imagePlayer.reloadData()
        })
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        adsUrlsArray.removeAllObjects()
        getTopics(1,pageSize: 10)
        imagePlayer.imagePlayerViewDelegate = self
        imagePlayer.scrollInterval = 5
        imagePlayer.pageControlPosition = ICPageControlPosition.BottomCenter
        imagePlayer.hidePageControl = false
        getAds()
        
        adsUrlsArray.addObject(NSURL(string: "http://images.ali213.net/picfile/pic/2013/02/21/927_138.jpg")!)
        adsUrlsArray.addObject(NSURL(string: "http://bbs.szonline.net/UploadFile/album/2011/5/71587/23/20110523165858_16553.jpg")!)
        adsUrlsArray.addObject(NSURL(string: "http://bbs.szonline.net/UploadFile/album/2011/5/71587/23/20110523165858_66558.jpg")!)
        self.imagePlayer.reloadData()

       
    }
    
    func displayTopics()
    {
        for var i = 0;i<topicButtons.count && i<topicsArray!.count;i++
        {
            let b = topicButtons[i]
            let g = topicsArray!.objectAtIndex(i) as! NSDictionary
            b.setTitle(g.objectForKey("title") as? String, forState: UIControlState.Normal)
        }
    }
    
    func addImages()
    {
        adsPageControl.numberOfPages = adsArray?.count ?? 0
        for  a in adsArray!
        {
            let d = a as! NSDictionary
            let iv = UIImageView(frame: adsPageControl.frame)
            //UIImageView.
        }
        //adPageControl.
    }
    
    func numberOfItems() -> Int {
        return adsUrlsArray.count
    }
    
    func imagePlayerView(imagePlayerView: ImagePlayerView!, loadImageForImageView imageView: UIImageView!, index: Int) {
        imageView.sd_setImageWithURL(self.adsUrlsArray.objectAtIndex(index) as! NSURL, placeholderImage: defualtPic)

    }
    
    func imagePlayerView(imagePlayerView: ImagePlayerView!, didTapAtIndex index: Int, imageURL: NSURL!) {
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        if segue.identifier == "goTopic1"
        {
            let vc = segue.destinationViewController as! GroupTopicsTableViewController
            vc.groupId = (topicsArray!.objectAtIndex(0) as! NSDictionary).objectForKey("groupId") as! Int
        }
        if segue.identifier == "goTopic2"
        {
            let vc = segue.destinationViewController as! GroupTopicsTableViewController
            vc.groupId = (topicsArray!.objectAtIndex(1) as! NSDictionary).objectForKey("groupId") as! Int
        }
        if segue.identifier == "goTopic3"
        {
            let vc = segue.destinationViewController as! GroupTopicsTableViewController
            vc.groupId = (topicsArray!.objectAtIndex(2) as! NSDictionary).objectForKey("groupId") as! Int
        }
        if segue.identifier == "goTopic4"
        {
            let vc = segue.destinationViewController as! GroupTopicsTableViewController
            vc.groupId = (topicsArray!.objectAtIndex(3) as! NSDictionary).objectForKey("groupId") as! Int
        }
        
    }

}
