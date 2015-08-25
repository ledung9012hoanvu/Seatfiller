//
//  SeatAller.h
//  SeatFillers
//
//  Created by Hoan Vu  on 6/17/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol AlertDelegate <NSObject>

-(void)alertIndexHendle:(NSInteger)index;

@end

@interface SeatAller : NSObject <UIAlertViewDelegate>
@end
