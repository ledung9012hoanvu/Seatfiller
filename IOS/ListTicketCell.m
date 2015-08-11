//
//  ListTicketCell.m
//  SeatFillers
//
//  Created by Hoan Vu  on 6/19/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import "ListTicketCell.h"
#import "SeatMacro.h"
#import "Interface.h"
@implementation ListTicketCell

- (void)awakeFromNib
{
    
    NSLog(@"awake");
    [self.lbName setBackgroundColor:[UIColor clearColor]];
    [self.lbDate setBackgroundColor:[UIColor clearColor]];
    [self.lbRange setBackgroundColor:[UIColor clearColor]];
    [self.lbDate setBackgroundColor:[UIColor clearColor]];
    [self.lbTixOnHane setBackgroundColor:[UIColor clearColor]];
    self.lbLocation.numberOfLines =2;
    self.lbDate.numberOfLines =2;
    self.lbDate.numberOfLines =2;
    [self.lbRange setFont:[UIFont systemFontOfSize:8]];
    [self.lbLocation setFont:[UIFont systemFontOfSize:7]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

+(UIColor*)whiteColor
{
    return [UIColor whiteColor];
}
+(UIColor*)browColor
{
  return   [UIColor colorWithRed:215.0/255 green:226.0/255 blue:246.0/255 alpha:1];
}

@end
