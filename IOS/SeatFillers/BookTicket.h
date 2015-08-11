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


//{
//    "status": true,
//    "data": [
//             {
//                 "id": "238",
//                 "ticket_id": "235",
//                 "buyer_id": "89",
//                 "created": "1437546225",
//                 "status": "1",
//                 "qty": "1",
//                 "seller_id": "71",
//                 "by_displayname": "Susan Huynh",
//                 "by_username": "1635297516754644"
//             }
//             ]
//}


@end
