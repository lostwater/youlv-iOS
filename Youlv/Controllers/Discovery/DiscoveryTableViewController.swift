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
    

    var topicsArray : NSArray?
    var adsArray : NSArray?
    
    var adsUrlsArray = NSMutableArray()
    
    func getTopics()
    {
        httpClient.getTopicList { (dict, error) -> () in
            self.getTopicsCompleted(dict, error: error)
        }
    }
    
    func getTopicsCompleted(dict:NSDictionary?,error:NSError?)
    {
        topicsArray = dict?.objectForKey("results") as? NSArray
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.displayTopics()
        })
    
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        adsUrlsArray.removeAllObjects()
        getTopics()
        imagePlayer.imagePlayerViewDelegate = self
        imagePlayer.scrollInterval = 5
        imagePlayer.pageControlPosition = ICPageControlPosition.BottomCenter
        imagePlayer.hidePageControl = false
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.viewDidLoad()
    }
    
    func displayTopics()
    {
        for var i = 0;i<topicButtons.count && i<topicsArray!.count;i++
        {
            let button = topicButtons[i]
            let topic = topicsArray!.objectAtIndex(i) as! NSDictionary
            button.setTitle(topic.objectForKey("title") as? String, forState: UIControlState.Normal)
            button.hidden = false
            let imageUrl = topic.objectForKey("topictype_background_img") as? String
            adsUrlsArray.addObject(NSURL(string:imageUrl!)!)

        }
        self.imagePlayer.reloadData()
    }
    

    
    func numberOfItems() -> Int {
        return adsUrlsArray.count
    }
    
    func imagePlayerView(imagePlayerView: ImagePlayerView!, loadImageForImageView imageView: UIImageView!, index: Int) {
        imageView.sd_setImageWithURL(self.adsUrlsArray.objectAtIndex(index) as! NSURL, placeholderImage: defualtPic)

    }
    
    func imagePlayerView(imagePlayerView: ImagePlayerView!, didTapAtIndex index: Int) {
        topicButtons[index].sendActionsForControlEvents(.TouchUpInside)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        if segue.identifier == "goTopic1"
        {
            let vc = segue.destinationViewController as! GroupTopicsTableViewController
            vc.groupDict = topicsArray!.objectAtIndex(0) as! NSDictionary
        }
        if segue.identifier == "goTopic2"
        {
            let vc = segue.destinationViewController as! GroupTopicsTableViewController
            vc.groupDict = topicsArray!.objectAtIndex(1) as! NSDictionary
        }
        if segue.identifier == "goTopic3"
        {
            let vc = segue.destinationViewController as! GroupTopicsTableViewController
            vc.groupDict = topicsArray!.objectAtIndex(2) as! NSDictionary
        }
        if segue.identifier == "goTopic4"
        {
            let vc = segue.destinationViewController as! GroupTopicsTableViewController
            vc.groupDict = topicsArray!.objectAtIndex(3) as! NSDictionary
        }
        
    }

}
