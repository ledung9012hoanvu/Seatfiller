//
//  ChatUser.m
//  SeatFillers
//
//  Created by phan hoang quoc an on 7/22/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import "ChatUser.h"

@implementation ChatUser
+(NSMutableDictionary*)dicFromChatUser:(ChatUser *)chatUser{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:chatUser.text forKey:@"text"];
    [dic setObject:chatUser.date forKey:@"date"];
    [dic setObject:chatUser.type forKey:@"type"];
    [dic setObject:chatUser.username forKey:@"username"];
    [dic setObject:chatUser.color forKey:@"color"];
    
    return dic;
    
}

@end
