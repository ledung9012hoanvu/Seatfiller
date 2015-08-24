//
//  ListUserChat.h
//  SeatFillers
//
//  Created by phan hoang quoc an on 7/22/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SeatTicket.h"
#import "AFHTTPRequestOperationManager.h"
#import "ChatDetail.h"
#import "BookTicket.h"


@interface ListUserChat : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray *listUser;
@property (nonatomic,strong) NSString *ticket_id;
@end
