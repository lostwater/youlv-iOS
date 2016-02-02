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
    
    func easeMobLogin()
    {
        EaseMob.sharedInstance().chatManager.asyncLoginWithUsername(myUserInfo?.objectForKey("huanxin_name") as! String, password: myUserInfo?.objectForKey("huanxin_password") as! String,  completion: { (loginInfo, error) -> Void in
            if error == nil && loginInfo != nil
            {
                NSLog("登陆成功")
            }
            }, onQueue: nil)
    }
    
    func httpPost(pathString : String, parameters : NSDictionary , completion: (NSDictionary?, NSError?)->())
    {
        let manager = AFHTTPSessionManager()
        //manager.responseSerializer = AFHTTPResponseSerializer()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.requestSerializer.setValue(token, forHTTPHeaderField: "token")
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //NSLog(manager.requestSerializer.v)
        
        manager.POST(pathString, parameters: parameters, progress: nil,
            success: { (dataTask, data) -> Void in
                let dict = data as? NSDictionary
                if dict == nil
                {
                    return
                }
                if dict!.objectForKey("detail") != nil
                {
                    let message = (dict!.objectForKey("detail") as! NSArray)[0] as! String
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
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
    
    func httpGet(pathString : String, parameters : NSDictionary?, completion: (NSDictionary?, NSError?)->())
    {
        let manager = AFHTTPSessionManager()
        manager.requestSerializer.setValue(token, forHTTPHeaderField: "token")
        manager.GET(pathString, parameters: parameters, progress: nil,
            success: { (dataTask, data) -> Void in
                let dict = data as? NSDictionary
                if dict == nil
                {
                    return
                }
                if dict!.objectForKey("detail") != nil
                {
                    let message = (dict!.objectForKey("detail") as! NSArray)[0] as! String
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
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
        httpGet(pathString, parameters: nil) { (dict, error) -> () in
            completion(dict, error)
        }
    }
    
    
    func updateMyProfile(avatar : UIImage, name : String, agency : String, location : String, completion: (NSDictionary?, NSError?)->())
    {
        let path = domain + "api/accounts/profile/" + String(myUserInfo?.objectForKey("uid") as! Int) + "/"
        let imageData = UIImageJPEGRepresentation(avatar, 0.1)
        let paras = NSMutableDictionary()
        paras.setValue(name, forKey: "name")
        paras.setValue(agency, forKey: "agency")
        paras.setValue(location, forKey: "location")
        let request = AFHTTPRequestSerializer().multipartFormRequestWithMethod("POST", URLString: path, parameters: (paras as! [String:AnyObject]), constructingBodyWithBlock: { (formData) -> Void in
                formData.appendPartWithFileData(imageData!, name: "avatar", fileName: "avatar.jpg", mimeType: "image/jpeg")
            }, error: nil)
        request.setValue(token, forHTTPHeaderField: "token")

        let manager = AFHTTPSessionManager()
        manager.responseSerializer = AFJSONResponseSerializer()
        let task = manager.uploadTaskWithStreamedRequest(request, progress: nil) { (respones, object, error) -> Void in
            if error == nil
            {
                let dict = object as! NSDictionary
                KVNProgress.showSuccessWithStatus("更新成功")
                completion(dict,error)
            }
            else
            
            {
                KVNProgress.showErrorWithStatus("更新失败")
            }
        }
        
        task.resume()
        //manager.POST(String, parameters: AnyObject?, success: ((NSURLSessionDataTask, AnyObject?) -> Void)?, failure: ((NSURLSessionDataTask?, NSError) -> Void)?)
    }
    
    func sendSMS(phone : String, completion: (NSDictionary?, NSError?)->())
    {
        let path = domain + "api/accounts/send-sms/"
        let paras = NSMutableDictionary()
        paras.setValue(phone, forKey: "phone")
        
        let manager = AFHTTPSessionManager()
        //manager.responseSerializer = AFHTTPResponseSerializer()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        manager.POST(path, parameters: paras, progress: nil,
            success: { (dataTask, data) -> Void in
                let dict = data as? NSDictionary
                if dict == nil
                {
                    return
                }
                if dict!.objectForKey("detail") != nil
                {
                    let message = (dict!.objectForKey("detail") as! NSArray)[0] as! String
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
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

    func register(phone : String, password : String, token : String, completion: (NSDictionary?, NSError?)->())
    {
        let path = domain + "api/accounts/register/"
        let paras = NSMutableDictionary()
        paras.setValue(phone, forKey: "phone")
        paras.setValue(password, forKey: "password")
        paras.setValue(token, forKey: "token")
        
        let manager = AFHTTPSessionManager()
        //manager.responseSerializer = AFHTTPResponseSerializer()
        manager.requestSerializer = AFJSONRequestSerializer()
        manager.requestSerializer.setValue("application/json", forHTTPHeaderField: "Content-Type")
        manager.POST(path, parameters: paras, progress: nil,
            success: { (dataTask, data) -> Void in
                let dict = data as? NSDictionary
                if dict == nil
                {
                    return
                }
                if dict!.objectForKey("detail") != nil
                {
                    let message = (dict!.objectForKey("detail") as! NSArray)[0] as! String
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
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
            self.getUserInfo(dict?.objectForKey("user") as! Int, completion: { (dict, error) -> () in
                myUserInfo = NSMutableDictionary(dictionary: dict!)
                self.easeMobLogin()
            })
        }
    }
    
    func getRecommendedUsers(completion: (NSDictionary?, NSError?)->())
    {
        let path = domain + "api/accounts/recommend/user"
        httpGet(path) { (dict, error) -> () in
        completion(dict, error)
        }
    }

    
    func getTopicList(completion: (NSDictionary?, NSError?)->())
    {
        let path = domain + "api/case/topictype/list"
        httpGet(path) { (dict, error) -> () in
            completion(dict, error)
        }
    }
    
   
    func getMyFollowedUsers(completion: (NSDictionary?, NSError?)->())
    {
        let path = domain + "api/accounts/follower/list/"
        httpGet(path) { (dict, error) -> () in
            completion(dict, error)
        }
    }
    
    func getMyFollowUsers(completion: (NSDictionary?, NSError?)->())
    {
        let path = domain + "api/accounts/follow/list/"
        httpGet(path) { (dict, error) -> () in
            completion(dict, error)
        }
    }
    
    
    func getMyTopicEventList(completion: (NSDictionary?, NSError?)->())
    {
        let path = domain + "api/case/topicevent/list?filter_status=self_all"
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
    
    func getTopicEventList(topicType : Int, completion: (NSDictionary?, NSError?)->())
    {
        let path = domain + "api/case/topicevent/list?topictype_id="+String(topicType)
        httpGet(path) { (dict, error) -> () in
            completion(dict, error)
        }
    }

    
    func getTopicDetail(topicId : Int, completion: (NSDictionary?, NSError?)->())
    {
        let path = domain + "api/case/topicevent/list?topic_id="+String(topicId)
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
    
    func getArticleCommentList(articleId : Int,completion: (NSDictionary?, NSError?)->())
    {
        let path = domain + "api/case/article/comments/" + String(articleId)
        httpGet(path) { (dict, error) -> () in
            completion(dict, error)
        }
    }

    
    func getMyArticleList(completion: (NSDictionary?, NSError?)->())
    {
        let path = domain + "api/case/article/list?filter_status=self_all"
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
    
    func getMyActivityList(completion: (NSDictionary?, NSError?)->())
    {
        let path = domain + "api/case/activity/list?filter_status=self_all"
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
    
    func getMyUploadedCaseList(completion: (NSDictionary?, NSError?)->())
    {
        let path = domain + "api/case/casesource/list?filter_status=self_upload"
        httpGet(path) { (dict, error) -> () in
            completion(dict, error)
        }
    }
    
    func getMyInterestedCaseList(completion: (NSDictionary?, NSError?)->())
    {
        let path = domain + "api/case/casesource/list?filter_status=self_interest"
        httpGet(path) { (dict, error) -> () in
            completion(dict, error)
        }
    }
    
    func getJobList(completion: (NSDictionary?, NSError?)->())
    {
        let path = domain + "api/case/job/list"
        httpGet(path) { (dict, error) -> () in
            completion(dict, error)
        }
    }
    
    func getBookmarkedJobList(completion: (NSDictionary?, NSError?)->())
    {
        let path = domain + "api/case/job/up/list"
        httpGet(path) { (dict, error) -> () in
            completion(dict, error)
        }
    }
    

    
    func getUserInfo(userId : Int, completion: (NSDictionary?, NSError?)->())
    {
        let path = domain + "api/accounts/profile/" + String(userId)
        httpGet(path) { (dict, error) -> () in
            completion(dict, error)
        }
    }
    
    func getUserTopicEvents(userId : Int, completion: (NSDictionary?, NSError?)->())
    {
        let path = domain + "api/case/topicevent/list?filter_user_id" + String(userId)
        httpGet(path) { (dict, error) -> () in
            completion(dict, error)
        }
    }

    
    func postNewCase(paras : NSDictionary, completion: (NSDictionary?, NSError?)->())
    {
        let path = domain + "api/case/casesource/"
        httpPost(path, parameters: paras) { (dict, error) -> () in
            completion(dict, error)}
    }


    func postNewTopic(typeId : Int, text : String, completion: (NSDictionary?, NSError?)->())
    {
        let path = domain + "api/case/topic/"
        let paras = NSMutableDictionary()
        paras.setValue(["topictype_id" : typeId], forKey: "type")
        paras.setValue(text, forKey: "text")
        httpPost(path, parameters: paras) { (dict, error) -> () in
            completion(dict, error)}
    }
    
    func bookMarkJob(jobId : Int, completion: (NSDictionary?, NSError?)->())
    {
        let path = domain + "api/case/job/up/"
        let paras = NSMutableDictionary()
        paras.setValue(jobId, forKey: "job_id")
        httpPost(path, parameters: paras) { (dict, error) -> () in
            completion(dict, error)}
    }


    func commentArticle(articleId: Int, text : String, completion: (NSDictionary?, NSError?)->())
    {
        let path = domain + "api/case/article/comment/"
        let paras = NSMutableDictionary()
        paras.setValue(articleId, forKey: "article_id")
        paras.setValue(text, forKey: "comment")
        httpPost(path, parameters: paras) { (dict, error) -> () in
            completion(dict, error)}
    }
    
    func commentTopic(topicId: Int, text : String, completion: (NSDictionary?, NSError?)->())
    {
        let path = domain + "api/case/topicevent/comment/"
        let paras = NSMutableDictionary()
        paras.setValue(topicId, forKey: "topic_id")
        paras.setValue(text, forKey: "comment")
        httpPost(path, parameters: paras) { (dict, error) -> () in
            completion(dict, error)}
    }
    
    func articleUp(articleId : Int, completion: (NSDictionary?, NSError?)->())
    {
        let path = domain + "api/case/article/up/"
        let paras = NSMutableDictionary()
        paras.setValue(articleId, forKey: "article_id")
        httpPost(path, parameters: paras) { (dict, error) -> () in
            completion(dict, error)}
    }
    
    func eventUp(eventId : Int, completion: (NSDictionary?, NSError?)->())
    {
        let path = domain + "api/case/activity/up/"
        let paras = NSMutableDictionary()
        paras.setValue(eventId, forKey: "activity_id")
        httpPost(path, parameters: paras) { (dict, error) -> () in
            completion(dict, error)}
    }


    func topicGroupUp(topicGroupId : Int, completion: (NSDictionary?, NSError?)->())
    {
        let path = domain + "api/case/topictype/follow/"
        let paras = NSMutableDictionary()
        paras.setValue(["topictype_id" : topicGroupId], forKey: "topictype")
        httpPost(path, parameters: paras) { (dict, error) -> () in
            completion(dict, error)}
    }
    
    func opportunityUp(caseId : Int, completion: (NSDictionary?, NSError?)->())
    {
        let path = domain + "api/case/casesource/interest/"
        let paras = NSMutableDictionary()
        paras.setValue(caseId, forKey: "case_id")
        httpPost(path, parameters: paras) { (dict, error) -> () in
            completion(dict, error)}
    }

    
    func topicEventUp(eventId : Int, completion: (NSDictionary?, NSError?)->())
    {
        let path = domain + "api/case/topicevent/up/"
        let paras = NSMutableDictionary()
        paras.setValue(eventId, forKey: "topicevent_id")
        httpPost(path, parameters: paras) { (dict, error) -> () in
            completion(dict, error)}
    }
    
    func followUser(userId : Int, completion: (NSDictionary?, NSError?)->())
    {
        let path = domain + "api/accounts/follow/\(String(userId))/"
        httpPost(path, parameters: NSDictionary()) { (dict, error) -> () in
            completion(dict, error)}
    }

    func followUser(userIds : NSArray, completion: (NSDictionary?, NSError?)->())
    {
        let users = userIds.componentsJoinedByString(",")
        let path = domain + "api/accounts/follow/\(users)/"
        httpPost(path, parameters: NSDictionary()) { (dict, error) -> () in
            completion(dict, error)}
    }
    
    func followTopicTypes(topicTyps : NSArray, completion: (NSDictionary?, NSError?)->())
    {
        let types = topicTyps.componentsJoinedByString(",")
        let path = domain + "api/case/topictype/follow/\(types)/"
        httpPost(path, parameters: NSDictionary()) { (dict, error) -> () in
            completion(dict, error)}
    }

    
    
}