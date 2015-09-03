//
//  SFLoadingView.m
//  SeatFillers
//
//  Created by Hoan Vu  on 9/3/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import "SFLoadingView.h"
#import "SeatFillerDesign.h"
@implementation SFLoadingView
-(id)initWithView:(UIView*)view
{
    self =[super init];
    
    self.loadingCircle = [[MZLoadingCircle alloc]initWithNibName:nil bundle:nil];
    self.loadingCircle.view.backgroundColor = [UIColor clearColor];
    
    //Colors for layers
    self.loadingCircle.colorCustomLayer = [SeatFillerDesign greenNavi];
    self.loadingCircle.colorCustomLayer2 = [SeatFillerDesign greenNavi];
    self.loadingCircle.colorCustomLayer3 = [SeatFillerDesign greenNavi];
    
    int size = 100;
    
    CGRect frame = self.loadingCircle.view.frame;
    frame.size.width = size ;
    frame.size.height = size;
    frame.origin.x = view.frame.size.width / 2 - frame.size.width / 2;
    frame.origin.y = view.frame.size.height / 2 - frame.size.height / 2;
    self.loadingCircle.view.frame = frame;
    self.loadingCircle.view.layer.zPosition = MAXFLOAT;
    [view addSubview: self.loadingCircle.view];
    [self.loadingCircle.view setHidden:YES];
    self.loadingCircle.view.layer.cornerRadius=8;
    return self;
}
-(void)hideLoadingView
{
    [self.loadingCircle.view setHidden:YES];
}
-(void)showLoadingView
{
    [self.loadingCircle.view setHidden:NO];
    [self.loadingCircle.view setBackgroundColor:[UIColor blackColor]];

}
@end
