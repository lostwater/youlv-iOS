//
//  MyHomeTableViewController.swift
//  Youlv
//
//  Created by Lost on 19/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//



class MyHomeTableViewController: UITableViewController {

    @IBOutlet var userImageView: UIImageView!
    @IBOutlet weak var userName: UILabel!

    @IBOutlet weak var location: UILabel!
    
    @IBOutlet weak var fellowsCount: UIButton!
    @IBOutlet weak var fansCount: UIButton!
    
    var dataDict : NSDictionary?
    
    func getMyProfile()
    {
        DataClient().getUserProfileWithTopicList(myLawyerId,currentPage: 1,pageSize: 0,completion: { (dict, error) -> () in
            self.getMyProfileCompleted(dict,error: error)
        })
    }
    
    func getMyProfileCompleted(dict:NSDictionary?,error:NSError?)
    {

        self.dataDict = dict!.objectForKey("data") as? NSDictionary
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.displayData()
        })
        
    }
    
    func displayData()
    {
        userImageView.sd_setImageWithURL(NSURL(string: dataDict!.objectForKey("lawyer_photoUrl") as! String))
        userName.text = dataDict!.objectForKey("lawyer_name") as? String
        location.text = (dataDict!.objectForKey("lawyer_cityName") as! String) + ", " + (dataDict!.objectForKey("lawyer_lawOffice") as! String)
        var fellowstitle = String(dataDict!.objectForKey("lawyer_attentionCount")as! Int)
        fellowstitle = "关注 " + fellowstitle
        fellowsCount.setTitle(fellowstitle, forState: UIControlState.Normal)
        var fanstitle = String(dataDict!.objectForKey("lawyer_fansCount")as! Int)
        fanstitle = "粉丝 " + fanstitle
        fansCount.setTitle(fanstitle, forState: UIControlState.Normal)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMyProfile()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
