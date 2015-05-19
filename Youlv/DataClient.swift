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
    
   
    
    func getCityList(currentPage : Int, pageSize:Int, completion: (NSData?, NSError?)->())
    {
        var path = serverUrl + "lawyer/getCityList?"
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
    
    func getTopicDetail(topicId : Int, currentPage : Int, pageSize:Int, completion: (NSData?, NSError?)->())
    {
        var path = serverUrl + "topic/getTopicDetail?"
        path = path + "currentPage=" + String(currentPage)
        path = path + "&pageSize=" + String(pageSize)
        path = path + "&sessionId=" + String(sessionId)
        path = path + "&topicId=" + String(topicId)
        
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
    
    func getEventDetail(eventId : Int, completion: (NSData?, NSError?)->())
    {
        var path = serverUrl + "active/getActiveDetail?"
        path = path + "activeId=" + String(eventId)
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
    
    func getInterviewList(currentPage:Int, pageSize:Int, completion: (NSData?, NSError?)->())
    {
        var path = serverUrl + "microview/getViewList?"
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
    
    
    func getInterviewDetail(interviewId : Int, currentPage : Int, pageSize:Int, completion: (NSData?, NSError?)->())
    {
        var path = serverUrl + "microview/viewDetail?"
        path = path + "currentPage=" + String(currentPage)
        path = path + "&pageSize=" + String(pageSize)
        path = path + "&sessionId=" + String(sessionId)
        path = path + "&microViewId=" + String(interviewId)
        
 
        var session = NSURLSession.sharedSession()
        let url = NSURL(string: path)
        let task = session.dataTaskWithURL(url!, completionHandler: { (data, responese, error) -> Void in
            completion(data, error)
        })
        
        task.resume()
    }
    
    func getJobList(currentPage:Int, pageSize:Int, completion: (NSData?, NSError?)->())
    {
        var path = serverUrl + "position/getPositionList?"
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
    
    func getMarkedJobList(currentPage:Int, pageSize:Int, completion: (NSData?, NSError?)->())
    {
        var path = serverUrl + "position/getStoreList?"
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

    
    func getJobDetail(jobId : Int, completion: (NSData?, NSError?)->())
    {
        var path = serverUrl + "position/positionDetail?"
        path = path + "&sessionId=" + String(sessionId)
        path = path + "&positionId=" + String(jobId)
        
        
        var session = NSURLSession.sharedSession()
        let url = NSURL(string: path)
        let task = session.dataTaskWithURL(url!, completionHandler: { (data, responese, error) -> Void in
            completion(data, error)
        })
        
        task.resume()
    }
    
    func postMarkJob(jobId : Int, completion: (NSData?, NSError?)->())
    {
        var path = serverUrl + "position/positionStore"
        var params = "positionId=" + String(jobId)
        params = params + "&sessionId=" + String(sessionId)
        var session = NSURLSession.sharedSession()
        let url = NSURL(string: path)
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPBody = (params as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPMethod = "POST"
        let task = session.dataTaskWithRequest(request) { ( data, responese, error ) -> Void in
            completion(data, error)
            let dataString = NSString(data: data, encoding: NSUTF8StringEncoding)
            print(dataString)
        }
        task.resume()

    }
    
    func getResearchList(currentPage:Int, pageSize:Int, completion: (NSData?, NSError?)->())
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
    
    func getResearchDetail(voteId : Int, completion: (NSData?, NSError?)->())
    {
        var path = serverUrl + "vote/voteDetail?"
        path = path + "&sessionId=" + String(sessionId)
        path = path + "&voteId=" + String(voteId)
    
        var session = NSURLSession.sharedSession()
        let url = NSURL(string: path)
        let task = session.dataTaskWithURL(url!, completionHandler: { (data, responese, error) -> Void in completion(data, error)
        })
        task.resume()
    }
    
    func postVote(voteId : Int, optionId: Int, completion: (NSData?, NSError?)->())
    {
        var path = serverUrl + "vote/voteChoise"
        var params = "voteId=" + String(voteId)
        params = params + "&optionId=" + String(optionId)
        params = params + "&sessionId=" + String(sessionId)
        var session = NSURLSession.sharedSession()
        let url = NSURL(string: path)
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPBody = (params as NSString).dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPMethod = "POST"
        let task = session.dataTaskWithRequest(request) { ( data, responese, error ) -> Void in
            completion(data, error)
        }
        task.resume()
        
    }
    
    func getMyProfile(completion: (NSData?, NSError?)->())
    {
        var path = serverUrl + "lawyer/getMaterialt?"
        path = path + "&sessionId=" + String(sessionId)
        
        var session = NSURLSession.sharedSession()
        let url = NSURL(string: path)
        let task = session.dataTaskWithURL(url!, completionHandler: { (data, responese, error) -> Void in completion(data, error)
        })
        task.resume()
    }
    
    func getUserProfileWithTopicList(userId: Int, currentPage:Int, pageSize:Int, completion: (NSData?, NSError?)->())

    {
        var path = serverUrl + "lawyer/getLawyerInfo?"
        path = path + "currentPage=" + String(currentPage)
        path = path + "&pageSize=" + String(pageSize)
        path = path + "&lawyerId=" + String(userId)
        path = path + "&sessionId=" + String(sessionId)
        
        var session = NSURLSession.sharedSession()
        let url = NSURL(string: path)
        let task = session.dataTaskWithURL(url!, completionHandler: { (data, responese, error) -> Void in
            completion(data, error)
        })
        
        task.resume()
        
    }
    
    func postOrder(parameters : NSDictionary , completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "order/reportOrder"
        nativePost(path, parameters: parameters, completion: { (data, error) -> () in
            completion(data, error)
        })
    }
    
    func postLogin(parameters : NSDictionary , completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "user/login"
        nativePost(path, parameters: parameters, completion: { (data, error) -> () in
            completion(data, error)
        })
    }
    
    func getGroupList(currentPage:Int, pageSize:Int, completion: (NSData?, NSError?)->())
    {
        var path = serverUrl + "topic/getGroupList?"
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
    
    func getMyPostOpportunities(currentPage:Int, pageSize:Int, completion: (NSData?, NSError?)->())
    {
        var path = serverUrl + "lawyer/getOrderList?"
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
    
    func getMyPostTopics(currentPage:Int, pageSize:Int, completion: (NSData?, NSError?)->())
    {
        var path = serverUrl + "lawyer/getReportTopics?"
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

    func getMyMarkedTopics(currentPage:Int, pageSize:Int, completion: (NSData?, NSError?)->())
    {
        var path = serverUrl + "lawyer/getAttetionTopics?"
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
    
    func getMyRepliedTopics(currentPage:Int, pageSize:Int, completion: (NSData?, NSError?)->())
    {
        var path = serverUrl + "lawyer/getReplyTopics?"
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
    
    func getMyEventsList(currentPage:Int, pageSize:Int, completion: (NSData?, NSError?)->())
    {
        var path = serverUrl + "lawyer/getStoreActives?"
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
    
    func getHotTopicGroup(currentPage:Int, pageSize:Int, completion: (NSData?, NSError?)->())
    {
        var path = serverUrl + "topic/findHotTopicGroup?"
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
    
    func getAds(completion: (NSData?, NSError?)->())
    {
        var path = serverUrl + "topic/findAdColumn?"

        path = path + "&sessionId=" + String(sessionId)
        
        var session = NSURLSession.sharedSession()
        let url = NSURL(string: path)
        let task = session.dataTaskWithURL(url!, completionHandler: { (data, responese, error) -> Void in
            completion(data, error)
        })
        
        task.resume()
    }

    
    
    func serialzeJsonRequest(pathString : String, parameters : NSDictionary) -> NSMutableURLRequest
    {
        let errorPointer = NSErrorPointer()
        let manager = AFHTTPRequestOperationManager()
        return  AFHTTPRequestSerializer().requestWithMethod("POST", URLString: pathString, parameters: parameters, error: errorPointer)
    }
    
    
    
    func jsonPost(pathString : String, parameters : NSDictionary , completion: (NSDictionary?, NSError?)->())
    {
        var manager = AFHTTPRequestOperationManager()
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.POST(pathString, parameters: parameters, success: { (requestOperation, data) -> Void in
            completion(data as? NSDictionary, nil)
        })
            { (requestOperation, error) -> Void in
                completion(nil, error as NSError)
                
        }
    }
    
    func httpPostUsingAF(pathString : String, parameters : NSDictionary , completion: (NSDictionary?, NSError?)->())
    {
        var manager = AFHTTPRequestOperationManager()
        manager.requestSerializer = AFHTTPRequestSerializer()
        manager.responseSerializer = AFJSONResponseSerializer()
        manager.POST(pathString, parameters: parameters, success: { (requestOperation, data) -> Void in
        
            completion(data as? NSDictionary, nil)
            })
            { (requestOperation, error) -> Void in
                completion(nil, error as NSError)
        }
    }
    
    
    func nativePost(pathString : String, parameters : NSDictionary, completion: (NSDictionary?, NSError?)->())
    {
        var session = NSURLSession.sharedSession()
        let request = serialzeJsonRequest(pathString,parameters: parameters)
        print(NSString(data: request.HTTPBody!, encoding: NSUTF8StringEncoding))
        let task = session.dataTaskWithRequest(request) { ( data, responese, error ) -> Void in
            let ds = NSString(data: data, encoding: NSUTF8StringEncoding)
            print(ds)
            let errorPointer = NSErrorPointer()
            let dict = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves, error: errorPointer) as! NSDictionary
            completion(dict, error)
        }
        task.resume()
        
    }



    
}