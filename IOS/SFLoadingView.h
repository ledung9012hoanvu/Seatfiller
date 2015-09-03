//
//  SFLoadingView.h
//  SeatFillers
//
//  Created by Hoan Vu  on 9/3/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MZLoadingCircle.h"
@interface SFLoadingView : NSObject
@property(nonatomic,strong) MZLoadingCircle *loadingCircle;
-(id)initWithView:(UIView*)view;
-(void)hideLoadingView;
-(void)showLoadingView;
@end
