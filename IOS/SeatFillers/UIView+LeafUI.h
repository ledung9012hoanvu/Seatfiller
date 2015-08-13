//
//  UIView+LeafUI.h
//  Minglesome
//
//  Created by Hoan Vu  on 8/7/15.
//  Copyright (c) 2015 Tuan Le. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LeafUI)
@property(nonatomic,assign) CGFloat height;
@property(nonatomic,assign) CGFloat width;
@property(nonatomic,assign) CGFloat xLocation;
@property(nonatomic,assign) CGFloat yLocation;
@property(readonly,assign) CGFloat xTLocation;
@property(nonatomic,assign) CGFloat yTLocation;


-(void)setXTLocation:(CGFloat)xTLocation;

@end
