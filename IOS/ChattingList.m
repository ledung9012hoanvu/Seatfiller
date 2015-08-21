//
//  ChattingList.m
//  SeatFillers
//
//  Created by Hoan Vu  on 6/22/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import "ChattingList.h"
#import "ChatHistoryCell.h"
#import "ChatDetail.h"
#import "ListUserChat.h"

@interface ChattingList () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation ChattingList

- (void)viewDidLoad {
    [super viewDidLoad];
    [SeatFillerDesign viewGeneralWithBlueHeader:self.mTableView];
    _chatHistoryArr=[NSMutableArray array];
    [self initData];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController setTitle:@"Chatting List"];
    self.navigationController.navigationBarHidden=NO;
}


-(void)initData{
    self.app = [[UIApplication sharedApplication]delegate];
    self.chatHistoryArr = self.app.ListArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark-------------------------UITableViewDelegate & DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _chatHistoryArr.count;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"ChatHistotyCell";
    ChatHistoryCell *cell = (ChatHistoryCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ChatHistoryCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    SeatTicket *seatTic = self.chatHistoryArr[indexPath.row];
    cell.eventLabel.text = seatTic.title;
    cell.subTextLabel.text = @"";
    cell.noMessageLabel.text = seatTic.interested;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SeatTicket *seatTic = self.chatHistoryArr[indexPath.row];
    if (seatTic.interested.intValue>0) {
        ListUserChat *listUserChat = [[ListUserChat alloc]init];
        
        listUserChat.ticket_id = seatTic.sId;
        listUserChat.title = seatTic.title;
        [self.navigationController pushViewController:listUserChat animated:YES];
    }
    
    
    
    
}





@end
