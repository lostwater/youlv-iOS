//
//  ResearchDetailTableViewController.swift
//  Youlv
//
//  Created by Lost on 17/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

class ResearchDetailTableViewController: UITableViewController {

    @IBOutlet var pieChart: PCPieChart!
    @IBOutlet var votedCount: UILabel!
    
    var researchId : Int?
    var dataDict : NSDictionary?
    var optionsContentArray = NSMutableArray()
    var optionsResult : NSDictionary?
    var content : String?
    
    
    
    
    func displayData()
    {
        let voteSum = dataDict!.objectForKey("vote_sum") as! Int
        votedCount.text = "共" + String(voteSum) + "人参与投票"
        pieChart.diameter = Int32(pieChart.frame.size.height - CGFloat(16))
        let components = NSMutableArray()
        if voteSum == 0
        {
            let  component = PCPieComponent()
            component.title = "无人投票"
             component.value = 1
            component.colour = UIColor.whiteColor()
            components.addObject(component)
        }
        else
        {
            let keys = optionsResult?.objectForKey("optionID") as! NSArray
        let values = optionsResult?.objectForKey("votesCount") as! NSArray
        
        for var i = 0; i < optionsResult!.count; i++ {
  
            let title = (optionsContentArray.objectAtIndex(i) as! NSDictionary).objectForKey("option_content") as! String
            //PCPieComponent(title: , value: <#Float#>)
            let component = PCPieComponent()
            component.title = title
            component.value = values.objectAtIndex(i) as! Float
            
            if (i==0)
            {
                component.colour = UIColor.whiteColor()
            }
            else if (i==1)
            {
                component.colour = UIColor.orangeColor()
            }
            else if (i==2)
            {
                component.colour = UIColor.cyanColor()
            }
            components.addObject(component)
        }
        }
        pieChart.components = components
        pieChart.setNeedsDisplay()

    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pieChart.titleFont = UIFont(name:"HelveticaNeue", size:16)
        //pieChart. = UIFont(Name:"HelveticaNeue", size:16)
        pieChart.showArrow = false
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionsContentArray.count + 2
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let index = indexPath.item
        if (index == 0)
        {
            return tableView.dequeueReusableCellWithIdentifier("OptionHeadCell", forIndexPath: indexPath) 
        }
        else if(index == 1)
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("OptionCell", forIndexPath: indexPath) 
            cell.textLabel?.text = content
            return cell

        }
        else
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("OptionCell", forIndexPath: indexPath) 
            cell.textLabel?.text = (optionsContentArray.objectAtIndex(index - 2) as! NSDictionary).objectForKey("option_content") as? String
            return cell
        }

    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
