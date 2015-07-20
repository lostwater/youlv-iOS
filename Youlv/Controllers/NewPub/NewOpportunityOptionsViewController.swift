//
//  NewOpportunityOptionsViewController.swift
//  Youlv
//
//  Created by Lost on 17/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class NewOpportunityOptionsViewController: UIViewController, THDatePickerDelegate, UIPickerViewDataSource,UIPickerViewDelegate,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var privilegeTable: UITableView!
    @IBAction func opportunityBWListDidSet(segue: UIStoryboardSegue)
    {
        let contactsVC = segue.sourceViewController as! GeneralContactsTableViewController
        if privilege == 1
        {
            whiteList = contactsVC.selectedContactIds
        }
        if privilege == 2
        {
            blackList = contactsVC.selectedContactIds
        }
        headUrls = contactsVC.selectedContactHeads
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.privilegeTable.reloadData()
        })
    }
    
    @IBAction func opportunityBWListDidCancel(segue: UIStoryboardSegue)
    {
        privilege = 0
    }
    
    
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
    
    var _privilege = 0
    var privilege : Int{
        get{return _privilege}
        set(value)
        {
            if _privilege != value
            {
                _privilege = value
                privilegeTable.reloadData()
            }
        }
    }
    
    var tagList = NSArray()
    var blackList = NSArray()
    var whiteList = NSArray()
    var deadDate = NSDate()
    var formatter = NSDateFormatter()
    
    var headUrls = NSArray()
    
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
            vc.deadDate = deadDate
            vc.thetitle = thetitle
            vc.content = content
            vc.privilege = privilege
        }
        if segue.identifier == "setWhiteList" || segue.identifier == "setBlackList"
        {
            var vc = segue.destinationViewController as! GeneralContactsTableViewController
            vc.isSelectable  = true
        }
    }
    
    
    func displayDate()
    {
        deadlineDataButton.setTitle(formatter.stringFromDate(deadDate), forState: UIControlState.Normal)
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
        datePicker?.date = deadDate;
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
        deadDate = datePicker.date
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
        if privilege == 0
        {
            return 3
        }
        else
        {
            return 4
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if privilege == 0
        {
            if indexPath.item == 0
            {
                let cell = tableView.dequeueReusableCellWithIdentifier("publicCell", forIndexPath: indexPath) as! UITableViewCell
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                cell.tag = 0
                return cell
                
            }
            if indexPath.item == 1
            {
                let cell = tableView.dequeueReusableCellWithIdentifier("whiteCell", forIndexPath: indexPath) as! UITableViewCell
                cell.accessoryType = UITableViewCellAccessoryType.None
                cell.tag = 1
                return cell
                
            }
            if indexPath.item == 2
            {
                let cell = tableView.dequeueReusableCellWithIdentifier("blackCell", forIndexPath: indexPath) as! UITableViewCell
                cell.accessoryType = UITableViewCellAccessoryType.None
                cell.tag = 2
                return cell
            }
        }
        
        if privilege == 1
        {
            if indexPath.item == 0
            {
                let cell = tableView.dequeueReusableCellWithIdentifier("publicCell", forIndexPath: indexPath) as! UITableViewCell
                cell.accessoryType = UITableViewCellAccessoryType.None
                //cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                cell.tag = 0
                return cell
                
            }
            if indexPath.item == 1
            {
                let cell = tableView.dequeueReusableCellWithIdentifier("whiteCell", forIndexPath: indexPath) as! UITableViewCell
                cell.tag = 1
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                return cell
                
            }
            if indexPath.item == 2
            {
                let cell = tableView.dequeueReusableCellWithIdentifier("usersCell", forIndexPath: indexPath) as!
                UserImagesTableViewCell
                cell.imagesView.setImages(headUrls)
                cell.tag = 9
                return cell
            }
            if indexPath.item == 3
            {
                let cell = tableView.dequeueReusableCellWithIdentifier("blackCell", forIndexPath: indexPath) as! UITableViewCell
                cell.tag = 2
                cell.accessoryType = UITableViewCellAccessoryType.None
                return cell
            }
            
            
            
        }
        if privilege == 2
        {
            if indexPath.item == 0
            {
                let cell = tableView.dequeueReusableCellWithIdentifier("publicCell", forIndexPath: indexPath) as! UITableViewCell
                //cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                cell.tag = 0
                cell.accessoryType = UITableViewCellAccessoryType.None
                return cell
                
            }
            if indexPath.item == 1
            {
                let cell = tableView.dequeueReusableCellWithIdentifier("whiteCell", forIndexPath: indexPath) as! UITableViewCell
                cell.tag = 1
                cell.accessoryType = UITableViewCellAccessoryType.None
                return cell
                
            }
            
            if indexPath.item == 2
            {
                let cell = tableView.dequeueReusableCellWithIdentifier("blackCell", forIndexPath: indexPath) as! UITableViewCell
                cell.tag = 2
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                return cell
                
            }
            if indexPath.item == 3
            {
                let cell = tableView.dequeueReusableCellWithIdentifier("usersCell", forIndexPath: indexPath) as!
                UserImagesTableViewCell
                cell.imagesView.setImages(headUrls)
                cell.tag = 9
                return cell
            }
        }
       return UITableViewCell()

    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        if cell!.tag != 9
        {
            privilege = cell!.tag
            tableView.reloadData()
//            for c in tableView.visibleCells()
//            {
//                if (c as! UITableViewCell).tag != 9
//                {
//                    (c as! UITableViewCell).accessoryType = UITableViewCellAccessoryType.None
//                }
//            }
//            cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
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
