//
//  BookMessage.h
//  SeatFillers
//
//  Created by Hoan Vu  on 7/24/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookMessage : NSObject
@property(nonatomic,strong)NSString *bookId;
@property(nonatomic,strong)NSString *messageId;
@property(nonatomic,strong)NSString *parentId;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *dateTime;
@property(nonatomic,strong)NSString *sellerNameDisplay;
@property(nonatomic,strong)NSString *selleId;
@property(nonatomic,strong)NSString *buyeNameDisplay;
@property(nonatomic,strong)NSString *buyerId;

+(BookMessage*)bookMessageFromDictionary:(NSMutableDictionary*)dictionary;
+(NSMutableDictionary*)dictionaryFormBookMessage:(BookMessage*)bookMessage;
+(NSMutableArray*)arrayFromBookDictionary:(NSMutableDictionary*)dictionary;
@end


