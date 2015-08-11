//
//  ChattingList.h
//  SeatFillers
//
//  Created by Hoan Vu  on 6/22/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SeatTicket.h"
#import "SeatFillerDesign.h"


@interface ChattingList : UIViewController
@property (nonatomic, weak) IBOutlet UITableView *mTableView;
@property (nonatomic, strong) NSMutableArray *chatHistoryArr;
@property (strong,nonatomic) AppDelegate *app;
@property (strong,nonatomic) NSMutableArray *ArrComment;





@end
