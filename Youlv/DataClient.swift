//
//  DataClient.swift
//  Youlv
//
//  Created by Lost on 07/05/2015.
//  Copyright (c) 2015 Ramy. All rights reserved.
//

import Foundation

class DataClient
{

    let serverUrl = "http://123.57.252.2/"
    var sessionId = "76153026bac352110d4cd6a4dbb295d6"
    func getOrderList(currentPage : Int, pageSize:Int, completion: (NSData?, NSError?)->())
    {
        var path = serverUrl + "order/getOrderList?"
        path = path + "currentPage=" + String(currentPage)
        path = path + "&pageSize=" + String(pageSize)
        path = path + "&sessionId=" + String(sessionId)
       
        var session = NSURLSession.sharedSession()
        let url = NSURL(string: path)
        let task = session.dataTaskWithURL(url!, completionHandler: { (data, responese, error) -> Void in
            completion(data, error)
        })
        
        task.resume()
        
        }
    
    func getDiscussList(currentPage : Int, pageSize:Int, completion: (NSData?, NSError?)->())
    {
        var path = serverUrl + "discuss/getDiscussList?"
        path = path + "currentPage=" + String(currentPage)
        path = path + "&pageSize=" + String(pageSize)
        path = path + "&sessionId=" + String(sessionId)
        
        var session = NSURLSession.sharedSession()
        let url = NSURL(string: path)
        let task = session.dataTaskWithURL(url!, completionHandler: { (data, responese, error) -> Void in
            completion(data, error)
        })
        
        task.resume()
        
    }
    
    func getVoteList(currentPage : Int, pageSize:Int, completion: (NSData?, NSError?)->())
    {
        var path = serverUrl + "vote/getVoteList?"
        path = path + "currentPage=" + String(currentPage)
        path = path + "&pageSize=" + String(pageSize)
        path = path + "&sessionId=" + String(sessionId)
        
        var session = NSURLSession.sharedSession()
        let url = NSURL(string: path)
        let task = session.dataTaskWithURL(url!, completionHandler: { (data, responese, error) -> Void in
            completion(data, error)
        })
        
        task.resume()
        
    }
    
    func getEventList(currentPage:Int, pageSize:Int, completion: (NSData?, NSError?)->())
    {
        var path = serverUrl + "active/getActiveList?"
        path = path + "currentPage=" + String(currentPage)
        path = path + "&pageSize=" + String(pageSize)
        path = path + "&sessionId=" + String(sessionId)
        
        var session = NSURLSession.sharedSession()
        let url = NSURL(string: path)
        let task = session.dataTaskWithURL(url!, completionHandler: { (data, responese, error) -> Void in
            completion(data, error)
        })
        
        task.resume()
        
    }

    func getArticleList(currentPage:Int, pageSize:Int, completion: (NSData?, NSError?)->())
    {
        var path = serverUrl + "article/articleList?"
        path = path + "currentPage=" + String(currentPage)
        path = path + "&pageSize=" + String(pageSize)
        path = path + "&sessionId=" + String(sessionId)
    
        var session = NSURLSession.sharedSession()
        let url = NSURL(string: path)
        let task = session.dataTaskWithURL(url!, completionHandler: { (data, responese, error) -> Void in
            completion(data, error)
        })
        
        task.resume()
        
    }

    
}