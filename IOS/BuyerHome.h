//
//  BuyerHome.h
//  SeatFillers
//
//  Created by LeDung on 6/11/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeatFillerDesign.h"
#import "BuyerRequetstTicket.h"
@interface BuyerHome : UIViewController<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableViewListTicket;

@property(nonatomic,strong) NSMutableArray *ticketArray;

@property (nonatomic) long seletedIndex;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (nonatomic) BOOL isNext;









- (IBAction)btReportSeller:(id)sender;

@end
