//
//  SEConfig.m
//  SeatFillers
//
//  Created by Hoan Vu  on 8/21/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import "SEConfig.h"

@implementation SEConfig
+(void)postNotify:(NSString *)key
{
    [[NSNotificationCenter defaultCenter]postNotificationName:key object:nil];
}
@end
