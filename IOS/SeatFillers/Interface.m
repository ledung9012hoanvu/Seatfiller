//
//  Interface.m
//  FaProject
//
//  Created by LeDung on 1/18/14.
//  Copyright (c) 2014 LeDung. All rights reserved.
//

#import "Interface.h"
#import "SeatMacro.h"

@implementation Interface
+(NSString*)isNib:(NSString *)nib
{
    return @"";
}


+(void)boderView:(CGFloat)radius andwidth:(CGFloat)width andColor:(UIColor*)color andView:(UIView*)view
{
    view.layer.cornerRadius=radius;
    view.layer.borderWidth=width;
    view.layer.borderColor=color.CGColor;
    view.layer.masksToBounds =YES;
}

+(CGFloat)screedWidth
{
    return SCREEN_WIDTH;
}


+(void)setFullWidth:(UIView*)view
{
    NSLog(@"width : %f",[Interface screedWidth]);
    [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, [Interface screedWidth], view.frame.size.height)];
}





@end


