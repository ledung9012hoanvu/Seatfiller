//
//  UIView+LeafUI.m
//  Minglesome
//
//  Created by Hoan Vu  on 8/7/15.
//  Copyright (c) 2015 Tuan Le. All rights reserved.
//

#import "UIView+LeafUI.h"
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

@implementation UIView (LeafUI)
-(CGFloat)height
{
    return self.frame.size.height;
}

-(CGFloat)width
{
    return self.frame.size.width;
}


-(CGFloat)xLocation
{
    return self.frame.origin.x;
}
-(CGFloat)yLocation
{
    return self.frame.origin.y;
}


-(void)setHeigh:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height=height;
    self.frame=frame;
}
-(void)setWidth:(CGFloat)width
{
    CGRect frame =self.frame;
    frame.size.width=width;
    self.frame=frame;
}
-(void)setXLocation:(CGFloat)xLocation
{
    CGRect frame =self.frame;
    frame.origin.x =xLocation;
    self.frame=frame;
}
-(void)setYLocation:(CGFloat)yLocation
{
    CGRect frame =self.frame;
    frame.origin.y =yLocation;
    self.frame=frame;
}



-(CGFloat)xTLocation
{
    return [[self superview] frame].size.width -(self.width +self.xLocation);
}

-(void)setXTLocation:(CGFloat)xTLocation
{
    UIView *view = [self superview];
    NSLog(@"contain width : %f",view.frame.size.width);
    NSLog(@"unit width : %f",self.width);
    
    CGFloat xLocation  =(view.width -self.width )-xTLocation;
    
    NSLog(@"xlovation : %f",xLocation);
    [self setXLocation:xLocation];
}


















@end
