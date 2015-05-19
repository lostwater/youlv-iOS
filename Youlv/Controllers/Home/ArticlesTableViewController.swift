//
//  ReadingsTableViewController.swift
//  Youlv
//
//  Created by Lost on 27/04/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//
import UIKit

class ArticlesTableViewController: UITableViewController,NaviBarMenu {

    
    var articlesArray : NSArray?
    let client = DataClient()
    var currentPage = 1
    
    func getArticleList(currentPage: Int, pageSize:Int)
    {
        client.getArticleList(currentPage, pageSize: pageSize, completion: { (data, error) -> () in
            self.getArticleListCompleted(data, error: error)
        })
    }
    
    func getArticleListCompleted(data:NSData?,error:NSError?)
    {
        if error != nil
        {
            return
        }
        let errorPointer = NSErrorPointer()
        let ds = NSString(data: data!, encoding: NSUTF8StringEncoding) as! String
        print(ds)
        NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves, error: errorPointer)
        print(errorPointer.debugDescription)
        let dict = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves, error: errorPointer) as! NSDictionary
        
        let dictData = dict.objectForKey("data") as! NSDictionary
        articlesArray = (dictData.objectForKey("articleList") as? NSArray)!
        dispatch_sync(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.navigationItem.title = "文章"
        //setNaviMenu()
        //AddNaviMenuToHome(naviMenuView!, titleButton!, self)
        getArticleList(currentPage,pageSize: 10)
    }
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goArticleDetail"
        {
            let vc = segue.destinationViewController as! ArticleDetailViewController
            let selectedIndex = tableView.indexPathForSelectedRow()?.item
            var selectedData = articlesArray!.objectAtIndex(selectedIndex!) as! NSDictionary
            vc.articleId = articlesArray!.objectAtIndex(selectedIndex!).objectForKey("articleId") as? Int
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return articlesArray?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ArticleCell", forIndexPath: indexPath) as! ArticleTableViewCell
        cell.displayData(articlesArray!.objectAtIndex(indexPath.item) as! NSDictionary)
        return cell
        
    }
    
  

    
    let menuWidth : CGFloat = 180
    let menuHeight : CGFloat = 134
    
    var naviMenuView : UIView?
    var selectedTitle : String?
    var titleButton : UIButton?
    
    @IBOutlet var _naviMenuView: UIView!
    @IBOutlet var _titleButton: UIButton!
    
    @IBOutlet weak var menuButton0: UIButton!
    @IBOutlet weak var menuButton1: UIButton!
    @IBOutlet weak var menuButton2: UIButton!
    
    
    @IBAction func menuButtonClicked(sender: AnyObject) {
        setMenuTextAndHide(sender as! UIButton)
    }
    
    
    @IBAction func titleButtonClicked(sender: AnyObject) {
        showMenu(_naviMenuView)
    }
    
    
    
    func setMenuTextAndHide(selectedButton : UIButton)
    {
        menuButton0.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        menuButton1.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        menuButton2.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        selectedButton.setTitleColor(appBlueColor, forState: UIControlState.Normal)
        selectedTitle = selectedButton.titleForState(UIControlState.Normal)
        _titleButton.setTitle(selectedTitle, forState: UIControlState.Normal)
        setButtonIconToRight(_titleButton)
        _naviMenuView.hidden = true
    }
    
    
    func setNaviMenu()
    {
        setMenuLoc(_naviMenuView, view, menuWidth, menuHeight)
        
        naviMenuView = _naviMenuView
        selectedTitle = menuButton0.titleForState(UIControlState.Normal)
        setMenuTextAndHide(menuButton0)
        
        titleButton = _titleButton
        setButtonIconToRight(titleButton!)
        titleButton?.setTitle(selectedTitle , forState: UIControlState.Normal)
        
    }

}
