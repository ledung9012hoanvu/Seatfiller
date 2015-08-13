//
//  BuyerListChat.m
//  SeatFillers
//
//  Created by phan hoang quoc an on 7/29/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import "BuyerListChat.h"


@interface BuyerListChat ()

@end

@implementation BuyerListChat

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpInterFace];
    
    [self fillData];
    
    
    // Do any additional setup after loading the view from its nib.
}
- (void)setUpInterFace{
    self.navigationItem.title = @"Buyer Chatting";
    [SeatFillerDesign viewGeneralWithBlueHeader:self.tbLishChat];
    
    
}
- (void)fillData{
    self.app = [[UIApplication sharedApplication]delegate];
    self.ListBuyerChat = self.app.BuyerTicketArray;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cellChat"];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellChat"];
    }
    SeatTicket *seatic = self.ListBuyerChat[indexPath.row];
    
    cell.textLabel.text = seatic.byUser;
    
    return cell;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.ListBuyerChat.count;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"click buyer chat detail");
    BuyerChatDetail *buyerChatDe = [[BuyerChatDetail alloc]init];
    buyerChatDe.seatic = self.ListBuyerChat[indexPath.row];
    [self.navigationController pushViewController:buyerChatDe animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
