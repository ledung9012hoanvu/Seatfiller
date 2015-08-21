//
//  BuyerListChat.h
//  SeatFillers
//
//  Created by phan hoang quoc an on 7/29/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Interface.h"
#import "AFHTTPRequestOperationManager.h"
#import "SeatService.h"
#import "SeatFillerDesign.h"
#import "SeatTicket.h"
#import "BuyerHome.h"
@interface BuyerListChat : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tbLishChat;


@property (strong,nonatomic) NSMutableArray *arrayUserChat;
@property(nonatomic, strong) BuyerHome *buyerHome;

@end
