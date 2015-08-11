//
//  BuyerChatDetail.h
//  SeatFillers
//
//  Created by phan hoang quoc an on 7/29/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import "AMBubbleTableViewController.h"
#import "BookTicket.h"
#import "AppDelegate.h"
#import "SeatMacro.h"
#import "SeatTicket.h"


@interface BuyerChatDetail : AMBubbleTableViewController<UIAlertViewDelegate>

//@property (strong,nonatomic) BookTicket *bookTic;
@property (strong,nonatomic) AppDelegate *app;
@property (strong,nonatomic) NSMutableArray *arrListChat;
@property (strong,nonatomic) NSString *idLastMessage;
@property (strong,nonatomic) SeatTicket *seatic;
@property (strong,nonatomic) NSTimer *addLastComment;



@end
