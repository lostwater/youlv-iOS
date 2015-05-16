
//
//  JobDetailViewController.swift
//  Youlv
//
//  Created by Lost on 14/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class JobDetailViewController: UIViewController {

    @IBOutlet var lawyerName: UILabel!
    @IBOutlet var companyName: UILabel!
    @IBOutlet var isMarkedButton: UIButton!
    @IBAction func isMarkedButtonClicked(sender: AnyObject) {
        if !isMarkedButton.selected
        {
            isMarkedButton.selected = !isMarkedButton.selected
            DataClient().postMarkJob(jobId!) { (data, error) -> () in
            }
        }
    }
    
    @IBOutlet var salary: UILabel!
    @IBOutlet var location: UILabel!
    @IBOutlet var jobType: UILabel!
    @IBOutlet var exp: UILabel!
    @IBOutlet var edu: UILabel!
    
    @IBOutlet var companyImageView: UIImageView!
    @IBOutlet var companyIntroName: UILabel!
    @IBOutlet var companyIntro: UILabel!
    @IBOutlet var companyIntroExpandButton: UIButton!
    @IBOutlet var companyTextView: UITextView!
    @IBAction func companyIntroExpandButtonClicked(sender: AnyObject) {
        companyIntroExpandButton.selected = !companyIntroExpandButton.selected
        displayExpandableViews()
    }
    
    @IBOutlet var jobTagsExpandButton: UIButton!
    @IBOutlet var jobTags: DWTagList!
    @IBOutlet var jobTagsHeightContraint: NSLayoutConstraint!
    @IBAction func jobTagsExpandButtonClicked(sender: AnyObject) {
        jobTagsExpandButton.selected = !jobTagsExpandButton.selected
        displayExpandableViews()
    }
    
    @IBOutlet var requirementExpandButton: UIButton!
    @IBOutlet var requirementTextView: UITextView!
    @IBAction func requirementExpandButtonClicked(sender: AnyObject) {
        requirementExpandButton.selected = !requirementExpandButton.selected
        displayExpandableViews()
    }
    
    var dataDict : NSDictionary?
    var jobId : Int?
    var companyImageUrl : String?
    
    
    let client = DataClient()
    func getJobDetail()
    {
        client.getJobDetail(jobId!, completion: { (data, error) -> () in
            self.getJobDetailCompleted(data, error: error)
        })
    }
    
    func getJobDetailCompleted(data:NSData?,error:NSError?)
    {
        if error != nil
        {
            return
        }
        
        let errorPointer = NSErrorPointer()
        let dict = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves, error: errorPointer) as! NSDictionary
        
        dataDict = dict.objectForKey("data") as? NSDictionary
        dispatch_sync(dispatch_get_main_queue(), { () -> Void in
            self.displayData()
        })
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isMarkedButton.setImage(UIImage(named:"iconfavoriteoutline"), forState: UIControlState.Normal)
        isMarkedButton.setImage(UIImage(named:"iconfavorite"), forState: UIControlState.Selected)
        isMarkedButton.setTitle("未收藏", forState: UIControlState.Normal)
        isMarkedButton.setTitle("已收藏", forState: UIControlState.Selected)
        companyIntroExpandButton.setImage(UIImage(named:"buttonarrowdown"), forState: UIControlState.Normal)
        companyIntroExpandButton.setImage(UIImage(named:"buttonarrowup"), forState: UIControlState.Selected)
        jobTagsExpandButton.setImage(UIImage(named:"buttonarrowdown"), forState: UIControlState.Normal)
        jobTagsExpandButton.setImage(UIImage(named:"buttonarrowup"), forState: UIControlState.Selected)
        requirementExpandButton.setImage(UIImage(named:"buttonarrowdown"), forState: UIControlState.Normal)
        requirementExpandButton.setImage(UIImage(named:"buttonarrowup"), forState: UIControlState.Selected)
        displayExpandableViews()
        getJobDetail()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
"position_id":1,
"position_salary":"100-200",
"position_createDate":"2015-04-21 09:43:52",
"position_officeName":"易律",
"position_cityName":"北京市",
"position_title":"易律招聘",
"position_content":"招聘",
"position_type":1,
"position_education":"本科",
"position_experience":"",
"position_keywords":"高大尚",
"office_introduction":"全国最大的律师平台",
"office_keywords":"1,2,3,4,上山打老虎",
"position_isCollection":6
*/
    func displayData()
    {
        //isMarkedButton.selected = (dataDict!.objectForKey("position_isCollection") as? Bool)!

        lawyerName.text = dataDict!.objectForKey("position_title") as? String
        companyName.text = dataDict!.objectForKey("position_officeName") as? String
        salary.text = dataDict!.objectForKey("position_salary") as? String
        location.text = dataDict!.objectForKey("position_cityName") as? String
        edu.text = dataDict!.objectForKey("position_education") as? String
        exp.text = dataDict!.objectForKey("position_experience") as? String
        if dataDict!.objectForKey("position_type") as! Int == 1
        {
            jobType.text = "全职"
        }
        else
        {
            jobType.text = "兼职"
            
        }
        
        companyImageView.sd_setImageWithURL(NSURL(string:companyImageUrl!))
        companyIntroName.text =  dataDict!.objectForKey("position_officeName") as? String
        companyIntro.text = dataDict!.objectForKey("office_introduction") as? String
        
        let jobTagsValue = NSArray(object: dataDict!.objectForKey("position_keywords")!) as [AnyObject]
        jobTags.setTags(jobTagsValue)
        jobTags.display()
        
        requirementTextView.text = dataDict!.objectForKey("position_content") as? String
        

    }

    func displayExpandableViews()
    {
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.3)
        if companyIntroExpandButton.selected
        {
            resizeTextView(companyTextView)
        }
        else
        {
            collapseView(companyTextView)
        }
        if requirementExpandButton.selected
        {
            resizeTextView(requirementTextView)
        }
        else
        {
            collapseView(requirementTextView)
        }
        if jobTagsExpandButton.selected
        {
            jobTagsHeightContraint.constant = 44
        }
        else
        {
            jobTagsHeightContraint.constant = 0
        }
        UIView.commitAnimations()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
