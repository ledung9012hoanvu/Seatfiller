//
//  ChatUser.h
//  SeatFillers
//
//  Created by phan hoang quoc an on 7/22/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ChatUser : NSObject
@property (strong,nonatomic) NSString *text;
@property (strong,nonatomic) NSDate *date;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *username;
@property (strong,nonatomic) UIColor *color;
+(NSMutableDictionary*)dicFromChatUser:(ChatUser*)chatUser;



@end
