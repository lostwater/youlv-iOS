//
//  HTTPClient.swift
//  Youlv
//
//  Created by Lost on 23/01/2016.
//  Copyright © 2016 com.RamyTech. All rights reserved.
//

import Foundation

class HTTPClient{
    var domain = "http://123.57.252.2:8000/"
    var token = ""
    
    func httpPost(pathString : String, parameters : NSDictionary , completion: (NSDictionary?, NSError?)->())
    {
        let manager = AFHTTPSessionManager()
        //manager.responseSerializer = AFHTTPResponseSerializer()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.POST(pathString, parameters: parameters, progress: nil,
            success: { (dataTask, data) -> Void in
                let dict = data as? NSDictionary
                if dict == nil
                {
                    return
                }
                if dict!.objectForKey("detail") != nil
                {
                    let message = dict!.objectForKey("detail") as! String
                    dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                        KVNProgress.showErrorWithStatus((message))
                    })
                    return
                }
                completion(dict, nil)
            },
            failure:
                { (dataTask, error) -> Void in
                    NSLog(error.localizedDescription)
            }
        )

    }
    
    func httpGet(pathString : String, parameters : NSDictionary , completion: (NSDictionary?, NSError?)->())
    {
        let manager = AFHTTPSessionManager()
        manager.GET(pathString, parameters: parameters, progress: nil,
            success: { (dataTask, data) -> Void in
                let dict = data as? NSDictionary
                if dict == nil
                {
                    return
                }
                if dict!.objectForKey("detail") != nil
                {
                    let message = dict!.objectForKey("detail") as! String
                    dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                        KVNProgress.showErrorWithStatus((message))
                    })
                    return
                }
                completion(dict, nil)
            },
            failure:
            { (dataTask, error) -> Void in
                NSLog(error.localizedDescription)
            }
        )
    }
    
    func httpGet(pathString : String, completion: (NSDictionary?, NSError?)->())
    {
        let paras = NSDictionary(dictionary: ["token":token])
        let manager = AFHTTPSessionManager()
        manager.GET(pathString, parameters: paras, progress: nil,
            success: { (dataTask, data) -> Void in
                let dict = data as? NSDictionary
                if dict == nil
                {
                    return
                }
                if dict!.objectForKey("detail") != nil
                {
                    let message = dict!.objectForKey("detail") as! String
                    dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                        KVNProgress.showErrorWithStatus((message))
                    })
                    return
                }
                completion(dict, nil)
            },
            failure:
            { (dataTask, error) -> Void in
                NSLog(error.localizedDescription)
            }
        )
    }
    
    func login(phone : String, password : String, completion: (NSDictionary?, NSError?)->())
    {
        let path = domain + "api/accounts/login/"
        let paras = NSMutableDictionary()
        paras.setValue(phone, forKey: "phone")
        paras.setValue(password, forKey: "password")
        
        httpPost(path, parameters: paras) { (dict, error) -> () in
            completion(dict, error)
            self.token = dict?.objectForKey("token") as! String
        }
    }
    
    
    func getTopicList(completion: (NSDictionary?, NSError?)->())
    {
        let path = domain + "api/case/topictype/list"
        httpGet(path) { (dict, error) -> () in
            completion(dict, error)
        }
    }
    
    
    func getTopicEventList(completion: (NSDictionary?, NSError?)->())
    {
        let path = domain + "api/case/topicevent/list"
        httpGet(path) { (dict, error) -> () in
            completion(dict, error)
        }
    }
    
    
    func getArticleList(completion: (NSDictionary?, NSError?)->())
    {
        let path = domain + "api/case/article/list"
        httpGet(path) { (dict, error) -> () in
            completion(dict, error)
        }
    }
    
    func getActivityList(completion: (NSDictionary?, NSError?)->())
    {
        let path = domain + "api/case/activity/list"
        httpGet(path) { (dict, error) -> () in
            completion(dict, error)
        }
    }
    
    func getCaseList(completion: (NSDictionary?, NSError?)->())
    {
        getCaseList(0){ (dict, error) -> () in
            completion(dict, error)}
    }
    
    func getCaseList(type : Int, completion: (NSDictionary?, NSError?)->())
    {
        let path = domain + "api/case/casesource/list?type=" + String(type)
        httpGet(path) { (dict, error) -> () in
            completion(dict, error)
        }
    }
    


    
    
    
}