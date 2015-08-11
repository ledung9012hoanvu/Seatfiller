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
    if(IS_IPHONE_6P)
    {
        return 414;
    }
    if(IS_IPHONE_6)
    {
        return 350;
    }
    if(IS_IPHONE_5)
    {
        return 320;
    }
    if(IS_IPHONE_4)
    {
        return 320;
    }
    return 320;
}


+(void)setFullWidth:(UIView*)view
{
    NSLog(@"width : %f",[Interface screedWidth]);
    [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, [Interface screedWidth], view.frame.size.height)];
}





@end


