//
//  BuyerSearchResult.m
//  SeatFillers
//
//  Created by LeDung on 6/14/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//We have found 3 Event Seller(s) that closely match your search. Please select a seller below for more information.

#import "BuyerSearchResult.h"
#import "SeatTicket.h"
#import "ListTicketCell.h"
#import "AppDelegate.h"
#import "SeatFillerDesign.h"


@interface BuyerSearchResult ()
@property (nonatomic,strong) AppDelegate *app;

@end

@implementation BuyerSearchResult

- (void)viewDidLoad {
    [super viewDidLoad];
    self.app = [[UIApplication sharedApplication]delegate];
   
    
    
    [self fillData];
    [self setMapView];
    
    [self seatFillerDesign];
    _tbSearchResult.separatorStyle=UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultArray.count;
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
    
    SeatTicket *ticket =self.resultArray [indexPath.row];
    [cell setFrame:CGRectMake(0, 0, self.tbSearchResult.frame.size.width, 60)];
    
    

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
    [cell setFrame:CGRectMake(0, 0, self.tbSearchResult.frame.size.width, 50)];
    
    CGFloat lbWidth = self.tbSearchResult.frame.size.width/7-2;
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
    CGFloat width = self.tbSearchResult.frame.size.width;
    UIView *headerView =[[UIView alloc]init];
    [headerView setFrame:CGRectMake(0, 0, width, 80)];
    [headerView setBackgroundColor:[SeatFillerDesign greenNavi]];
    
    UILabel *fromLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,0, headerView.frame.size.width, 21)];
    fromLabel.text = [NSString stringWithFormat:@"We have found %ld Event Seller(s) that closely match your search. Please select a seller below for more information.",self.resultArray.count];
    //fromLabel.font = customFont;
    fromLabel.numberOfLines = 2;
    [fromLabel setFont:[UIFont systemFontOfSize:11]];
    [fromLabel setTextColor:[UIColor whiteColor]];
    
    fromLabel.adjustsFontSizeToFitWidth = YES;
    //fromLabel.minimumScaleFactor = 10.0f/12.0f;
    fromLabel.clipsToBounds = YES;
    fromLabel.backgroundColor = [UIColor clearColor];
    ///fromLabel.textColor = [UIColor blackColor];
    fromLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:fromLabel];
    
    CGFloat lbWidth =width/7-2;
    for(int i = 0 ; i < 7;i++)
    {
        UILabel *label = [[UILabel alloc]init];
        [label setFrame:CGRectMake(i*lbWidth, 30, lbWidth, 50)];
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
    return headerView;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 60;
//}

//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    UIView *footerView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tbSearchResult.frame.size.width, 60)];
//    UIButton *requestButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    requestButton.backgroundColor=[UIColor blueColor];
//    [requestButton addTarget:self
//               action:@selector(requestBuyer)
//     forControlEvents:UIControlEventTouchUpInside];
//    [requestButton setTitle:@"List" forState:UIControlStateNormal];
//    requestButton.frame = CGRectMake(0, 10, _tbSearchResult.frame.size.width/2, 50);
//    [requestButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    
//    UIButton *mapButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    mapButton.backgroundColor=[UIColor greenColor];
//    [mapButton addTarget:self
//                   action:@selector(searchMapTicket)
//         forControlEvents:UIControlEventTouchUpInside];
//    [mapButton setTitle:@"Map" forState:UIControlStateNormal];
//    mapButton.frame = CGRectMake(requestButton.frame.size.width, 10, _tbSearchResult.frame.size.width/2, 50);
//    [mapButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [footerView addSubview:requestButton];
//    [footerView addSubview:mapButton];
//    
//    return footerView;
//}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 60;
//}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //SeatTicket *seatTicket= self.ticketArray[indexPath.row];
    BuyerRequetstTicket *buyerRequestTicket = [[BuyerRequetstTicket alloc]init];
    buyerRequestTicket.seatTicket = self.resultArray[indexPath.row];
    [self.navigationController pushViewController:buyerRequestTicket animated:YES];
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 70;
}


-(void)fillData
{
    self.title = @"Result";
    self.myMapView.delegate = self;
    
    [self.btList setUserInteractionEnabled:NO];
    [self.btMap setUserInteractionEnabled:YES];
    [self.view bringSubviewToFront:self.tbSearchResult];
    self.tbSearchResult.alpha = 1;
    self.myMapView.alpha =0;
    
    

}
- (void)setMapView{
    NSLog(@"count result array %ld",self.resultArray.count);
    for (int i=0; i<self.resultArray.count; i++) {
        SeatTicket *seatic = self.resultArray[i];
        
        MKPointAnnotation *annotation = [[MKPointAnnotation alloc]init];
        annotation.title = seatic.address;
        annotation.subtitle = seatic.sId;
        
        
        
        
        annotation.coordinate = CLLocationCoordinate2DMake(seatic.lat.floatValue, seatic.lng.floatValue);
        
        [self.myMapView addAnnotation:annotation];
        SeatTicket *seaticMap = self.resultArray[0];
        
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(seaticMap.lat.floatValue, seaticMap.lng.floatValue), 2000, 2000);
        
        [self.myMapView setRegion:region];
        
        
    }
    
}
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    MKPinAnnotationView *annomationView = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"annomation"];
    annomationView.canShowCallout = YES;
    annomationView.highlighted = YES;
    return annomationView;
}
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    //NSLog(@"select");
    MKPointAnnotation *selectAnnotation = view.annotation;
    int idticket = selectAnnotation.subtitle.intValue;
    for (int i=0; i<self.resultArray.count; i++) {
        SeatTicket *seatTic = self.resultArray[i];
        if (seatTic.sId.intValue==idticket) {
            BuyerRequetstTicket *buyerRequestTicket = [[BuyerRequetstTicket alloc]init];
            buyerRequestTicket.seatTicket = seatTic;
            [self.navigationController pushViewController:buyerRequestTicket animated:YES];
            break;
            
        }
    }
    
   
    
    
}


-(void)seatFillerDesign
{
    [self.tbSearchResult setBackgroundColor:[UIColor clearColor]];
    
}

-(void)searchMapTicket{
    
}

-(void)requestBuyer{
    
}


- (IBAction)btListPress:(id)sender {
    [self.view bringSubviewToFront:self.tbSearchResult];
    self.myMapView.alpha = 0;
    self.tbSearchResult.alpha = 1;
    [self.btList setUserInteractionEnabled:NO];
    [self.btMap setUserInteractionEnabled:YES];
    
    
    
}

- (IBAction)btMapPress:(id)sender {
    
    [self.view bringSubviewToFront:self.myMapView];
     //[self.btMap setTranslatesAutoresizingMaskIntoConstraints:YES];
    
    [self.btMap setUserInteractionEnabled:NO];
    [self.btList setUserInteractionEnabled:YES];
    
    self.tbSearchResult.alpha = 0;
    self.myMapView.alpha = 1;
    
    
}
@end
