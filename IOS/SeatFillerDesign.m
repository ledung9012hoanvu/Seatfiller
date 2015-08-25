//
//  SeatFillerDesign.m
//  SeatFillers
//
//  Created by LeDung on 6/11/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import "SeatFillerDesign.h"
#import  <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Interface.h"
@implementation SeatFillerDesign

+(void)viewGeneralWithBlueHeader:(UIView*)view
{
    [Interface boderView:4 andwidth:2 andColor:[SeatFillerDesign greenNavi] andView:view];
    [view setBackgroundColor:[UIColor clearColor]];
}

+(UIColor*)greenButton
{
    return [UIColor colorWithRed:77.0/255 green:160.0/255 blue:40.0/255 alpha:1];
}

+(UIColor*)greenNavi
{
    return [UIColor colorWithRed:77.0/255 green:145.0/255 blue:205.0/255 alpha:1];
}

+(void)buttonGeneral:(UIButton *)button
{
    [button setFrame:CGRectMake(button.frame.origin.x, button.frame.origin.y, button.frame.size.width, 35)];
    button.layer.cornerRadius =4.0;
    [button.layer setMasksToBounds:YES];
    [button setBackgroundColor:[UIColor whiteColor]];
    button.layer.borderColor =[[UIColor whiteColor] CGColor];
    
    
}

+(void)textFieldGeneral:(UITextField *)textField
{
    [textField setFrame:CGRectMake(textField.frame.origin.x, textField.frame.origin.y, textField.frame.size.width, 35)];
    textField.layer.cornerRadius =4.0;
    [textField.layer setMasksToBounds:YES];
    [textField setBackgroundColor:[UIColor whiteColor]];
    textField.layer.borderColor =[[UIColor whiteColor] CGColor];
}






+(void)textField:(UITextField*)textField
{
    textField.layer.cornerRadius =2.0;
    [textField.layer setMasksToBounds:YES];
    [textField setBackgroundColor:[UIColor whiteColor]];
    textField.layer.borderColor =[[UIColor whiteColor] CGColor];
}
+(UIColor*)settingBlueRecord
{
    return [UIColor colorWithRed:215.0/255 green:226.0/255 blue:246.0/255 alpha:1];
}
+(UIColor*)settingWhiteRecord
{
    //return [UIColor colorWithRed:210.0/255 green:220.0/255 blue:237.0/255 alpha:1];
    
    return [UIColor whiteColor];
}


+(void)navigationDesign:(UINavigationController *)navi
{
    navi.navigationBar.barTintColor = [UIColor colorWithRed:50.0/255 green:130.0/255 blue:200.0/255 alpha:1];
    [navi .navigationBar setTintColor:[UIColor whiteColor]];
    
    [navi.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    //navi.navigationBar.translucent = YES;
    
}

+(void)containView:(UIView *)view
{
    [Interface boderView:7 andwidth:2.0 andColor:[UIColor colorWithRed:160.0/255 green:190.0/255 blue:210.0/255 alpha:1] andView:view];
    [view setBackgroundColor:[UIColor colorWithRed:110.0/255 green:160.0/255 blue:200.0/255 alpha:1]];
}
+(void)buttonStyleWithGreenColor:(UIButton*)button
{
    [button setBackgroundColor:[UIColor colorWithRed:77.0/255 green:160.0/255 blue:40.0/255 alpha:1]];
    button.layer.cornerRadius =4;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}



+(void)setBackground:(UIView*)view
{
    
}



+(void)pickerDesign:(UIDatePicker *)datePicker
{
    [datePicker setBackgroundColor:[UIColor whiteColor]];
    [datePicker.layer setCornerRadius:4];
    [datePicker.layer setBorderWidth:2];
}


+(void)textFieldInSettingStyle:(UITextField*)textField andSupperView:(UIView*)view;
{
    [Interface boderView:6 andwidth:1 andColor:[UIColor clearColor] andView:textField];
    [textField setBackgroundColor:[UIColor clearColor]];
    [textField setTextColor:[UIColor whiteColor]];
}
+(void)buttonInSettingStyle:(UIButton*)button andSupperView:(UIView*)view
{
    [Interface boderView:6 andwidth:1 andColor:[UIColor clearColor] andView:button];
    [button setBackgroundColor:[UIColor clearColor]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}

+(UIView *)roundCornersOnView:(UIView *)view onTopLeft:(BOOL)tl topRight:(BOOL)tr bottomLeft:(BOOL)bl bottomRight:(BOOL)br radius:(float)radius {
    
    if (tl || tr || bl || br) {
        UIRectCorner corner = 0; //holds the corner
        if (tl) {
            corner = corner | UIRectCornerTopLeft;
        }
        if (tr) {
            corner = corner | UIRectCornerTopRight;
        }
        if (bl) {
            corner = corner | UIRectCornerBottomLeft;
        }
        if (br) {
            corner = corner | UIRectCornerBottomRight;
        }
        
        UIView *roundedView = view;
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:roundedView.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.frame = roundedView.bounds;
        maskLayer.path = maskPath.CGPath;
        roundedView.layer.mask = maskLayer;
        roundedView.layer.borderWidth=2;
        return roundedView;
    } else {
        return view;
    }
}



@end
