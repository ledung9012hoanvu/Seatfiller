//
//  ChatHistoryCell.m
//  SeatFillers
//
//  Created by nhan on 7/3/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import "ChatHistoryCell.h"
@implementation ChatHistoryCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(NSString *)reuseIdentifier{
    return @"ChatHistoryCell";
}

+(CGFloat)suggestHeight{
    return 60;
}

@end

@implementation UITableView(ChatHistoryCell)

-(void) registerChatHistoryCell{
    [self registerNib:[UINib nibWithNibName:[ChatHistoryCell reuseIdentifier] bundle:nil] forCellReuseIdentifier:[ChatHistoryCell reuseIdentifier]];
}

-(ChatHistoryCell*) chatHistoryCell{
    return [self dequeueReusableCellWithIdentifier:[ChatHistoryCell reuseIdentifier]];
}

@end

@implementation ChatHistoryCell(Convenient)

-(void) loadChatHistoryCell:(ChatHistoryObject*)object{
}

@end
