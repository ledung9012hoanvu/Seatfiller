//
//  SeatTicket.m
//  SeatFillers
//
//  Created by LeDung on 6/11/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import "SeatTicket.h"

@implementation SeatTicket



+(SeatTicket*)ticketFromDictionary:(NSMutableDictionary*)dictionary
{
    SeatTicket *seatTicket =[[SeatTicket alloc]init];
    seatTicket.sId =  [SeatTicket null2Empty:[dictionary valueForKey:TICKET_ID]];
    seatTicket.title =  [SeatTicket null2Empty:[dictionary valueForKey:TICKET_TITLE]];
    seatTicket.created =  [SeatTicket null2Empty:[dictionary valueForKey:TICKET_CREATED]];
    seatTicket.status =  [SeatTicket null2Empty:[dictionary valueForKey:TICKET_STATUS]];
    seatTicket.typeName=[SeatTicket null2Empty:[dictionary valueForKey:@"typeName"]];
    seatTicket.startDate =  [SeatTicket null2Empty:[dictionary valueForKey:TICKET_START_DATE]];
    seatTicket.starTime =  [SeatTicket null2Empty:[dictionary valueForKey:TICKET_TIME]];
    seatTicket.address =  [SeatTicket null2Empty:[dictionary valueForKey:TICKET_ADDRESS]];
    seatTicket.priceRange =  [SeatTicket null2Empty:[dictionary valueForKey:TICKET_PRICE_RANGE]];
    seatTicket.note =  [SeatTicket null2Empty:[dictionary valueForKey:TICKET_NOTE]];
    seatTicket.qty =  [SeatTicket null2Empty:[dictionary valueForKey:TICKET_QTY]];
    seatTicket.state = [SeatTicket null2Empty:[dictionary valueForKey:@"state"]];
    seatTicket.city = [SeatTicket null2Empty:[dictionary valueForKey:TICKET_CITY]];
    seatTicket.expiryDate = [SeatTicket null2Empty:[dictionary valueForKey:@"expiry_date"]];
    seatTicket.imageURLString = [dictionary valueForKey:@"image"];
    seatTicket.lat = [SeatTicket null2Empty:[dictionary valueForKey:@"lat"]];
    seatTicket.lng = [SeatTicket null2Empty:[dictionary valueForKey:@"lng"]];
    seatTicket.bookId = [SeatTicket null2Empty:[dictionary valueForKey:@"book_id"]];
    seatTicket.interested =[SeatTicket null2Empty:[dictionary valueForKey:@"interest"]];
    seatTicket.byUser = [SeatTicket null2Empty:[dictionary valueForKey:@"by_user"]];
    seatTicket.userId = [SeatTicket null2Empty:[dictionary valueForKey:@"user_id"]];
    return seatTicket;
}

+(NSMutableArray*)arrayTicketFromDictionary:(NSMutableDictionary*)dictionary
{
    NSMutableArray *array=[[NSMutableArray alloc]init];
    NSArray *dataArray=[dictionary objectForKey:@"data"];
        for (int i=0; i<dataArray.count; i++)
        {
            SeatTicket *unit=[SeatTicket ticketFromDictionary:[dataArray objectAtIndex:i]];
            [array addObject:unit];
            unit=nil;
        }
    return array;
}
+(NSString*)null2Empty:(NSString*)string
{
    if([[NSString stringWithFormat:@"%@", string] isEqualToString:@"<null>"])
    {
        return @" ";
    }
    return [NSString stringWithFormat:@"%@",string];
}


+(NSMutableDictionary*)dictionaryFromTicket:(SeatTicket*)ticket
{
    
    NSMutableDictionary* dictionary =[[NSMutableDictionary alloc]init];
    
    return dictionary;
    
}

+(NSMutableArray *)ticketListFromJson:(NSMutableDictionary*)dictionary
{
    NSMutableArray *array ;

    
    
    
    
    return array;
}


@end

