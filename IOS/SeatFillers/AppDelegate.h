//
//  AppDelegate.h
//  SeatFillers
//
//  Created by LeDung on 6/11/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeatUser.h"
#import "AMBubbleTableViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic,strong) SeatUser * seatUser;

@property(nonatomic,strong) NSMutableDictionary *dictionaryCiteState;
@property (nonatomic,strong) NSMutableArray *ListArray;
@property (nonatomic,strong) NSMutableArray *BuyerTicketArray;


@end

