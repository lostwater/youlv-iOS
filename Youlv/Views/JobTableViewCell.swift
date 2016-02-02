//
//  JobTableViewCell.swift
//  Youlv
//
//  Created by Lost on 16/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class JobTableViewCell: UITableViewCell {

    @IBOutlet var jobImageView: UIImageView!
    @IBOutlet var companyName: UILabel!
    @IBOutlet var jobPosition: UILabel!
    @IBOutlet var jobLocation: UILabel!
    @IBOutlet var jobTime: UILabel!
    @IBOutlet var salaryLabel: UILabel!
    var dateFormatter = NSDateFormatter()
    override func awakeFromNib() {
        super.awakeFromNib()
        dateFormatter.dateFormat="yyyy.MM.dd"
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(dict : NSDictionary)
    {
        dateFormatter.dateFormat="yyyy.MM.dd"
        /*
        "positionList":[
        {
        "position_id":1,
        "position_createDate":"2015-04-21 09:43:52",
        "position_officeName":"易律",
        "position_type":1,
        "position_cityName":"北京市",
        "position_salary":"100-200",
        "position_officePhoto":"www..photo"
        }
        */
        
        jobImageView.sd_setImageWithURL(NSURL(string:dict.objectForKey("agency_img") as! String)!)
        
        jobImageView.layer.cornerRadius = jobImageView.frame.height/2
        
        companyName.text = dict.objectForKey("agency_name") as? String
        jobPosition.text = dict.objectForKey("name") as? String

       
        //let time = NSDate(fromString:dataDict.objectForKey("position_createDate") as! String)
        //jobTime.text = dateFormatter.stringFromDate(time!)

        salaryLabel.text = dict.objectForKey("salary") as? String
        jobTime.text =  ""
        jobLocation.text = dict.objectForKey("location") as? String


    }

}
