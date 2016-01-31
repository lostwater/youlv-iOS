//
//  MyArticles.swift
//  Youlv
//
//  Created by Lost on 19/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//



class MyArticles:BaseTableViewController{
    
    override func httpGet() {
        super.httpGet()
        httpClient.getArticleList { (dict, error) -> () in
            self.httpGetCompleted(dict, error: error)
        }
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.destinationViewController.isKindOfClass(ArticleDetailViewController)
        {
            let vc = segue.destinationViewController as! ArticleDetailViewController
            let selectedIndex = tableView.indexPathForSelectedRow?.item
            //var selectedData = dataArray.objectAtIndex(selectedIndex!) as! NSDictionary
            vc.dataDict = dataArray.objectAtIndex(selectedIndex!) as? NSDictionary
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ArticleCell", forIndexPath: indexPath) as! ArticleTableViewCell
        cell.configure(dataArray.objectAtIndex(indexPath.item) as! NSDictionary)
        return cell
        
    }
    
    
}
