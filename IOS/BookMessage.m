

#import "BookMessage.h"
#import <UIKit/UIKit.h>
#import "BookTicket.h"

@implementation BookMessage

+(NSString*)null2Empty:(NSString*)string
{
    if([[NSString stringWithFormat:@"%@", string] isEqualToString:@"<null>"])
    {
        return @"";
    }
    return [NSString stringWithFormat:@"%@",string];
}

+(BookMessage*)bookMessageFromDictionary:(NSMutableDictionary*)dictionary
{
    BookMessage *bookMessage =[[BookMessage alloc]init];
    bookMessage.parentId =[dictionary valueForKey:@"parent_id"];
    bookMessage.content =[dictionary valueForKey:@"comment"];
    bookMessage.dateTime =[dictionary valueForKey:@"created"];
    return bookMessage;
}

+(NSMutableDictionary*)dictionaryFormBookMessage:(BookMessage*)bookMessage
{
    NSMutableDictionary *dictionary =[[NSMutableDictionary alloc]init];
    if ([bookMessage.parentId isEqualToString:bookMessage.buyerId])
    {
        [dictionary setValue:@"1" forKey:@"type"];

    }else
    {
        [dictionary setValue:@"2" forKey:@"type"];
        [dictionary setValue:bookMessage.buyeNameDisplay forKey:@"username"];
    }
    [dictionary setValue: [BookMessage null2Empty:bookMessage.content] forKey:@"text"];
    [dictionary setValue:[BookMessage null2Empty:bookMessage.dateTime] forKey:@"time"];
    [dictionary setObject:[UIColor blueColor] forKey:@"color"];
    return dictionary;
}

+(NSMutableArray*)arrayFromBookDictionary:(NSMutableDictionary*)dictionary
{
    NSString *bookId =[[dictionary valueForKey:@"book"] valueForKey:@"book_id"];
    NSString *buyerId = [[dictionary valueForKey:@"book"] valueForKey:@"buyer_id"];
    NSString *buyeNameDisplay=[[dictionary valueForKey:@"book"] valueForKey:@"by_displayname"];
    NSMutableArray *array =[[NSMutableArray alloc]init];
    NSArray *messageArray  =[dictionary valueForKey:@"data"];
    for(int i = messageArray.count -1 ; i>-1 ;i--)
    {
        BookMessage *bookMessage=[BookMessage bookMessageFromDictionary:messageArray[i]];
        bookMessage.bookId=bookId;
        bookMessage.buyerId=buyerId;
        bookMessage.buyeNameDisplay=buyeNameDisplay;
        NSMutableDictionary *dictionaryUnit =[BookMessage dictionaryFormBookMessage:bookMessage];
        [array addObject:dictionaryUnit];
    }
    return array;
}

@end
