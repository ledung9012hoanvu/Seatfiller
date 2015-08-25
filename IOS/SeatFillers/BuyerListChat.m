//
//  BuyerListChat.m
//  SeatFillers
//
//  Created by phan hoang quoc an on 7/29/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import "BuyerListChat.h"
#import "BuyerHome.h"
#import "ChatDetail.h"
#import "SEConfig.h"
#import "AppDelegate.h"
#import "SeatFillerDesign.h"
@interface BuyerListChat ()
@property(nonatomic,strong)AppDelegate *appDelegate;
@end

@implementation BuyerListChat

- (void)viewDidLoad {
    self.appDelegate =[[UIApplication sharedApplication]delegate];
    [SEConfig logPage:@"BuyerListChat" andFucntion:nil];
    [super viewDidLoad];
    [self setUpInterFace];
    self.buyerHome =self.tabBarController.viewControllers[0];
    [self fillData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fillData) name:NOTIFICATION_KEY_CHANGE_TICKET object:nil];
}
- (void)setUpInterFace{
    self.navigationItem.title = @"Buyer Chatting";
    [SeatFillerDesign viewGeneralWithBlueHeader:self.tbLishChat];
    [self.tbLishChat setSeparatorColor:[UIColor clearColor]];
    [self seatFillerDesign];
    
}

-(void)seatFillerDesign
{
    
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
    
    UIImageView *line =[[UIImageView alloc]initWithFrame:CGRectMake(0, cell.frame.size.height-1, 600, 1)];
    [line setBackgroundColor:[UIColor whiteColor]];
    [cell addSubview: line];
    cell.textLabel.text = unitSeatTicket.byUser;
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayUserChat.count;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatDetail *chatDetail =[[ChatDetail alloc]init];
    SeatTicket *seatTicket = self.arrayUserChat[indexPath.row];
    BookTicket *bookTicket =[[BookTicket alloc]init];
    bookTicket.sid = seatTicket.bookId;
    bookTicket.sellerId=seatTicket.userId;
    bookTicket.BuyerId =self.appDelegate.seatUser.userId;
    bookTicket.byUsername=seatTicket.username;
    chatDetail.bookTic=bookTicket;
    [self.navigationController pushViewController:chatDetail animated:YES];
}


@end
