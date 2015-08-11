//
//  USCityReader.h
//  SeatFillers
//
//  Created by LeDung on 6/15/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import "CHCSVParser.h"

@interface USCityReader : CHCSVParser <CHCSVParserDelegate>
+(instancetype)sharedClient;

@end





@interface EventCity : NSObject
@property (nonatomic,strong) NSString *state;
@property(nonatomic,strong) NSMutableArray *arrCity;
@end
