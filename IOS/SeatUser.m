//
//  SeatUser.m
//  SeatFillers
//
//  Created by LeDung on 6/11/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import "SeatUser.h"
#import "SeatMacro.h"

@implementation SeatUser


+ (id)userInit
{
    static SeatUser *sharedMyManager = nil;
    @synchronized(self) {
        if (sharedMyManager == nil)
            sharedMyManager = [[self alloc] init];
    }
    return sharedMyManager;
}

-(void)userLogOut
{
    self.userName = nil;
    self.password=nil;
}
+(SeatUser*)initWithDictionaryString:(NSMutableDictionary*)dictionary
{
    SeatUser *seatUser =[[SeatUser alloc]init];
    seatUser.userName=[SeatUser null2Empty:[dictionary valueForKey:USER_NAME]];
    seatUser.email=[SeatUser null2Empty:[dictionary valueForKey:USER_EMAIL]];
    seatUser.firstName =[SeatUser null2Empty:[dictionary valueForKey:USER_FIRSTNAME]];
    seatUser.lastName=[SeatUser null2Empty:[dictionary valueForKey:USER_LASTNAME]];
    seatUser.planId=[SeatUser null2Empty:[dictionary valueForKey:USER_PLANID]];
    seatUser.token =[SeatUser null2Empty:[dictionary valueForKey:USER_TOKEN]];
    seatUser.type=[SeatUser null2Empty:[dictionary valueForKey:USER_TYPE] ];
    seatUser.userId =[SeatUser null2Empty:[dictionary valueForKey:USER_ID]];
    seatUser.userName=[SeatUser null2Empty:[dictionary valueForKey:@"user_name"]];
    seatUser.status =[SeatUser null2Empty:[dictionary valueForKey:USER_STATUS]];
    
    return seatUser;
    
}

+(NSString*)null2Empty:(NSString*)string
{
    if([[NSString stringWithFormat:@"%@", string] isEqualToString:@"<null>"])
    {
        return @" ";
    }
    return [NSString stringWithFormat:@"%@",string];
}


+(NSMutableDictionary*)dictionaryFromUserWithUsername:(NSString *)username andPass:(NSString*)pass andRetypePass:(NSString*)reTypePass andEmail:(NSString*)email andFirstName:(NSString*)firstName andLastName:(NSString*)lastName
{
    
    NSMutableDictionary *dictionary =[[NSMutableDictionary alloc]init];
    [dictionary setValue:username forKey:USER_NAME];
    [dictionary  setValue:pass forKey:USER_PASS];
    [dictionary setValue:reTypePass forKey:USER_PASS];
    [dictionary setValue:email forKey:USER_EMAIL];
    [dictionary setValue:firstName forKey:USER_FIRSTNAME];
    
    [dictionary setValue:lastName forKey:USER_LASTNAME];
    return  dictionary;
}


+(NSMutableDictionary*)dictionaryFromSeatUser:(SeatUser *)seatUser
{
    
    NSMutableDictionary *dictionary =[[NSMutableDictionary alloc]init];
    [dictionary setValue:seatUser.userName forKey:USER_NAME];
    [dictionary setValue:seatUser.email forKey:USER_EMAIL];
    [dictionary setValue:seatUser.firstName forKey:USER_FIRSTNAME];
    [dictionary setValue:seatUser.lastName forKey:USER_LASTNAME];
    //[dictionary setValue:seatUser.token forKey:USER_TOKEN];
    [dictionary  setValue:seatUser.type forKey:USER_TYPE];
    [dictionary setValue:seatUser.userId forKey:USER_ID];
    [dictionary setValue:seatUser.planId forKey:USER_FIRSTNAME];
    [dictionary setValue:seatUser.token forKey:USER_TOKEN];
    [dictionary setObject:seatUser.status forKey:USER_STATUS];
    NSLog(@"dictionary From User : %@",dictionary);
    return  dictionary;
}



@end
