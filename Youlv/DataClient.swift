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
    
    
    func getRecommendedTopics(currentPage : Int, pageSize:Int, completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "topic/findHotTopics?"
        path = path + "currentPage=" + String(currentPage)
        path = path + "&pageSize=" + String(pageSize)
        path = path + "&sessionId=" + String(sessionId)
        
        nativeGet(path, completion: { (dict, error) -> () in
            completion(dict,error)
        })
        
    }
    
    
    func getRecommendedUsers(currentPage : Int, pageSize:Int, completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "lawyer/findHotLawyers?"
        path = path + "currentPage=" + String(currentPage)
        path = path + "&pageSize=" + String(pageSize)
        path = path + "&sessionId=" + String(sessionId)
        
        nativeGet(path, completion: { (dict, error) -> () in
            completion(dict,error)
        })
        
        
    }
    
    
    
    func getCityList(currentPage : Int, pageSize:Int, completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "lawyer/getCityList?"
        path = path + "currentPage=" + String(currentPage)
        path = path + "&pageSize=" + String(pageSize)
        path = path + "&sessionId=" + String(sessionId)
        
        nativeGet(path, completion: { (dict, error) -> Void in
            completion(dict, error)
        })
        
    }
    
    
    func getOrderList(currentPage : Int, pageSize:Int, completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "order/getOrderList?"
        path = path + "currentPage=" + String(currentPage)
        path = path + "&pageSize=" + String(pageSize)
        path = path + "&sessionId=" + String(sessionId)
        
        nativeGet(path, completion: { (dict, error) -> Void in
            completion(dict, error)
        })
        
    }
    
    
    func getOrderDetail(orderId : Int, completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "order/orderDetail?"
        path = path + "&sessionId=" + String(sessionId)
        path = path + "&orderId=" + String(orderId)
        
        nativeGet(path, completion: { (dict, error) -> Void in
            completion(dict, error)
        })
        
    }
    
    func getDiscussList(currentPage : Int, pageSize:Int, completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "discuss/getDiscussList?"
        path = path + "currentPage=" + String(currentPage)
        path = path + "&pageSize=" + String(pageSize)
        path = path + "&sessionId=" + String(sessionId)
        
        
        nativeGet(path, completion: { (dict, error) -> Void in
            completion(dict, error)
        })
        
    }
    
    func getTopicDetail(topicId : Int, completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "topic/getTopicDetail?"
        path = path + "&sessionId=" + String(sessionId)
        path = path + "&topicId=" + String(topicId)
        
        nativeGet(path, completion: { (dict, error) -> Void in
            completion(dict, error)
        })
    }
    
    func getTopicDetail(topicId : Int, currentPage : Int, pageSize:Int, completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "topic/getTopicDetail?"
        path = path + "currentPage=" + String(currentPage)
        path = path + "&pageSize=" + String(pageSize)
        path = path + "&sessionId=" + String(sessionId)
        path = path + "&topicId=" + String(topicId)
        
        nativeGet(path, completion: { (dict, error) -> Void in
            completion(dict, error)
        })
    }
    
    func getVoteList(currentPage : Int, pageSize:Int, completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "vote/getVoteList?"
        path = path + "currentPage=" + String(currentPage)
        path = path + "&pageSize=" + String(pageSize)
        path = path + "&sessionId=" + String(sessionId)
        
        nativeGet(path, completion: { (dict, error) -> Void in
            completion(dict, error)
        })
        
    }
    
    func getEventList(currentPage:Int, pageSize:Int,completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "active/getActiveList?"
        path = path + "currentPage=" + String(currentPage)
        path = path + "&pageSize=" + String(pageSize)
        path = path + "&sessionId=" + String(sessionId)
        
        nativeGet(path, completion: { (dict, error) -> Void in
            completion(dict, error)
        })
        
    }
    
    func getEventDetail(eventId : Int, completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "active/getActiveDetail?"
        path = path + "activeId=" + String(eventId)
        path = path + "&sessionId=" + String(sessionId)
        
        nativeGet(path, completion: { (dict, error) -> Void in
            completion(dict, error)
        })
        
    }
    
    
    
    
    func getArticleList(currentPage:Int, pageSize:Int, completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "article/articleList?"
        path = path + "currentPage=" + String(currentPage)
        path = path + "&pageSize=" + String(pageSize)
        path = path + "&sessionId=" + String(sessionId)
        
        nativeGet(path, completion: { (dict, error) -> Void in
            completion(dict, error)
        })
        
    }
    
    func getArticleCommentsList(articleId:Int, currentPage:Int, pageSize:Int, completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "article/articleDetail?"
        path = path + "currentPage=" + String(currentPage)
        path = path + "&pageSize=" + String(pageSize)
        path = path + "&sessionId=" + String(sessionId)
        path = path + "&articleId=" + String(articleId)
        
        nativeGet(path, completion: { (dict, error) -> Void in
            completion(dict, error)
        })
        
    }
    
    
    
    func getInterviewList(currentPage:Int, pageSize:Int, completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "microview/getViewList?"
        path = path + "currentPage=" + String(currentPage)
        path = path + "&pageSize=" + String(pageSize)
        path = path + "&sessionId=" + String(sessionId)
        
        nativeGet(path, completion: { (dict, error) -> Void in
            completion(dict, error)
        })
        
    }
    
    
    func getInterviewDetail(interviewId : Int, currentPage : Int, pageSize:Int, completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "microview/viewDetail?"
        path = path + "currentPage=" + String(currentPage)
        path = path + "&pageSize=" + String(pageSize)
        path = path + "&sessionId=" + String(sessionId)
        path = path + "&microViewId=" + String(interviewId)
        
        
        nativeGet(path, completion: { (dict, error) -> Void in
            completion(dict, error)
        })
    }
    
    
    func getTopicGroupDetail(groupId : Int, currentPage : Int, pageSize:Int, completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "topic/getGroupDetail?"
        path = path + "currentPage=" + String(currentPage)
        path = path + "&pageSize=" + String(pageSize)
        path = path + "&sessionId=" + String(sessionId)
        path = path + "&groupId=" + String(groupId)
        
        
        nativeGet(path, completion: { (dict, error) -> Void in
            completion(dict, error)
        })
    }
    
    
    
    
    func getJobList(currentPage:Int, pageSize:Int, completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "position/getPositionList?"
        path = path + "currentPage=" + String(currentPage)
        path = path + "&pageSize=" + String(pageSize)
        path = path + "&sessionId=" + String(sessionId)
        
        nativeGet(path, completion: { (dict, error) -> () in
            completion(dict, error)
        })
        
    }
    
    func getMarkedJobList(currentPage:Int, pageSize:Int, completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "position/getStoreList?"
        path = path + "currentPage=" + String(currentPage)
        path = path + "&pageSize=" + String(pageSize)
        path = path + "&sessionId=" + String(sessionId)
        
        nativeGet(path, completion: { (dict, error) -> () in
            completion(dict, error)
        })
    }
    
    
    func getJobDetail(jobId : Int, completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "position/positionDetail?"
        path = path + "&sessionId=" + String(sessionId)
        path = path + "&positionId=" + String(jobId)
        
        
        nativeGet(path, completion: { (dict, error) -> () in
            completion(dict, error)
        })
    }
    
    
    
    
    
    
    func getResearchList(currentPage:Int, pageSize:Int, completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "vote/getVoteList?"
        path = path + "currentPage=" + String(currentPage)
        path = path + "&pageSize=" + String(pageSize)
        path = path + "&sessionId=" + String(sessionId)
        
        nativeGet(path, completion: { (dict, error) -> () in
            completion(dict, error)
        })
    }
    
    func getResearchDetail(voteId : Int, completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "vote/voteDetail?"
        path = path + "&sessionId=" + String(sessionId)
        path = path + "&voteId=" + String(voteId)
        
        nativeGet(path, completion: { (dict, error) -> () in
            completion(dict, error)
        })
    }
    
    func postVote(voteId : Int, optionId: Int, completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "vote/voteChoise?"
        path = path + "voteId=" + String(voteId)
        path = path + "&optionId=" + String(optionId)
        path = path + "&sessionId=" + String(sessionId)
        
        nativeGet(path, completion: { (dict, error) -> () in
            completion(dict, error)
        })
        
    }
    
    func getMyProfile(completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "lawyer/getMaterialt?"
        path = path + "&sessionId=" + String(sessionId)
        
        nativeGet(path, completion: { (dict, error) -> () in
            completion(dict, error)
        })
    }
    
    func getUserProfileWithTopicList(userId: Int, currentPage:Int, pageSize:Int, completion: (NSDictionary?, NSError?)->())
        
    {
        var path = serverUrl + "lawyer/getLawyerInfo?"
        path = path + "currentPage=" + String(currentPage)
        path = path + "&pageSize=" + String(pageSize)
        path = path + "&lawyerId=" + String(userId)
        path = path + "&sessionId=" + String(sessionId)
        
        nativeGet(path, completion: { (dict, error) -> () in
            completion(dict, error)
        })
        
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
    
    func postSignup(parameters : NSDictionary , completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "user/reg"
        nativePost(path, parameters: parameters, completion: { (data, error) -> () in
            completion(data, error)
        })
    }
    
    func postTopicReply(parameters : NSDictionary , completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "topic/reportTopic"
        nativePost(path, parameters: parameters, completion: { (data, error) -> () in
            completion(data, error)
        })
    }
    
    func postTopic(groupId: Int, content: String , completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "topic/reportTopic"
        let parameters = NSDictionary(objects:[groupId,content,sessionId], forKeys: ["groupId","content","sessionId"])
        nativePost(path, parameters: parameters, completion: { (data, error) -> () in
            completion(data, error)
        })
    }
    
    func postDiscussReply(parameters : NSDictionary , completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "topic/topicReply"
        nativePost(path, parameters: parameters, completion: { (data, error) -> () in
            completion(data, error)
        })
    }
    
    func postArticleComment(articleId: Int, comment:String, completion: (NSDictionary?, NSError?)->())
        
    {
        var path = serverUrl + "article/aticleComment"
        let parameters = NSDictionary(objects:[articleId,comment,sessionId], forKeys: ["articleId","comment","sessionId"])
        nativePost(path,parameters: parameters,completion: { (dict, error) -> Void in
            completion(dict, error)
        })
    }
    
    
    func getTopicGroupList(currentPage:Int, pageSize:Int, completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "topic/getGroupList?"
        path = path + "&sessionId=" + String(sessionId)
        path = path + "currentPage=" + String(currentPage)
        path = path + "&pageSize=" + String(pageSize)
        nativeGet(path,completion: { (dict, error) -> Void in
            completion(dict, error)
        })
    }
    
    
    func getMyRepiliedOpportunities(currentPage:Int, pageSize:Int, completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "lawyer/replyOwnOrders?"
        path = path + "currentPage=" + String(currentPage)
        path = path + "&pageSize=" + String(pageSize)
        path = path + "&sessionId=" + String(sessionId)
        
        nativeGet(path,completion: { (dict, error) -> Void in
            completion(dict, error)
        })
    }
    
    
    
    func getMyPostOpportunities(currentPage:Int, pageSize:Int, completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "lawyer/getOrderList?"
        path = path + "currentPage=" + String(currentPage)
        path = path + "&pageSize=" + String(pageSize)
        path = path + "&sessionId=" + String(sessionId)
        
        nativeGet(path,completion: { (dict, error) -> Void in
            completion(dict, error)
        })
        
    }
    
    func getMyPostTopics(currentPage:Int, pageSize:Int, completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "lawyer/getReportTopics?"
        path = path + "currentPage=" + String(currentPage)
        path = path + "&pageSize=" + String(pageSize)
        path = path + "&sessionId=" + String(sessionId)
        
        nativeGet(path,completion: { (dict, error) -> Void in
            completion(dict, error)
        })
    }
    
    func getMyMarkedTopics(currentPage:Int, pageSize:Int, completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "lawyer/getAttetionTopics?"
        path = path + "currentPage=" + String(currentPage)
        path = path + "&pageSize=" + String(pageSize)
        path = path + "&sessionId=" + String(sessionId)
        
        nativeGet(path,completion: { (dict, error) -> Void in
            completion(dict, error)
        })
    }
    
    func getMyRepliedTopics(currentPage:Int, pageSize:Int, completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "lawyer/getReplyTopics?"
        path = path + "currentPage=" + String(currentPage)
        path = path + "&pageSize=" + String(pageSize)
        path = path + "&sessionId=" + String(sessionId)
        
        nativeGet(path,completion: { (dict, error) -> Void in
            completion(dict, error)
        })
    }
    
    func getMyEventsList(currentPage:Int, pageSize:Int, completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "lawyer/getStoreActives?"
        path = path + "currentPage=" + String(currentPage)
        path = path + "&pageSize=" + String(pageSize)
        path = path + "&sessionId=" + String(sessionId)
        
        nativeGet(path,completion: { (dict, error) -> Void in
            completion(dict, error)
        })
    }
    
    func getHotTopicGroup(currentPage:Int, pageSize:Int, completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "topic/findHotTopicGroup?"
        path = path + "currentPage=" + String(currentPage)
        path = path + "&pageSize=" + String(pageSize)
        path = path + "&sessionId=" + String(sessionId)
        
        nativeGet(path,completion: { (dict, error) -> Void in
            completion(dict, error)
        })
        
    }
    
    
    func getMyGroups(currentPage:Int, pageSize:Int, completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "group/getlawyergroups?"
        path = path + "currentPage=" + String(currentPage)
        path = path + "&pageSize=" + String(pageSize)
        path = path + "&sessionId=" + String(sessionId)
        nativeGet(path,completion: { (dict, error) -> Void in
            completion(dict, error)
        })
    }
    
    func getGroupUsers(groupId:String, currentPage:Int, pageSize:Int, completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "group/getgrouplawyers?"
        path = path + "currentPage=" + String(currentPage)
        path = path + "&groupId=" + String(groupId)
        path = path + "&pageSize=" + String(pageSize)
        path = path + "&sessionId=" + String(sessionId)
        nativeGet(path,completion: { (dict, error) -> Void in
            completion(dict, error)
        })
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
    
    func getMyFollowedUsers(completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "lawyer/getAttetionList?"
        path = path + "currentPage=1"
        path = path + "&sessionId=" + String(sessionId)
        path = path + "&pageSize=1000"
        nativeGet(path,completion: { (dict, error) -> Void in
            completion(dict, error)
        })
    }
    
    
    func getGroupList(currentPage:Int, pageSize:Int, completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "lawyer/getGroupList?"
        path = path + "currentPage=" + String(currentPage)
        path = path + "&pageSize=" + String(pageSize)
        path = path + "&sessionId=" + String(sessionId)
        nativeGet(path,completion: { (dict, error) -> Void in
            completion(dict, error)
        })
        
    }
    
    
    
    func searchOrders(title:String, currentPage:Int, pageSize:Int, completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "order/searchOrders?"
        path = path + "currentPage=" + String(currentPage)
        path = path + "&title=" + String(title)
        path = path + "&content=" + String(title)
        path = path + "&pageSize=" + String(pageSize)
        path = path + "&sessionId=" + String(sessionId)
        nativeGet(path,completion: { (dict, error) -> Void in
            completion(dict, error)
        })
    }
    
    func searchDiscuss(title:String, currentPage:Int, pageSize:Int, completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "discuss/searchDiscuss?"
        path = path + "currentPage=" + String(currentPage)
        path = path + "&title=" + String(title)
        path = path + "&content=" + String(title)
        path = path + "&pageSize=" + String(pageSize)
        path = path + "&sessionId=" + String(sessionId)
        nativeGet(path,completion: { (dict, error) -> Void in
            completion(dict, error)
        })
    }
    
    func searchActive(title:String, currentPage:Int, pageSize:Int, completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "active/searchActive?"
        path = path + "currentPage=" + String(currentPage)
        path = path + "&title=" + String(title)
        path = path + "&content=" + String(title)
        path = path + "&pageSize=" + String(pageSize)
        path = path + "&sessionId=" + String(sessionId)
        nativeGet(path,completion: { (dict, error) -> Void in
            completion(dict, error)
        })
    }
    
    func searchArticle(title:String, currentPage:Int, pageSize:Int, completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "article/searchArticle?"
        path = path + "currentPage=" + String(currentPage)
        path = path + "&title=" + String(title)
        path = path + "&content=" + String(title)
        path = path + "&pageSize=" + String(pageSize)
        path = path + "&sessionId=" + String(sessionId)
        nativeGet(path,completion: { (dict, error) -> Void in
            completion(dict, error)
        })
    }
    
    
    func postFollowUser(parameters : NSDictionary , completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "atten/makeatten"
        nativePost(path, parameters: parameters, completion: { (data, error) -> () in
            completion(data, error)
        })
    }
    
    /*
    groupName
    sessionId
    desc
    isPublic
    isApproval
    password
    maxUsers
    */
    func postCreateGroup(parameters : NSDictionary , completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "group/creategroup"
        nativePost(path, parameters: parameters, completion: { (data, error) -> () in
            completion(data, error)
        })
        
    }
    
    func postOpportunityComment(parameters : NSDictionary , completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "order/orderComment"
        nativePost(path, parameters: parameters, completion: { (data, error) -> () in
            completion(data, error)
        })
        
    }
    
    func postLikeOpportunity(parameters : NSDictionary , completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "order/orderInterest"
        nativePost(path, parameters: parameters, completion: { (data, error) -> () in
            completion(data, error)
        })
        
    }
    
    
    func postMarkTopic(parameters : NSDictionary , completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "topic/attentionTopic"
        nativePost(path, parameters: parameters, completion: { (data, error) -> () in
            completion(data, error)
        })
        
    }
    
    func postLikeArticle(parameters : NSDictionary , completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "article/articlePraise"
        nativePost(path, parameters: parameters, completion: { (data, error) -> () in
            completion(data, error)
        })
        
    }
    
    
    func postMarkArticle(parameters : NSDictionary , completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "article/articleStore"
        nativePost(path, parameters: parameters, completion: { (data, error) -> () in
            completion(data, error)
        })
        
    }
    
    func postMarkEvent(parameters : NSDictionary , completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "active/activeStore"
        nativePost(path, parameters: parameters, completion: { (data, error) -> () in
            completion(data, error)
        })
        
    }
    
    func postMarkJob(jobId : Int, completion: (NSDictionary?, NSError?)->())
    {
        let parameters = NSDictionary(objects:[jobId,sessionId], forKeys: ["positionId","sessionId"])
        var path = serverUrl + "position/positionStore"
        nativePost(path, parameters: parameters, completion: { (data, error) -> () in
            completion(data, error)
        })
        
    }
    
    
    func postMarkInterview(interViewId : Int, completion: (NSDictionary?, NSError?)->())
    {
        let parameters = NSDictionary(objects:[interViewId,sessionId], forKeys: ["microViewId","sessionId"])
        var path = serverUrl + "microview/attentionView"
        nativePost(path, parameters: parameters, completion: { (data, error) -> () in
            completion(data, error)
        })
    }
    
    func postLikeInterviewComment(commentId : Int, completion: (NSDictionary?, NSError?)->())
    {
        let parameters = NSDictionary(objects:[commentId,sessionId], forKeys: ["discussId","sessionId"])
        var path = serverUrl + "microview/discussPraise"
        nativePost(path, parameters: parameters, completion: { (data, error) -> () in
            completion(data, error)
        })
    }
    
    
    func postInterviewComment(interviewId : Int, content : String,  completion: (NSDictionary?, NSError?)->())
    {
        let parameters = NSDictionary(objects:[interviewId,content,sessionId], forKeys: ["microViewId","content","sessionId"])
        var path = serverUrl + "microview/viewDiscuss"
        nativePost(path, parameters: parameters, completion: { (data, error) -> () in
            completion(data, error)
        })
    }
    
    func postInterviewAsk(interviewId : Int, content : String,  completion: (NSDictionary?, NSError?)->())
    {
        let parameters = NSDictionary(objects:[interviewId,content,sessionId,1], forKeys: ["microViewId","content","sessionId","type"])
        var path = serverUrl + "microview/viewDiscuss"
        nativePost(path, parameters: parameters, completion: { (data, error) -> () in
            completion(data, error)
        })
    }
    
    
    func postLikeTopicReply(replyId : Int , completion: (NSDictionary?, NSError?)->())
    {
        var parameters : NSDictionary = ["replyId":replyId,"sessionId":sessionId]
        var path = serverUrl + "topic/topicReplyPraise"
        nativePost(path, parameters: parameters, completion: { (data, error) -> () in
            completion(data, error)
        })
        
    }
    
    
    func postCreateGroup(name: String, desc: String, isPublic: Bool, isApproval: Bool, password: String, maxUsers: Int, completion: (NSDictionary?, NSError?)->())
    {
        let parameters = NSDictionary(objects:[name,desc,isPublic,isApproval,password,maxUsers,sessionId], forKeys: ["groupName","desc","isPublic","isApproval","password","maxUsers","sessionId"])
        var path = serverUrl + "group/creategroup"
        httpPost(path, parameters: parameters, completion: { (data, error) -> () in
            completion(data, error)
        })
    }
    
    
    func postAddGroupMember(groupId : String, lawyerId : Int, completion: (NSDictionary?, NSError?)->())
    {
        let parameters = NSDictionary(objects:[groupId,lawyerId,sessionId], forKeys: ["groupId","lawyerIds","sessionId"])
        var path = serverUrl + "group/addme2group"
        nativePost(path, parameters: parameters, completion: { (data, error) -> () in
            completion(data, error)
        })
    }
    
    func postDeleteGroupMember(groupId : String, lawyerId : Int, completion: (NSDictionary?, NSError?)->()){
        let parameters = NSDictionary(objects:[groupId,lawyerId,sessionId], forKeys: ["groupId","lawyerId","sessionId"])
        var path = serverUrl + "group/delmefgroup"
        nativePost(path, parameters: parameters, completion: { (data, error) -> () in
            completion(data, error)
        })
    }
    
    func postDelGroup(groupId : String, completion: (NSDictionary?, NSError?)->()){
        let parameters = NSDictionary(objects:[groupId,sessionId], forKeys: ["groupId","sessionId"])
        var path = serverUrl + "group/delgroup"
        nativePost(path, parameters: parameters, completion: { (data, error) -> () in
            completion(data, error)
        })
    }
    
    func postMarkTopics(topicIds : [Int], completion: (NSDictionary?, NSError?)->()){
        //let parameters = NSDictionary(objects:[sessionId], forKeys: ["sessionId"])
        let parameters = NSDictionary(objects:[topicIds,sessionId], forKeys: ["topicIds","sessionId"])
        var path = serverUrl + "topic/attenHotTopics"
        nativePost(path, parameters: parameters, completion: { (dict, error) -> () in
            completion(dict, error)
        })
    }
    
    
    func postMarkTopics(topicIds : NSArray, completion: (NSDictionary?, NSError?)->()){
        //let parameters = NSDictionary(objects:[sessionId], forKeys: ["sessionId"])
        var path = serverUrl + "topic/attenHotTopics?"
        path = path + "&sessionId=" + String(sessionId)
        for id in topicIds
        {
            path = path + "&topicIds=" + (id as! String)
        }
        nativeGet(path) { (dict, error) -> () in
            completion(dict, error)
        }
    }
    
    func postFollowUsers(userIds : [Int], completion: (NSDictionary?, NSError?)->()){
        let parameters = NSDictionary(objects:[userIds,sessionId], forKeys: ["lawyerIds","sessionId"])
        var path = serverUrl + "laywer/attenHotLawyers"
        nativePost(path, parameters: parameters, completion: { (data, error) -> () in
            completion(data, error)
        })
    }
    
    
    func postFollowUsers(userIds : NSArray, completion: (NSDictionary?, NSError?)->()){
        let parameters = NSDictionary(objects:[userIds,sessionId], forKeys: ["lawyerIds","sessionId"])
        var path = serverUrl + "laywer/attenHotLawyers"
        jsonPost(path, parameters: parameters, completion: { (data, error) -> () in
            completion(data, error)
        })

        //let parameters = NSDictionary(objects:[sessionId], forKeys: ["sessionId"])
        //var path = serverUrl + "laywer/attenHotLawyers?"
        //path = path + "&sessionId=" + String(sessionId)
        //for id in userIds
//        {
//            path = path + "&userIds=" + (id as! String)
//        }
//        nativeGet(path) { (dict, error) -> () in
//            completion(dict, error)
//        }
    }
    
    func postSendMobile(mobile:String,type:Int, completion: (NSDictionary?, NSError?)->()){
        let parameters = NSDictionary(objects:[mobile,type], forKeys: ["mobile","bizType"])
        var path = serverUrl + "code/captcha"
        nativePost(path, parameters: parameters, completion: { (data, error) -> () in
            completion(data, error)
        })
    }
    
    
    
    
    func serializeHTTPRequest(pathString : String, parameters : NSDictionary) -> NSMutableURLRequest
    {
        let errorPointer = NSErrorPointer()
        //let form =  AFHTTPRequestSerializer().multipartFormRequestWithMethod("POST", URLString: pathString, parameters: parameters as [NSObject : AnyObject], constructingBodyWithBlock: { (formData) -> Void in }, error: errorPointer)
        
        //print(NSString(data: form.HTTPBody!, encoding: NSUTF8StringEncoding))
        return  AFHTTPRequestSerializer().requestWithMethod("POST", URLString: pathString, parameters: parameters, error: errorPointer)
    }
    
    
    func serializeJsonRequest(pathString : String, parameters : NSDictionary) -> NSMutableURLRequest
    {
        let errorPointer = NSErrorPointer()
        let manager = AFHTTPRequestOperationManager()
        return  AFHTTPRequestSerializer().requestWithMethod("POST", URLString: pathString, parameters: parameters, error: errorPointer)
    }
    
    
    
    func jsonPost(pathString : String, parameters : NSDictionary , completion: (NSDictionary?, NSError?)->())
    {
        let errorPointer = NSErrorPointer()
        var manager = AFHTTPRequestOperationManager()
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.requestSerializer = AFJSONRequestSerializer()
        let r = AFHTTPRequestSerializer().requestWithMethod("POST", URLString: pathString, parameters: parameters, error: errorPointer)
        print(NSString(data: r.HTTPBody!, encoding: NSUTF8StringEncoding))
        manager.POST(pathString, parameters: parameters, success: { (requestOperation, data) -> Void in
        
            let dict = data as? NSDictionary
            if dict == nil
            {
                return
            }
            if dict!.objectForKey("errcode") as! Int == 1
            {
                let message = dict!.objectForKey("errmessage") as! String
                dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                    KVNProgress.showErrorWithStatus((message))
                })
                return
            }
            completion(dict, nil)
            
            
            })
            { (requestOperation, error) -> Void in
                completion(nil, error as NSError)
                
        }
    }
    
    func httpPost(pathString : String, parameters : NSDictionary , completion: (NSDictionary?, NSError?)->())
    {
        var manager = AFHTTPRequestOperationManager()
        //manager.requestSerializer = AFHTTPRequestSerializer()
        //manager.responseSerializer = AFJSONResponseSerializer()
        
        manager.POST(pathString, parameters: parameters, success: { (requestOperation, data) -> Void in
            completion(data as? NSDictionary, nil)
            })
            { (requestOperation, error) -> Void in
                completion(nil, error as NSError)
        }
    }
    
    
    
    func nativeGet(pathString : String, completion: (NSDictionary?, NSError?)->())
    {
        nativeGet(pathString, parameters: nil, completion: { (data, error) -> () in
            completion(data, error)})
        
    }
    
    func nativeGet(pathString : String, parameters : NSDictionary?, completion: (NSDictionary?, NSError?)->())
    {
        
        var session = NSURLSession.sharedSession()
        let encodedPath = pathString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        let url = NSURL(string: encodedPath)!
        
        let task = session.dataTaskWithURL(url){ (data, responese, error) -> Void in
            if data == nil || error != nil
            {
                
                dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                    KVNProgress.showErrorWithStatus("网络故障")
                    //let av = UIAlertView( title: "数据出错", message:nil, delegate:nil, cancelButtonTitle:"确认")
                    //av.show()
                })
                return
            }
            
            var dataString = NSString(data: data, encoding: NSUTF8StringEncoding)
            dataString = dataString?.stringByReplacingOccurrencesOfString("\n",withString:"")
            dataString = dataString?.stringByReplacingOccurrencesOfString("\r",withString:"")
            var formatteddata =  dataString?.dataUsingEncoding(NSUTF8StringEncoding)
            let errorPointer = NSErrorPointer()
            
            let dict = NSJSONSerialization.JSONObjectWithData(formatteddata!, options: NSJSONReadingOptions.MutableLeaves, error: errorPointer) as? NSDictionary
            if dict == nil
            {
                //let ds = NSString(data: formatteddata, encoding: NSUTF8StringEncoding)
                print(dataString)
                dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                    KVNProgress.showErrorWithStatus("数据出错")
                    //let av = UIAlertView( title: "数据出错", message:nil, delegate:nil, cancelButtonTitle:"确认")
                    //av.show()
                })
                
                return
            }
            if dict!.objectForKey("errcode") != nil
            {
                if dict!.objectForKey("errcode") as! Int == 1
                {
                    let message = dict!.objectForKey("errmessage") as! String
                    dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                        KVNProgress.showErrorWithStatus(message)
                        //let av = UIAlertView( title: "错误", message:message, delegate:nil, cancelButtonTitle:"确认")
                        //av.show()
                    })
                    return
                }
                let message = dict!.objectForKey("errmessage") as! String
                dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                    KVNProgress.showErrorWithStatus(message)
                })
                completion(dict, error)
            }
            if dict!.objectForKey("result") != nil
            {
                if dict!.objectForKey("result") as! Int == 1
                {
                    let message = dict!.objectForKey("errmessage") as! String
                    dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                        KVNProgress.showErrorWithStatus(message)
                        //let av = UIAlertView( title: "错误", message:message, delegate:nil, cancelButtonTitle:"确认")
                        //av.show()
                    })
                    return
                }
                completion(dict, error)
            }
        }
        
        task.resume()
        
    }
    
    
    func nativePost(pathString : String, parameters : NSDictionary, completion: (NSDictionary?, NSError?)->())
    {
        var session = NSURLSession.sharedSession()
        let request = serializeJsonRequest(pathString,parameters:parameters)
        
        print(NSString(data: request.HTTPBody!, encoding: NSUTF8StringEncoding))
        let task = session.dataTaskWithRequest(request) { ( data, responese, error ) -> Void in
            if data == nil || error != nil
            {
                
                dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                    KVNProgress.showErrorWithStatus("网络故障")
                    //let av = UIAlertView( title: "网络故障", message:nil, delegate:nil, cancelButtonTitle:"确认")
                    //av.show()
                })
                
                return
            }
            //let ds = NSString(data: data, encoding: NSUTF8StringEncoding)
            //print(ds)
            let errorPointer = NSErrorPointer()
            let dict = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves, error: errorPointer) as? NSDictionary
            if dict == nil
            {
                let ds = NSString(data: data, encoding: NSUTF8StringEncoding) as! String
                NSLog(ds)
                dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                    KVNProgress.showError()
                    //let av = UIAlertView( title: "数据出错", message:nil, delegate:nil, cancelButtonTitle:"确认")
                    //av.show()
                })
                return
            }
            if dict!.objectForKey("errcode") != nil
            {
                if dict!.objectForKey("errcode") as! Int == 1
                {
                    let message = dict!.objectForKey("errmessage") as! String
                    dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                        KVNProgress.showErrorWithStatus(message)
                        //let av = UIAlertView( title: "错误", message:message, delegate:nil, cancelButtonTitle:"确认")
                        //av.show()
                    })
                    return
                }
                let message = dict!.objectForKey("errmessage") as! String
                dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                    KVNProgress.showErrorWithStatus(message)
                })
                completion(dict, error)
            }
            if dict!.objectForKey("result") != nil
            {
                if dict!.objectForKey("result") as! Int == 0
                {
                    let message = dict!.objectForKey("errMsg") as! String
                    dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                        KVNProgress.showErrorWithStatus(message)
                        //let av = UIAlertView( title: "错误", message:message, delegate:nil, cancelButtonTitle:"确认")
                        //av.show()
                    })
                    return
                }
                completion(dict, error)
            }
            
        }
        task.resume()
    }
    
    
    
    func postSignup(phone: String, password: String, code: String, name:String , completion: (NSDictionary?, NSError?)->())
    {
        var path = serverUrl + "user/reg"
        var postData = NSMutableData(data: ("phone="+phone).dataUsingEncoding(NSUTF8StringEncoding)!)
        postData.appendData(("&password="+password).dataUsingEncoding(NSUTF8StringEncoding)!)
        path = path + "?phone="+phone
        path = path + "&password="+password
        var request = NSMutableURLRequest(URL: NSURL(string: path)!,
            cachePolicy: .UseProtocolCachePolicy,
            timeoutInterval: 10.0)
        request.HTTPMethod = "GET"
        //request.HTTPBody = postData
        
        let session = NSURLSession.sharedSession()
        let dataTask = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                println(error)
            } else {
                let httpResponse = response as? NSHTTPURLResponse
                println(httpResponse)
                let errorPointer = NSErrorPointer()
                let dict = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableLeaves, error: errorPointer) as? NSDictionary
                if dict == nil
                {
                    //let ds = NSString(data: data, encoding: NSUTF8StringEncoding)
                    //print(ds)
                    dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                        
                        let av = UIAlertView( title: "数据出错", message:nil, delegate:nil, cancelButtonTitle:"确认")
                        av.show()
                    })
                    return
                }
                if dict!.objectForKey("errcode") as! Int == 1
                {
                    let message = dict!.objectForKey("errmessage") as! String
                    dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                        let av = UIAlertView( title: "错误", message:message, delegate:nil, cancelButtonTitle:"确认")
                        av.show()
                    })
                    return
                }
                completion(dict, error)
                
            }
        })
        
        dataTask.resume()
    }
    
    
    func postUserInfo(username : String, intro : String, office : String, cityId : Int , completion: (NSDictionary?, NSError?)->())
    {
        let parameters = NSDictionary()
        
        //(objects:[username,sessionId], forKeys: ["name","introducation","lawOffice",])
        var path = serverUrl + "topic/attenHotTopics"
        nativePost(path, parameters: parameters, completion: { (data, error) -> () in
            completion(data, error)
        })
        
    }
    
    
    
    
}