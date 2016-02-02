//
//  HomeSearchTableViewController.swift
//  Youlv
//
//  Created by Lost on 25/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import UIKit

enum SearchType : Int
{
    case Discuss = 0
    case Article = 1
    case Event = 2
    case Opportunity = 3
 
}



class HomeSearchTableViewController: UITableViewController {

    
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet var tableVIew: UITableView!
    @IBOutlet weak var tagsView: DWTagList!
    
    @IBAction func doSearchClicked(sender: AnyObject) {
        currentPage = 1
        //search(currentPage)
    }
    
    var searchType = SearchType.Discuss
    var cellDataArray : NSMutableArray?
    var currentPage = 1

    let opportunitiesVC = UIStoryboard(name:"Home",bundle:nil).instantiateViewControllerWithIdentifier("OpportunitiesVC") as! OpportunitiesTableViewController
    let discussesVC = UIStoryboard(name:"Home",bundle:nil).instantiateViewControllerWithIdentifier("DiscussesVC") as! DiscussTableViewController
    let eventsVC = UIStoryboard(name:"Home",bundle:nil).instantiateViewControllerWithIdentifier("EventsVC") as! EventsTableViewController
    let articlesVC = UIStoryboard(name:"Home",bundle:nil).instantiateViewControllerWithIdentifier("ArticlesVC") as! ArticlesTableViewController
    
    var proxyTableViewController : UITableViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //showTags()
        //tagsView.setTags(["test1","test2"])
        //tagsView.display()
        
        //self.navigationItem.titleView = SearchBar
    }
    
//    func search(page : Int)
//    {
//        let searchTitle = searchText.text
//        if searchType == SearchType.Discuss
//        {
//            DataClient().searchDiscuss(searchTitle!, currentPage: currentPage, pageSize: 10, completion: { (dict, error) -> () in
//                self.searchCompleted(dict,error: error)
//            })
//        }
//        if searchType == SearchType.Opportunity
//        {
//            DataClient().searchOrders(searchTitle!, currentPage: currentPage, pageSize: 10, completion: { (dict, error) -> () in
//                self.searchCompleted(dict,error: error)
//            })
//        }
//        if searchType == SearchType.Event
//        {
//            DataClient().searchActive(searchTitle!, currentPage: currentPage, pageSize: 10, completion: { (dict, error) -> () in
//                self.searchCompleted(dict,error: error)
//            })
//        }
//        if searchType == SearchType.Article
//        {
//            DataClient().searchArticle(searchTitle!, currentPage: currentPage, pageSize: 10, completion: { (dict, error) -> () in
//                self.searchCompleted(dict,error: error)
//            })
//        }
//
//    }
    
    func searchCompleted(dict:NSDictionary?,error:NSError?)
    {
        
        let dictData = dict!.objectForKey("data") as! NSDictionary
        if searchType == SearchType.Discuss
        {
            cellDataArray = dictData.objectForKey("discuessList") as? NSMutableArray
            discussesVC.dataArray = cellDataArray ?? NSMutableArray()
            proxyTableViewController = discussesVC
        }
        if searchType == SearchType.Opportunity
        {
            cellDataArray = dictData.objectForKey("orderList") as? NSMutableArray
            opportunitiesVC.dataArray = cellDataArray!
            proxyTableViewController = opportunitiesVC
        }
        if searchType == SearchType.Event
        {
            cellDataArray = dictData.objectForKey("activeList") as? NSMutableArray
            eventsVC.dataArray = cellDataArray!
            proxyTableViewController = eventsVC
        }
        if searchType == SearchType.Article
        {
            cellDataArray = dictData.objectForKey("articleList") as? NSMutableArray
            articlesVC.dataArray = cellDataArray!
            proxyTableViewController = articlesVC
        }
                dispatch_sync(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
        
    }
    


    
    func showTags()
    {
        tagsView.hidden = false
        tagsView.frame = self.view.frame
    }
    
    func hideTags()
    {
        tagsView.hidden = true
        tagsView.frame = CGRectMake(0,0,0,0)
        //HeaderView.frame = SearchBar.frame
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goRepliedDiscussDetail" || segue.identifier == "goPostedDiscussDetail"
        {
            let discussDetail = segue.destinationViewController as! DiscussDetailViewController
            let selectedIndex = tableView.indexPathForSelectedRow?.item
            let dataDict = cellDataArray!.objectAtIndex(selectedIndex!) as? NSDictionary
            
            discussDetail.mainEventDict = dataDict
            discussDetail.topicId = dataDict?.objectForKey("topic_id") as? Int
            discussDetail.isFromMyTopic = false
        }
        if segue.identifier == "goEventDetail"
        {
            let eventDetail = segue.destinationViewController as! EventDetailViewController
            let selectedIndex = tableView.indexPathForSelectedRow?.item
            //var selectedData = cellDataArray!.objectAtIndex(selectedIndex!) as! NSDictionary
            eventDetail.eventId = Int((cellDataArray!.objectAtIndex(selectedIndex!).objectForKey("activeId") as? String)!)
        }
        if segue.identifier == "goOpportunityDetail"
        {
            let vc = segue.destinationViewController as! OpportunityDetailViewController
            let selectedIndex = tableView.indexPathForSelectedRow?.item
            vc.dataDict = cellDataArray!.objectAtIndex(selectedIndex!) as? NSDictionary
            vc.opportunityId = (cellDataArray!.objectAtIndex(selectedIndex!) as! NSDictionary).objectForKey("order_id") as! Int
        }
        if segue.identifier == "goArticleDetail"
        {
            let vc = segue.destinationViewController as! ArticleDetailViewController
            let selectedIndex = tableView.indexPathForSelectedRow?.item
            //var selectedData = cellDataArray!.objectAtIndex(selectedIndex!) as! NSDictionary
            vc.dataDict = cellDataArray!.objectAtIndex(selectedIndex!) as? NSDictionary
        }
    }
    
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        let number = opportunitiesVC.numberOfSectionsInTableView(tableView)
       return proxyTableViewController?.numberOfSectionsInTableView(tableView) ?? 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let number = opportunitiesVC.tableView(tableView, numberOfRowsInSection:section)

        return proxyTableViewController?.tableView(tableView, numberOfRowsInSection:section) ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return proxyTableViewController!.tableView(tableView, cellForRowAtIndexPath:indexPath)
    }
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return proxyTableViewController!.tableView(tableView, heightForRowAtIndexPath:indexPath)
    }


}
