//
//  BookTicket.m
//  SeatFillers
//
//  Created by phan hoang quoc an on 7/22/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import "BookTicket.h"

@implementation BookTicket
+(NSString*)null2Empty:(NSString*)string
{
    if([[NSString stringWithFormat:@"%@", string] isEqualToString:@"<null>"])
    {
        return @" ";
    }
    return [NSString stringWithFormat:@"%@",string];
}
+(BookTicket*)ticketFromDictionary:(NSMutableDictionary *)dictionary{
    BookTicket *bookTic = [[BookTicket alloc]init];
    bookTic.sid = [BookTicket null2Empty:[dictionary valueForKey:@"id"]];
    bookTic.TicketId = [BookTicket null2Empty:[dictionary valueForKey:@"ticket_id"]];
    bookTic.BuyerId = [BookTicket null2Empty:[dictionary valueForKey:@"buyer_id"]];
    bookTic.created = [BookTicket null2Empty:[dictionary valueForKey:@"created"]];
    bookTic.status = [BookTicket null2Empty:[dictionary valueForKey:@"status"]];
    bookTic.qty = [BookTicket null2Empty:[dictionary valueForKey:@"qty"]];
    bookTic.sellerId = [BookTicket null2Empty:[dictionary valueForKey:@"seller_id"]];
    bookTic.byDisplayName = [BookTicket null2Empty:[dictionary valueForKey:@"by_displayname"]];
    bookTic.byUsername = [BookTicket null2Empty:[dictionary valueForKey:@"by_username"]];
    
    

    
    
    return bookTic;
    
}

@end
