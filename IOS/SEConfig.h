//
//  SEConfig.h
//  SeatFillers
//
//  Created by Hoan Vu  on 8/21/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>







#define NOTIFICATION_KEY_RECEIVER_MESSAGE @"ReceiverMessage"
#define NOTIFICATION_KEY_CANCEL_TICKET @"CancelTicket"
#define NOTIFICATION_KEY_SUMMIT_TICKET @"SubmitTicket"
#define NOTIFICATION_KEY_CHANGE_TICKET @"ChangeTIcket"




@interface SEConfig : NSObject
+(void)postNotify:(NSString*)key;

+(void)logPage:(NSString*)page andFucntion :(NSString*)function;
@end
