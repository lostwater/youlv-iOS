//
//  DataManager.swift
//  Youlv
//
//  Created by Lost on 08/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import Foundation

class DataManager
{
    var orderList: NSArray?
    
    let client = DataClient()
    func getOrderList(currentPage: Int, pageSize:Int)
    {
        client.getOrderList(currentPage, pageSize: pageSize, completion: { (data, error) -> () in
            self.getOrderListCompleted(data, error: error)
        })
    }
    
    func getOrderListCompleted(data:NSData?,error:NSError?)
    {
        let errorPointer = NSErrorPointer()
        let dict = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves, error: errorPointer) as! NSDictionary
        
        let dictData = dict.objectForKey("data") as! NSDictionary
        let dictOrders = dictData.objectForKey("orderList") as! NSArray
        let t1 = dictOrders.objectAtIndex(0).objectForKey("order_title") as! String
        
    }
    
}