//
//  SellerHome.h
//  SeatFillers
//
//  Created by LeDung on 6/11/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Interface.h"
#import "AFHTTPRequestOperationManager.h"
#import "ChattingList.h"

@interface SellerHome : UIViewController <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property(nonatomic,strong) NSMutableArray *ticketArray;
@property (weak, nonatomic) IBOutlet UITableView *tbListTicket;
//@property (weak, nonatomic) IBOutlet UIButton *btRefresh;
@property (strong,nonatomic) ChattingList *chatList;
@property (nonatomic) long selectedRow;




//- (IBAction)btAddEventPress:(id)sender;
//- (IBAction)btRefreshPress:(id)sender;
- (IBAction)btReportPress:(id)sender;

@end
