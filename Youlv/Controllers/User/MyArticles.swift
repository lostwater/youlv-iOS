//
//  MyArticles.swift
//  Youlv
//
//  Created by Lost on 19/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//



class MyArticles:BaseTableViewController{
    
    
     func getDataArray(currentPage: Int, pageSize:Int)
    {
        getArticleList(currentPage, pageSize:pageSize)
    }
    
    
    func getArticleList(currentPage: Int, pageSize:Int)
    {
        DataClient().getArticleList(currentPage, pageSize: pageSize, completion: { (dict, error) -> () in
            self.getArticleListCompleted(dict, error: error)
        })
    }
    
    func getArticleListCompleted(dict:NSDictionary?,error:NSError?)
    {
        let dictData = dict!.objectForKey("data") as! NSDictionary
        let array = dictData.objectForKey("articleList") as? NSArray
        if (array?.count ?? 0) > 0
        {
            dataArray.addObjectsFromArray(array! as Array)
                        dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
            
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setNaviMenu()
        //AddNaviMenuToHome(naviMenuView!, titleButton!, self)
    }
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goArticleDetail"
        {
            let vc = segue.destinationViewController as! ArticleDetailViewController
            let selectedIndex = tableView.indexPathForSelectedRow?.item
            var selectedData = dataArray.objectAtIndex(selectedIndex!) as! NSDictionary
            vc.dataDict = dataArray.objectAtIndex(selectedIndex!) as? NSDictionary
        }
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ArticleCell", forIndexPath: indexPath) as! ArticleTableViewCell
        //cell.displayData(dataArray.objectAtIndex(indexPath.item) as! NSDictionary)
        return cell
        
    }
    
    
    
    
    
    
}
