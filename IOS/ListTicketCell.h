//
//  ListTicketCell.h
//  SeatFillers
//
//  Created by Hoan Vu  on 6/19/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListTicketCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UILabel *lbDescription;
@property (weak, nonatomic) IBOutlet UILabel *lbDate;
@property (weak, nonatomic) IBOutlet UILabel *lbTime;
@property (weak, nonatomic) IBOutlet UILabel *lbTixOnHane;
@property (weak, nonatomic) IBOutlet UILabel *lbRange;
@property (weak, nonatomic) IBOutlet UILabel *lbLocation;
+(UIColor*)whiteColor;
+(UIColor*)browColor;
@end
