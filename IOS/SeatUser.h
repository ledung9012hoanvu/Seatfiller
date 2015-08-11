//
//  SeatUser.h
//  SeatFillers
//
//  Created by LeDung on 6/11/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SeatUser : NSObject
@property(nonatomic,strong)NSString * firstName;
@property(nonatomic,strong)NSString * lastName;
@property(nonatomic,strong)NSString * userName;
@property(nonatomic,strong)NSString * password;
@property(nonatomic,strong)NSString *deviceToken;
@property(nonatomic,strong)NSString *accessToken;
@property(nonatomic,strong)NSString *email;
@property(nonatomic,strong)NSString *planId;
@property(nonatomic,strong)NSString *token;
@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *userId;
@property(nonatomic,strong)NSString *status;




//----------------------------------------------------setting----
@property(nonatomic, assign) NSInteger isNotify; // on = 1 ; off # 1
@property(nonatomic, assign) NSInteger isSound; // on = 1 ; off # 1
@property(nonatomic, assign) NSInteger isVibration;// on = 1 ; off # 1
//---------------------------------------------------------------



+(SeatUser*)initWithDictionaryString:(NSMutableDictionary*)dictionary;
+(NSMutableDictionary*)dictionaryFromSeatUser:(SeatUser*)seatUser;


-(void)userLogOut;


@end
