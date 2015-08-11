//
//  ChatHistoryCell.h
//  SeatFillers
//
//  Created by nhan on 7/3/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChatHistoryObject;
@interface ChatHistoryCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *eventLabel;
@property (nonatomic, weak) IBOutlet UILabel *subTextLabel;
@property (nonatomic, weak) IBOutlet UILabel *noMessageLabel;
+(NSString *)reuseIdentifier;
+(CGFloat)suggestHeight;
@end


@interface UITableView(ChatHistoryCell)

-(void) registerChatHistoryCell;
-(ChatHistoryCell*) chatHistoryCell;

@end

@interface ChatHistoryCell(Convenient)

-(void) loadChatHistoryCell:(ChatHistoryObject*)object;

@end

