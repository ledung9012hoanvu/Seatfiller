//
//  BuyerHome.m
//  SeatFillers
//
//  Created by LeDung on 6/11/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import "BuyerHome.h"
#import "SeatService.h"
#import "SeatUser.h"
#import "SeatFillerDesign.h"
#import "SeatFillerFlow.h"
#import "SeatService.h"
#import "AppDelegate.h"
#import "SeatTicket.h"
#import "ListTicketCell.h"
#import "BuyerSearch.h"
#import "SellerHome.h"
#import "BuyerRequetstTicket.h"
#import "BuyerChatDetail.h"
#import "SEConfig.h"
@interface BuyerHome () <UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) BuyerRequetstTicket *buyerRequestTicket;


@end

@implementation BuyerHome


- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self seatFillerDesign];
    [self getListTicket];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(submitTicket) name:NOTIFICATION_KEY_SUMMIT_TICKET object:nil];
}
-(void)submitTicket
{
    [self getListTicket];
    [SEConfig postNotify:NOTIFICATION_KEY_CHANGE_TICKET];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
    self.tabBarController.title =@"Buyer Home";
    UIBarButtonItem *btnCancel = [[UIBarButtonItem alloc] initWithTitle:@"Search" style:UIBarButtonItemStyleBordered target:self action:@selector(gotoSearch)];
    self.tabBarController.navigationItem.rightBarButtonItem = btnCancel;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
-(void)gotoSearch
{
    BuyerSearch *search=[[BuyerSearch alloc] init];
    [self.tabBarController.navigationController pushViewController:search animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



#pragma mark-------------------------UITableViewDeletae & DataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.ticketArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"ListTicketCell";
    ListTicketCell *cell = (ListTicketCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ListTicketCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    SeatTicket *ticket =self.ticketArray [indexPath.row];
    [cell setFrame:CGRectMake(0, 0, self.tableViewListTicket.frame.size.width, 60)];
    cell.lbDate.text = ticket.startDate;
    cell.lbName.text =ticket.typeName;
    cell.lbDescription.text=ticket.title;
    cell.lbRange.text =[NSString stringWithFormat:@"$%@",ticket.priceRange];
    cell.lbTime.text =[ticket.starTime substringToIndex:5];
    cell.lbTixOnHane.text =ticket.qty;
    cell.lbLocation.text = [NSString stringWithFormat:@"%@, %@",[ticket.city stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]],ticket.state];
    if(indexPath.row %2 ==0)
    {
        [cell setBackgroundColor:[ListTicketCell whiteColor]];
    }
    else
    {
        [cell setBackgroundColor:[ListTicketCell browColor]];
    }
    [cell setFrame:CGRectMake(0, 0, self.tableViewListTicket.frame.size.width, 50)];
    CGFloat lbWidth = self.tableViewListTicket.frame.size.width/7-2;
    [cell.lbName setFrame:CGRectMake(  lbWidth*0,0,lbWidth, 60)];
    [cell.lbDescription setFrame:CGRectMake(  lbWidth*1,0,lbWidth, 60)];
    [cell.lbDate setFrame:CGRectMake(  lbWidth*2,0,lbWidth, 60)];
    [cell.lbTime setFrame:CGRectMake(lbWidth*3,0,lbWidth, 60)];
    [cell.lbLocation setFrame:CGRectMake(lbWidth*4,0,lbWidth, 60)];
    [cell.lbTixOnHane setFrame:CGRectMake(lbWidth*5,0,lbWidth, 60)];
    [cell.lbRange setFrame:CGRectMake(lbWidth*6,0,lbWidth, 60)];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.seletedIndex = indexPath.row;
    UIAlertView *alertBuy = [[UIAlertView alloc]initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"View Detail",@"Chat With Seller",@"Delete", nil];
    alertBuy.tag = 100;
    [alertBuy show];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGFloat width = self.tableViewListTicket.frame.size.width;
    UIView *headerView =[[UIView alloc]init];
    [headerView setFrame:CGRectMake(0, 0, width, 50)];
    [headerView setBackgroundColor:[SeatFillerDesign greenNavi]];
    
    CGFloat lbWidth =width/7-2;
    for(int i = 0 ; i < 7;i++)
    {
        UILabel *label = [[UILabel alloc]init];
        [label setFrame:CGRectMake(i*lbWidth, 0, lbWidth, 50)];
        [label setTextColor:[UIColor whiteColor]];
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.numberOfLines = 2;
        [label setTextAlignment:NSTextAlignmentCenter];
        
        [headerView addSubview: label];
        switch (i) {
            case 0:
                label.text = @"Event";
                break;
            case 1:
                label.text = @"Event Description";
                break;
            case 2:
                label.text = @"Event Date";
                break;
            case 3:
                label.text = @"Event Time";
                break;
            case 4:
                label.text = @"Event Location";
                break;
            case 5:
                label.text = @"Tix on hand";
                break;
            case 6:
                label.text = @"Price Range";
                break;
        }
        [label setFont:[UIFont systemFontOfSize:10]];
    }
    return headerView;
}

-(void)getListTicket
{
    self.ticketArray =nil;
    self.ticketArray =[[NSMutableArray alloc]init];
    AppDelegate *app =[[UIApplication sharedApplication]delegate];
    self.lbTitle.text = [NSString stringWithFormat:@"%@ has requested tickets for the following events",app.seatUser.userName];
    [SeatService callWebserviceAtRequestPOST:NO andApi:SeatAPIGetListTicket withParameters:[SeatUser dictionaryFromSeatUser:app.seatUser] onSuccess:^(SeatServiceResult *result)
    {
        NSLog(@"-----BuyerHome------GetListTicket : %@",result.dictionaryResponse);
        self.ticketArray =[NSMutableArray arrayWithArray:[SeatTicket arrayTicketFromDictionary:result.dictionaryResponse]];
        [self.tableViewListTicket reloadData];
    } onFailure:^(NSError *err)
    {
    }];
}

-(void)seatFillerDesign
{
    [Interface boderView:4 andwidth:2 andColor:[SeatFillerDesign greenNavi] andView:self.tableViewListTicket];
    [self.tableViewListTicket setBackgroundColor:[UIColor clearColor]];
    _tableViewListTicket.separatorStyle=UITableViewCellSeparatorStyleNone;
}

- (IBAction)btReportSeller:(id)sender {
    UIAlertView *alertReport =[[UIAlertView alloc]initWithTitle:@"Do you still want to report a user?" message:@"Please review Seat Fillers Terms of Use Policy. If you feel the Seat Fillers' user has violated the terms specifically based on Paragraph 9, section d, please report this user" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    alertReport.tag = 102;
    [alertReport show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==102) {//alert report
        if (buttonIndex==1) {
            NSLog(@"alert clik Yes");
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
            AppDelegate *app = [[UIApplication sharedApplication]delegate];
            NSString *linkReport = [NSString stringWithFormat:@"%@%@%@",SEATSEVERADDRESS,API_REPORT,app.seatUser.token];
            //NSLog(@"link report: %@",linkReport);
            AFHTTPRequestOperationManager *af = [AFHTTPRequestOperationManager manager];
            af.requestSerializer = [AFHTTPRequestSerializer serializer];
            af.responseSerializer = [AFHTTPResponseSerializer serializer];
            [af GET:linkReport parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                if (operation.response.statusCode==200) {
                    NSDictionary *dicResult = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                    NSString *result = dicResult[@"status"];
                    if (result.integerValue==1) {//Please check your email to confirm your request.
                        [SeatService alertFail:@"Please check your email to confirm your request." andTitle:@"Report Seller"];
                        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                    }
                }else{
                    NSLog(@"error status code");
                    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                [SeatService alertFail:[NSString stringWithFormat:@"%@",error.localizedDescription] andTitle:@"Report Error"];
            }];
        }
        else {//alert click NO
        }
    }
    if (alertView.tag==100) {
        if (buttonIndex==1) {
            BuyerRequetstTicket *buyerRequest = [[BuyerRequetstTicket alloc]init];
            buyerRequest.seatTicket = self.ticketArray[self.seletedIndex];
            buyerRequest.fromBuyerHome = YES;
            [self.navigationController pushViewController:buyerRequest animated:YES];
        }
        if (buttonIndex==2) {
            BuyerChatDetail *buyerChatDetail = [[BuyerChatDetail alloc]init];
            buyerChatDetail.seatic = self.ticketArray[self.seletedIndex];
            [self.navigationController pushViewController:buyerChatDetail animated:YES];
        }
        if (buttonIndex==3) {
            UIAlertView *alertDelete =[[UIAlertView alloc]initWithTitle:@"DELETE" message:@"Are You Sure Want To Delete?" delegate:self cancelButtonTitle:@"NO" otherButtonTitles:@"YES", nil];
            alertDelete.tag = 101;
            [alertDelete show];
        }
    }
    if (alertView.tag==101) {//delete
        if (buttonIndex==1) {
            [self CancelBookingTicket];
        }
    }

}
- (void)CancelBookingTicket{
    AppDelegate *app =[[UIApplication sharedApplication]delegate];
    SeatTicket *seatTic = self.ticketArray[self.seletedIndex];
    NSString *link =[NSString stringWithFormat:@"http://52.68.134.162/api/ticketbook/cancel?token=%@&book_id=%@",app.seatUser.token,seatTic.bookId];
    AFHTTPRequestOperationManager *af = [AFHTTPRequestOperationManager manager];
    af.requestSerializer = [AFHTTPRequestSerializer serializer];
    af.responseSerializer = [AFHTTPResponseSerializer serializer];
    [af POST:link parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dicResult = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSString *result = dicResult[@"status"];
        if (result.integerValue==1) {
            [SeatService alertFail:@"Cancel Booking" andTitle:@""];
            [self.ticketArray removeObjectAtIndex:self.seletedIndex];
            [self.tableViewListTicket reloadData];
            [[NSNotificationCenter defaultCenter]postNotificationName:NOTIFICATION_KEY_CANCEL_TICKET object:nil];
            
        }else {
            [SeatService alertFail:@"Delete Error" andTitle:@"Error"];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SeatService alertFail:[NSString stringWithFormat:@"%@",error.localizedDescription] andTitle:@"Error"];
    }];
}
@end
