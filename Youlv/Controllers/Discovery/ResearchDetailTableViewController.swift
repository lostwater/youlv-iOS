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
    var optionsContentArray : NSArray?
    var optionsResult : NSDictionary?
    var content : String?
    
    
    let client = DataClient()
    func getResearchDetail()
    {
        client.getResearchDetail(researchId!, completion: { (dict, error) -> () in
            self.getResearchDetailCompleted(dict, error: error)
        })
    }
    
    func getResearchDetailCompleted(dict:NSDictionary?,error:NSError?)
    {
 
        dataDict = dict!.objectForKey("data") as? NSDictionary
        optionsResult = dataDict!.objectForKey("vote_result") as? NSDictionary
        dispatch_sync(dispatch_get_main_queue(), { () -> Void in
          self.displayData()
        })
        
    }
    
    func displayData()
    {
        votedCount.text = String(dataDict!.objectForKey("vote_sum") as! Int)
        pieChart.diameter = Int32(pieChart.frame.size.height - CGFloat(16))
        let keys = NSArray(array: optionsResult!.allKeys)
        let values = NSArray(array: optionsResult!.allValues)
        var components = NSMutableArray()
        for var i = 0; i < optionsResult!.count; i++ {
  
            let title = (optionsContentArray?.objectAtIndex(i) as! NSDictionary).objectForKey("option_content") as! String
            //PCPieComponent(title: <#String!#>, value: <#Float#>)
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
        pieChart.components = components
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getResearchDetail()
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
        return optionsContentArray!.count + 2
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let index = indexPath.item
        if (index == 0)
        {
            return tableView.dequeueReusableCellWithIdentifier("OptionHeadCell", forIndexPath: indexPath) as! UITableViewCell
        }
        else if(index == 1)
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("OptionCell", forIndexPath: indexPath) as! UITableViewCell
            cell.textLabel?.text = content
            return cell

        }
        else
        {
            let cell = tableView.dequeueReusableCellWithIdentifier("OptionCell", forIndexPath: indexPath) as! UITableViewCell
            cell.textLabel?.text = (optionsContentArray?.objectAtIndex(index - 2) as! NSDictionary).objectForKey("option_content") as? String
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
