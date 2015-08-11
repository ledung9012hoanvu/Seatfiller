//
//  CollapseClickCell.m
//  CollapseClick
//
//  Created by Ben Gordon on 2/28/13.
//  Copyright (c) 2013 Ben Gordon. All rights reserved.
//

#import "CollapseClickCell.h"

@implementation CollapseClickCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

+ (CollapseClickCell *)newCollapseClickCellWithTitle:(NSString *)title index:(int)index content:(UIView *)content {
    NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"CollapseClickCell" owner:nil options:nil];
    CollapseClickCell *cell = [[CollapseClickCell alloc] initWithFrame:CGRectMake(0, 0, 320, kCCHeaderHeight)];
    cell = [views objectAtIndex:0];

    
    cell.TitleLabel.text = title;
    cell.index = index;
    cell.TitleButton.tag = index;
    cell.ContentView.frame = CGRectMake(cell.ContentView.frame.origin.x, cell.ContentView.frame.origin.y, cell.ContentView.frame.size.width, content.frame.size.height);
    [cell.ContentView addSubview:content];
    
    [cell.ContentView setBackgroundColor:[UIColor clearColor]];
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.TitleView setBackgroundColor:[UIColor clearColor]];
    [cell.backgroundView setBackgroundColor:[UIColor whiteColor]];
    [cell.backgroundView setAlpha:0.1];
    return cell;
}
@end
