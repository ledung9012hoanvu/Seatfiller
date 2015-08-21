//
//  BuyerListChat.m
//  SeatFillers
//
//  Created by phan hoang quoc an on 7/29/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import "BuyerListChat.h"
#import "BuyerHome.h"

@interface BuyerListChat ()

@end

@implementation BuyerListChat

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpInterFace];
    self.buyerHome =self.tabBarController.viewControllers[0];
    [self fillData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fillData) name:NOTIFICATION_KEY_CHANGE_TICKET object:nil];
}
- (void)setUpInterFace{
    self.navigationItem.title = @"Buyer Chatting";
    [SeatFillerDesign viewGeneralWithBlueHeader:self.tbLishChat];
}
- (void)fillData
{
    self.arrayUserChat =[NSMutableArray arrayWithArray:self.buyerHome.ticketArray];
    [self.tbLishChat reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cellChat"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellChat"];
    }
    SeatTicket *unitSeatTicket = self.arrayUserChat[indexPath.row];
    cell.textLabel.text = unitSeatTicket.byUser;
    return cell;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayUserChat.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BuyerChatDetail *buyerChatDe = [[BuyerChatDetail alloc]init];
    buyerChatDe.seatic = self.arrayUserChat[indexPath.row];
    [self.navigationController pushViewController:buyerChatDe animated:YES];
}


@end
