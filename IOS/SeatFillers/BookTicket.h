//
//  BookTicket.h
//  SeatFillers
//
//  Created by phan hoang quoc an on 7/22/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookTicket : NSObject
@property (strong,nonatomic) NSString *sid;
@property (strong,nonatomic) NSString *TicketId;
@property (strong,nonatomic) NSString *BuyerId;
@property (strong,nonatomic) NSString *created;
@property (strong,nonatomic) NSString *status;
@property (strong,nonatomic) NSString *qty;
@property (strong,nonatomic) NSString *sellerId;
@property (strong,nonatomic) NSString *byDisplayName;
@property (strong,nonatomic) NSString *byUsername;
+(BookTicket*)ticketFromDictionary:(NSMutableDictionary*)dictionary;
@end
