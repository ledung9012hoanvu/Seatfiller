//
//  SellerHome.m
//  SeatFillers
//
//  Created by LeDung on 6/11/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import "SellerHome.h"
#import "SeatService.h"
#import "SeatTicket.h"
#import "SeatUser.h"
#import "SeatService.h"
#import "AppDelegate.h"
#import "ListTicketCell.h"
#import "Interface.h"
#import "SeatFillerDesign.h"
#import "SellerAddEvent.h"
#import "SeatMacro.h"
#import "SellerReview.h"
#import "ChattingList.h"
#import "ListUserChat.h"

@interface SellerHome ()
@property (strong,nonatomic) SeatTicket *seatic;
@property (strong,nonatomic) AppDelegate *appDelegate;
@end

@implementation SellerHome

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self seatFillerDesign];
    _tbListTicket.separatorStyle=UITableViewCellSeparatorStyleNone;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
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
    [cell setFrame:CGRectMake(0, 0, self.tbListTicket.frame.size.width, 60)];
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
    [cell setFrame:CGRectMake(0, 0, self.tbListTicket.frame.size.width, 50)];
    
    CGFloat lbWidth = self.tbListTicket.frame.size.width/7-2;
    [cell.lbName setFrame:CGRectMake(  lbWidth*0,0,lbWidth, 60)];
    [cell.lbDescription setFrame:CGRectMake(  lbWidth*1,0,lbWidth, 60)];
    [cell.lbDate setFrame:CGRectMake(  lbWidth*2,0,lbWidth, 60)];
    [cell.lbTime setFrame:CGRectMake(lbWidth*3,0,lbWidth, 60)];
    [cell.lbLocation setFrame:CGRectMake(lbWidth*4,0,lbWidth, 60)];
    [cell.lbTixOnHane setFrame:CGRectMake(lbWidth*5,0,lbWidth, 60)];
    [cell.lbRange setFrame:CGRectMake(lbWidth*6,0,lbWidth, 60)];
    return cell;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGFloat width = self.tbListTicket.frame.size.width;
    UIView *headerView =[[UIView alloc]init];
    [headerView setFrame:CGRectMake(0, 0, width, 60)];
    
    UILabel *fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, headerView.frame.size.width, 21)];
    [fromLabel setFont:[UIFont systemFontOfSize:12]];
    if (self.ticketArray.count>0) {
        SeatTicket *seatTic = self.ticketArray[0];
        fromLabel.text = [NSString stringWithFormat:@" %@ Ticket Postings Availabel Until:%@",self.appDelegate.seatUser.lastName,seatTic.expiryDate];
    }
    fromLabel.numberOfLines = 1;
    fromLabel.adjustsFontSizeToFitWidth = YES;
    fromLabel.minimumScaleFactor = 10.0f/12.0f;
    fromLabel.clipsToBounds = YES;
    fromLabel.backgroundColor = [UIColor clearColor];
    fromLabel.textColor = [UIColor blackColor];
    fromLabel.textAlignment = NSTextAlignmentLeft;
    [headerView addSubview:fromLabel];
    
    CGFloat lbWidth =width/7-2;
    for(int i = 0 ; i < 7;i++)
    {
        UILabel *label = [[UILabel alloc]init];
        [label setFrame:CGRectMake(i*lbWidth, 30, lbWidth, 30)];
        [label setTextColor:[UIColor whiteColor]];
        label.lineBreakMode = NSLineBreakByWordWrapping;
        label.numberOfLines = 2;
        [label setTextAlignment:NSTextAlignmentCenter];
        [headerView addSubview: label];
        switch (i) {
            case 0:
                label.text = @"Event Type";
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
    [headerView setBackgroundColor:[SeatFillerDesign greenNavi]];
    return headerView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    self.selectedRow = indexPath.row;
    SeatTicket *ticket = self.ticketArray[self.selectedRow];
    UIAlertView *alertPopUp = [[UIAlertView alloc]initWithTitle:ticket.title message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Interested Buyers",@"Delete",@"Edit", nil];
    alertPopUp.tag = 100;
    [alertPopUp show];
    
}
- (void)goToAddEvent:(long)index{
    
    SellerReview *sellReview = [[SellerReview alloc]init];
    sellReview.seatTicket = self.ticketArray[index];
    [self.navigationController pushViewController:sellReview animated:YES];
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}

-(void)fillData
{
    self.ticketArray =[[NSMutableArray alloc]init];
    self.appDelegate =[[UIApplication sharedApplication]delegate];
    [SeatService callWebserviceAtRequestPOST:NO andApi:SeatAPIGetListTicket withParameters:[SeatUser dictionaryFromSeatUser:self.appDelegate.seatUser] onSuccess:^(SeatServiceResult *result) {
        NSArray *dicArr=[result.dictionaryResponse objectForKey:@"data"];
        if (dicArr.count!=0) {
            for (int i=0; i<dicArr.count; i++) {
                NSMutableDictionary *dic=[dicArr objectAtIndex:i];
                SeatTicket *seatObj=[SeatTicket ticketFromDictionary:dic];
                [self.ticketArray addObject:seatObj];
                seatObj =nil;
                dic=nil;
            }
            self.appDelegate.ListArray = self.ticketArray;
            [_tbListTicket reloadData];
        }
    } onFailure:^(NSError *err) {
        
    }];
    
}

-(void)seatFillerDesign
{
    [Interface boderView:4 andwidth:2 andColor:[SeatFillerDesign greenNavi] andView:self.tbListTicket];
    [self.tbListTicket setBackgroundColor:[UIColor clearColor]];
}


-(void)viewWillDisappear:(BOOL)animated
{
    self.tabBarController.navigationItem.rightBarButtonItem =nil;
    [self.tabBarController setTitle:@""];
}
-(void)viewWillAppear:(BOOL)animated
{
    UIBarButtonItem *add =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(goToAdd)];
    [add setTintColor:[UIColor whiteColor]];
    self.tabBarController.navigationItem.rightBarButtonItem =add;
    
    [super viewWillAppear:animated];
    [self.tabBarController setTitle:@"Seller"];
    
    self.navigationController.navigationBarHidden=NO;
    if (self.ticketArray!=nil) {
        self.ticketArray = nil;
        self.ticketArray = [[NSMutableArray alloc]init];
    }
    
    [self fillData];
    [_tbListTicket reloadData];
}
- (void)goToAdd{
    
    SellerAddEvent *add =[[SellerAddEvent alloc]init];
    [self.navigationController pushViewController:add animated:YES];
}

- (IBAction)btReportPress:(id)sender {
    UIAlertView *alertReport =[[UIAlertView alloc]initWithTitle:@"Do you still want to report a user?" message:@"Please review Seat Fillers Terms of Use Policy. If you feel the Seat Fillers' user has violated the terms specifically based on Paragraph 9, section d, please report this user" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    alertReport.tag = 102;
    [alertReport show];
}
#pragma Alert View
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==100) {
        switch (buttonIndex) {
            case 3:
                NSLog(@"nhan 3");//edit
                [self goToAddEvent:self.selectedRow];
                break;
            case 1:
                NSLog(@"nhan Interested");//Interested buyers
            {
                SeatTicket *seatTic = self.ticketArray[self.selectedRow];
                if (seatTic.interested.intValue>0) {
                    ListUserChat *listUserChat = [[ListUserChat alloc]init];
                    listUserChat.ticket_id = seatTic.sId;
                    listUserChat.title = seatTic.title;
                    [self.navigationController pushViewController:listUserChat animated:YES];
                }
            }
                break;
            case 2:
            {
                UIAlertView *alertDelete = [[UIAlertView alloc]initWithTitle:@"Do you want to Delete this ticket" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete", nil];
                alertDelete.tag = 101;
                [alertDelete show];
            }
            default:
                break;
        }
    }
    if (alertView.tag==101) {//delete
        if (buttonIndex==1) {
            //NSLog(@"click delete");
            self.seatic = self.ticketArray[self.selectedRow];
            AppDelegate *app = [[UIApplication sharedApplication]delegate];
            NSString *link = [NSString stringWithFormat:@"%@%@%@&id=%@",SEATSEVERADDRESS,API_DELETE_TICKET,app.seatUser.token,self.seatic.sId];
            AFHTTPRequestOperationManager *af = [AFHTTPRequestOperationManager manager];
            af.requestSerializer = [AFHTTPRequestSerializer serializer];
            af.responseSerializer = [AFHTTPResponseSerializer serializer];
            [af POST:link parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSDictionary *dicResult = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                NSString *result = dicResult[@"status"];
                if (result.integerValue==1) {
                    NSLog(@"delete thanh cong");
                    if (self.ticketArray!=nil) {
                        self.ticketArray = nil;
                        self.ticketArray = [[NSMutableArray alloc]init];
                    }
                    
                    [self fillData];
                    [_tbListTicket reloadData];
                    
                }else {
                    [self alertFail:@"Delete Error" andTitle:@"Error"];
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [self alertFail:[NSString stringWithFormat:@"%@",error.localizedDescription] andTitle:@"Error"];
                
            }];
        }
    }
    if (alertView.tag==102) {//alert report
        if (buttonIndex==1) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
            AppDelegate *app = [[UIApplication sharedApplication]delegate];
            NSString *linkReport = [NSString stringWithFormat:@"%@%@%@",SEATSEVERADDRESS,API_REPORT,app.seatUser.token];
            AFHTTPRequestOperationManager *af = [AFHTTPRequestOperationManager manager];
            af.requestSerializer = [AFHTTPRequestSerializer serializer];
            af.responseSerializer = [AFHTTPResponseSerializer serializer];
            [af GET:linkReport parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                if (operation.response.statusCode==200) {
                    NSDictionary *dicResult = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                    NSString *result = dicResult[@"status"];
                    if (result.integerValue==1) {//Please check your email to confirm your request.
                        [self alertFail:@"Please check your email to confirm your request." andTitle:@"Report Buyer"];
                        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                    }
                }else{
                    NSLog(@"error status code");
                    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                [self alertFail:[NSString stringWithFormat:@"%@",error.localizedDescription] andTitle:@"Report Error"];
            }];
        }
        else {//alert click NO
        }
    }
}
- (void)alertFail:(NSString*)message andTitle:(NSString*)title{
    UIAlertView *alertUpdate = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertUpdate show];
}
@end
