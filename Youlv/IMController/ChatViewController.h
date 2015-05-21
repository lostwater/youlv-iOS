//
//  RootViewController.h
//  UUChatTableView
//
//  Created by shake on 15/1/4.
//  Copyright (c) 2015年 uyiuyao. All rights reserved.
//

#import "UUInputFunctionView.h"
#import "MJRefresh.h"
#import "UUMessageCell.h"
#import "ChatModel.h"
#import "UUMessageFrame.h"
#import "UUMessage.h"
#import <UIKit/UIKit.h>

@interface ChatViewController : UIViewController
@property (nonatomic) NSString* chattitle;
@property (nonatomic) int lawyerId;
@property (nonatomic) int groupId;
@property (nonatomic) BOOL isGroup;

-(void)headImageDidClick:(UUMessageCell *)cell userId:(NSString *)userId;

@end
