//
//  NewOpportunityOptionsViewController.swift
//  Youlv
//
//  Created by Lost on 17/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class NewOpportunityOptionsViewController: UIViewController, THDatePickerDelegate, UIPickerViewDataSource,UIPickerViewDelegate,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet var deadlineDataButton: UIButton!
    @IBAction func deadlineDataButtonClicked(sender: AnyObject) {
        showCalender()
    }
    
    @IBOutlet var newTagTextField: UITextField!
    @IBOutlet var tagsListView: DWTagList!
    @IBAction func addTagButtonClicked(sender: AnyObject) {
        addTag()

    }
    @IBOutlet var locationButton: UIButton!
    @IBAction func locationButtonClicked(sender: AnyObject) {
        showCityList()

    }
    
    @IBOutlet var cityPicker: UIPickerView!
    
    @IBAction func tagTextFieldDidEnd(sender: AnyObject) {
        hideKB()
    }
    
    @IBAction func tagTextEditingDidEnt(sender: AnyObject) {
        addTag()
        hideKB()
    }
    
    
    var datePicker : THDatePickerViewController?

    var thetitle = ""
    var content = ""
    var type = 0
    
    var tagList = NSArray()
    var blackList = NSArray()
    var whiteList = NSArray()
    var curDate = NSDate()
    var formatter = NSDateFormatter()
    
    var cityList : NSArray?
    var cityId = 1
    var cityName = "北京市"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.dateFormat = "yyyy.MM.dd"
        getCityList()
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "optionsSetted"
        {
            var vc = segue.destinationViewController as! NewOpTableViewController
            vc.cityName = cityName
            vc.cityId = cityId
            vc.tagList = tagList
            vc.blackList = blackList
            vc.whiteList = whiteList
            vc.curDate = curDate
            vc.thetitle = thetitle
            vc.content = content
            vc.type = type
        }
    }
    
    
    func displayDate()
    {
        deadlineDataButton.setTitle(formatter.stringFromDate(curDate), forState: UIControlState.Normal)
    }
    
    func showCityList()
    {
            presentSemiViewWithMyOptions(cityPicker)
    }
    
    func getCityList()
    {
        
        DataClient().getCityList(1, pageSize: 100, completion: { (dict, error) -> () in
            self.getCityListCompleted(dict,error: error)
        })
    }
    
    func getCityListCompleted(dict:NSDictionary?,error:NSError?)
    {

        let dataDict = dict!.objectForKey("data") as? NSDictionary
        cityList = dataDict!.objectForKey("cityList") as? NSArray
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.cityPicker.reloadAllComponents()
        })
        
    }

    
    func showCalender()
    {
        if datePicker == nil
        {
            datePicker = THDatePickerViewController.datePicker();
        }
        datePicker?.date = curDate;
        datePicker?.delegate = self;
        datePicker?.setAllowClearDate(false)
        datePicker?.setAutoCloseOnSelectDate(true)
        datePicker?.selectedBackgroundColor = UIColor(red:125/255.0, green:208/255.0, blue:0/255.0, alpha:1.0)
        datePicker?.currentDateColor = UIColor(red:242/255.0, green:121/255.0, blue:53/255.0, alpha:1.0)
        
        datePicker?.setDateHasItemsCallback({ (data) -> Bool in
            let tmp = (arc4random() % 30)+1;
            if tmp % 5 == 0
            {
                return true
            }
            else
            {
                return false
            }
        })
        presentSemiViewControllerWithMyOptions(datePicker)
    }
    
    func addTag()
    {
        hideKB()
        if  newTagTextField.text == nil
        {
            return
        }
        if newTagTextField.text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()) == ""
        {
            return
        }
       
        tagList = tagList.arrayByAddingObject(newTagTextField.text)
        
        tagsListView.setTags(tagList as [AnyObject])
        tagsListView.display()
        newTagTextField.text = nil
    }
    
    func hideKB()
    {
        newTagTextField.resignFirstResponder()
    }
    
    func datePickerDonePressed(datePicker: THDatePickerViewController){
        curDate = datePicker.date
        displayDate()
        dismissSemiModalView()
    }
    
    func datePickerCancelPressed(datePicker: THDatePickerViewController){
        dismissSemiModalView()
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cityList?.count ?? 0
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let city = cityList?.objectAtIndex(row) as! NSDictionary
        cityName = city.objectForKey("city_name") as! String
        cityId = city.objectForKey("city_id") as! Int
        locationButton.setTitle (cityName, forState: UIControlState.Normal)
        dismissSemiModalView()
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        let city = cityList?.objectAtIndex(row) as! NSDictionary
        return city.objectForKey("city_name") as! String
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.item == 0
        {
           return tableView.dequeueReusableCellWithIdentifier("publicCell", forIndexPath: indexPath) as! UITableViewCell

        }
        if indexPath.item == 1
        {
            return tableView.dequeueReusableCellWithIdentifier("whiteCell", forIndexPath: indexPath) as! UITableViewCell
            
        }
        if indexPath.item == 2
        {
            return tableView.dequeueReusableCellWithIdentifier("blackCell", forIndexPath: indexPath) as! UITableViewCell
            
        }
        return tableView.dequeueReusableCellWithIdentifier("usersCell", forIndexPath: indexPath) as! UITableViewCell

    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.item != 3
        {
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            if cell!.selected
            {
                cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
            }
            else
            {
                cell!.accessoryType =  UITableViewCellAccessoryType.None
            }
        }

    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.item != 3 && tableView.indexPathForSelectedRow()!.item != 3
        {
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            if cell!.selected
            {
                cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
            }
            else
            {
                cell!.accessoryType =  UITableViewCellAccessoryType.None
            }
        }
        
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
