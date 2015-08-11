//
//  SeatFillerDesign.h
//  SeatFillers
//
//  Created by LeDung on 6/11/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Interface.h"
@interface SeatFillerDesign : NSObject
+(void)containView:(UIView*)view;
+(void)setBackground:(UIView*)view;
+(void)buttonStyleWithGreenColor:(UIButton*)button;
+(void)navigationDesign:(UINavigationController*)navi;
+(void)pickerDesign:(UIDatePicker*)datePicker;
+(UIColor*)settingBlueRecord;
+(UIColor*)settingWhiteRecord;
+(void)textField:(UITextField*)textField;
+(void)buttonGeneral:(UIButton*)button;
+(void)textFieldGeneral:(UITextField *)textField;
+(UIColor*)greenNavi;
+(UIColor*)greenButton;
+(void)viewGeneralWithBlueHeader:(UIView*)view;


//-----------
+(void)textFieldInSettingStyle:(UITextField*)textField andSupperView:(UIView*)view;
+(void)buttonInSettingStyle:(UIButton*)button andSupperView:(UIView*)view;

@end
