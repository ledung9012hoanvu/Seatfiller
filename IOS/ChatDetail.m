//
//  AMViewController.m
//  BubbleTableDemo
//
//  Created by Andrea on 21/01/14.
//  Copyright (c) 2014 Fancy Pixel. All rights reserved.
//

#import "ChatDetail.h"
#import "AFHTTPRequestOperationManager.h"
#import "SeatService.h"
#import "BookMessage.h"
@interface ChatDetail () <AMBubbleTableDataSource, AMBubbleTableDelegate>
@end

@implementation ChatDetail

- (void)viewDidLoad
{

    
    NSLog(@"Book Id : %@",self.bookTic.sid);
    [super viewDidLoad];
    self.app = [[UIApplication sharedApplication]delegate];
    [self setDataSource:self];
    [self setDelegate:self];
    
    [self setTitle:@"Chat"];
    [self setTableStyle:AMBubbleTableStyleFlat];
    [self setBubbleTableOptions:@{AMOptionsBubbleDetectionType: @(UIDataDetectorTypeAll),
                                  AMOptionsBubblePressEnabled: @NO,
                                  AMOptionsBubbleSwipeEnabled: @NO,
                                  AMOptionsButtonTextColor: [UIColor colorWithRed:1.0f green:1.0f blue:184.0f/256 alpha:1.0f]}];
    [self.tableView setContentInset:UIEdgeInsetsMake(64, 0, 0, 0)];
    [self getListComment];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
- (void)getListComment
{
    NSMutableDictionary *dictionary =[[NSMutableDictionary alloc]init];
    [dictionary setValue:self.bookTic.sid forKey:API_KEY_BOOK_ID];
    [dictionary setValue:self.app.seatUser.token forKey:USER_TOKEN];
    [dictionary setValue:self.app.seatUser.type forKey:API_KEY_USER_TYPE];
    [SeatService callWebserviceAtRequestPOST:NO andApi:SeatAPIGetListComment withParameters:dictionary onSuccess:^(SeatServiceResult *result) {
        self.listComment =[NSMutableArray arrayWithArray: [BookMessage arrayFromBookDictionary:result.dictionaryResponse]];
        [self.tableView reloadData];
    } onFailure:^(NSError *err) {
    }];
}


#pragma mark - AMBubbleTableDataSource
- (NSInteger)numberOfRows
{
    return self.listComment.count;
}

- (AMBubbleCellType)cellTypeForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.listComment[indexPath.row][@"type"] intValue];
}

- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.listComment[indexPath.row][@"text"];
}

- (NSDate *)timestampForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self converFromTimeStamp:self.listComment[indexPath.row][@"time"]];
}

- (UIImage*)avatarForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UIImage imageNamed:@"avatar"];
}

#pragma mark - AMBubbleTableDelegate

- (void)didSendText:(NSString*)text
{
    if (text.length==0)return;
    
    NSMutableDictionary*dictionary =[[NSMutableDictionary alloc]init];
    [dictionary setValue:text forKey:@"comment"];
    NSString *recevierId =@"";
    if([self.app.seatUser.type isEqualToString:@"seller"])
    {
        recevierId =self.bookTic.BuyerId;
    }
    else
    {
        recevierId =self.bookTic.sellerId;
    }
    NSString *link =[NSString stringWithFormat:@"%@?token=%@&book_id=%@&recevier=%@&type=%@",API_COMMENT,self.app.seatUser.token,self.bookTic.sid,recevierId,self.app.seatUser.type];
    [SeatService callWebserviceAtRequestPOST:YES andPathoption:link andParams:dictionary onSuccess:^(SeatServiceResult *result)
    {
        BookMessage *unitBookMessage =[[BookMessage alloc]init];
        unitBookMessage.bookId=self.bookTic.sid;
        unitBookMessage.parentId=[[result.dictionaryResponse valueForKey:@"data"] valueForKey:@"recevierId"];
        unitBookMessage.buyerId=self.bookTic.BuyerId;
        unitBookMessage.dateTime =[[result.dictionaryResponse valueForKey:@"data"] valueForKey:@"created"];
        unitBookMessage.buyeNameDisplay=@"ledung";
        unitBookMessage.content=text;
        NSMutableDictionary *dictionary =[BookMessage dictionaryFormBookMessage:unitBookMessage];
        [self.listComment addObject:dictionary];
        [self.tableView reloadData];
        [self scrollToBottomAnimated:NO];

    } onFailure:^(NSError *err) {
    }];
}

- (NSString*)usernameForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.listComment[indexPath.row][@"username"];
}

- (UIColor*)usernameColorForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.listComment[indexPath.row][@"color"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (NSDate*)converFromTimeStamp:(NSString*)timeStamp{
    double time = timeStamp.doubleValue;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    return date;
}

- (void)alertFail:(NSString*)message andTitle:(NSString*)title{
    UIAlertView *alertUpdate = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertUpdate show];
}
@end
