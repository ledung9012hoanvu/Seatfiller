//
//  ChatDetail.h
//  SeatFillers
//
//  Created by phan hoang quoc an on 7/21/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import "AMBubbleTableViewController.h"
#import "BookTicket.h"
#import "SeatMacro.h"
#import "AppDelegate.h"


@interface ChatDetail : AMBubbleTableViewController<UIAlertViewDelegate>
@property (strong,nonatomic) BookTicket *bookTic;
@property (strong,nonatomic) AppDelegate *app;
@property (strong,nonatomic) NSMutableArray *listComment;

@end
