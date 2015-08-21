//
//  SeatTicket.h
//  SeatFillers
//
//  Created by LeDung on 6/11/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SeatMacro.h"

@interface SeatTicket : NSObject
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *status;
@property(nonatomic,strong) NSString *sId;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *qty;
@property(nonatomic,strong) NSString *type;
@property(nonatomic,strong) NSString *imageURLString;
@property(nonatomic,strong) NSString *startDate;
@property(nonatomic,strong) NSString *starTime;
@property(nonatomic,strong) NSString *city;
@property(nonatomic,strong) NSString *priceRange;
@property(nonatomic,strong) NSString *address;
@property(nonatomic,strong) NSString *lat;
@property(nonatomic,strong) NSString *lng;
@property(nonatomic,strong) NSString *note;
@property(nonatomic,strong) NSString *created;
@property(nonatomic,strong) NSString *updated;
@property(nonatomic,strong) NSString *userId;
@property(nonatomic,strong) NSString *expiryDate;
@property(nonatomic,strong) NSString *startDateTimeZone;
@property(nonatomic,strong) NSString *timeZone;
@property(nonatomic,strong) NSString *bookId;
@property(nonatomic,strong) NSString *byUser;
@property(nonatomic,strong) NSString *typeName;
@property(nonatomic,strong) NSString *qtyBook;
@property(nonatomic,strong) NSString *username;
@property(nonatomic,strong) NSString *location;
@property (nonatomic,strong) NSString *state;
@property (nonatomic,strong) NSString *interested;



+(SeatTicket*)ticketFromDictionary:(NSMutableDictionary*)dictionary;
+(NSMutableDictionary*)dictionaryFromTicket:(SeatTicket*)ticket;
+(NSMutableArray*)arrayTicketFromDictionary:(NSMutableDictionary*)dictionary;

@end
