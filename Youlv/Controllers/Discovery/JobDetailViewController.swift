
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
        httpClient.bookMarkJob(jobId!) { (dict, error) -> () in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                KVNProgress.showSuccess()
                self.isMarkedButton.selected = !self.isMarkedButton.selected
            })
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
        displayData()
        // Do any additional setup after loading the view.
    }

    func displayData()
    {
        //isMarkedButton.selected = (dataDict!.objectForKey("position_isCollection") as? Bool)!
        jobId = dataDict!.objectForKey("id") as? Int
        companyImageUrl =  dataDict!.objectForKey("agency_img") as? String
        lawyerName.text = dataDict!.objectForKey("name") as? String
        companyName.text = dataDict!.objectForKey("agency_name") as? String
        salary.text = dataDict!.objectForKey("salary") as? String
        location.text = dataDict!.objectForKey("location") as? String
        edu.text = dataDict!.objectForKey("degree_qualification") as? String
        exp.text = dataDict!.objectForKey("time_qualification") as? String

        jobType.text = dataDict!.objectForKey("type") as? String
        
        companyImageView.sd_setImageWithURL(NSURL(string:companyImageUrl ?? ""))
        companyIntroName.text =  dataDict!.objectForKey("position_officeName") as? String
        companyIntro.text = dataDict!.objectForKey("office_introduction") as? String
        
        //let jobTagsValue = NSArray(object: dataDict!.objectForKey("position_goods")!) as [AnyObject]
        //jobTags.setTags(jobTagsValue)
        //jobTags.display()
        
        requirementTextView.text = dataDict!.objectForKey("position_requirements") as? String
        

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
