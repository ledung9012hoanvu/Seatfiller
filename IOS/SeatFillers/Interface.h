//
//  Interface.h
//  FaProject
//
//  Created by LeDung on 1/18/14.
//  Copyright (c) 2014 LeDung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Interface : NSObject



+(NSString*)isNib:(NSString*)nib;
+(void)boderView:(CGFloat)radius andwidth:(CGFloat)width andColor:(UIColor*)color andView:(UIView*)view;
+(CGFloat)screedWidth;
+(void)setFullWidth:(UIView*)view;

@end
