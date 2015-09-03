//
//  BuyerRequetstTicket.m
//  SeatFillers
//
//  Created by LeDung on 6/14/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import "BuyerRequetstTicket.h"
#import "AFHTTPRequestOperationManager.h"
#import "SEConfig.h"
@interface BuyerRequetstTicket ()

@end

@implementation BuyerRequetstTicket

- (void)viewDidLoad {
    [super viewDidLoad];
    [self seatFillerDesign];
    [self fillData];
    [self setMap];
    
}
-(void)seatFillerDesign
{
    [self.mainScroll setContentSize:CGSizeMake([Interface screedWidth], self.view.frame.size.height *1.8f)];
    self.title = @"Buyer Ticket Request";
    [Interface boderView:4 andwidth:2 andColor:[SeatFillerDesign greenNavi] andView:self.containView];
    [self.containView setBackgroundColor:[UIColor clearColor]];
    
    [Interface boderView:4 andwidth:2 andColor:[SeatFillerDesign greenNavi] andView:self.btAttachFile];
    self.btAttachFile.layer.borderWidth=1.0;
    [self.btAttachFile setBackgroundColor:[SeatFillerDesign greenNavi]];
}

-(NSString*)timeFormatter:(NSString*)stringTime
{
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"HH:mm:ss"];
    NSDate *oldTime =[timeFormatter dateFromString:stringTime];
    NSDateFormatter *newTimeFormatter =[[NSDateFormatter alloc]init];
    [newTimeFormatter setDateFormat:@"hh:mm:a"];
    NSString* newStringTime =[newTimeFormatter stringFromDate:oldTime];
    return newStringTime;
}
-(NSString*)dateFormater:(NSString*)stringDay// MMM dd, yyyy
{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *newDate = [dateFormatter dateFromString:stringDay];
    NSDateFormatter *newDateFormatter = [[NSDateFormatter alloc] init];
    [newDateFormatter setDateFormat:@"MMM dd, yyyy"];
    return  [newDateFormatter stringFromDate:newDate];
}


-(void)fillData
{
    self.app = [[UIApplication sharedApplication]delegate];
    self.lbUsernameVL.text = self.seatTicket.byUser;
    self.lbTicketrequest.text= [NSString stringWithFormat:@"Ticket(s) Request by %@:",self.app.seatUser.userName];
    self.lbEventTypeVl.text = self.seatTicket.typeName;
    self.lbEventVl.text = self.seatTicket.title;
    ;
    self.lbDateTimeVl.text = [NSString stringWithFormat:@"%@, %@",[self dateFormater:self.seatTicket.startDate],[self timeFormatter:self.seatTicket.starTime]];
    self.lbEventLocationVl.text =[NSString stringWithFormat:@"%@, %@",[self.seatTicket.city stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]],self.seatTicket.state];
    self.tvNote.text = self.seatTicket.note;
    
    
    [self timeFormatter:self.seatTicket.starTime];
    self.lbPriceRange.text = [@"$" stringByAppendingString: self.seatTicket.priceRange];
    self.lbTixOnHand.text = self.seatTicket.qty;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setMap{
    self.myMap.delegate = self;
    MKPointAnnotation *annotation =[[MKPointAnnotation alloc]init];
    annotation.coordinate = CLLocationCoordinate2DMake(self.seatTicket.lat.floatValue, self.seatTicket.lng.floatValue);
    annotation.title = self.seatTicket.address;
    
    [self.myMap addAnnotation:annotation];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(self.seatTicket.lat.floatValue, self.seatTicket.lng.floatValue), 1000, 1000);
    [self.myMap setRegion:region];
}

- (IBAction)btStep:(id)sender {
    self.lbQlt.text = [NSString stringWithFormat:@"%d",(int)self.btStepper.value];
}

- (IBAction)btPhotoPress:(id)sender {
    NSString *linkPhoto = self.seatTicket.imageURLString;
    if([[NSString stringWithFormat:@"%@",linkPhoto] isEqualToString:@"<null>"])
    {
        [SeatService alertFail:@"NO Photos Availble" andTitle:@"No Photo"];
    }else {
        SellerImage *sellerImage = [[SellerImage alloc]init];
        [self.navigationController pushViewController:sellerImage animated:YES];
        [[NSUserDefaults standardUserDefaults]setObject:[self null2Empty:self.seatTicket.imageURLString] forKey:PHOTO_LINK];
    }
}

- (IBAction)btSubmitNotification:(id)sender {
    [self submitNotificationToSeller];
}
- (void)submitNotificationToSeller{
    int quanlityBook = self.lbQlt.text.intValue;
    if (quanlityBook<=self.seatTicket.qty.intValue) {
        //submit
        NSString *link = [NSString stringWithFormat:@"%@%@",API_SUBMIT_TICKET,self.app.seatUser.token];
        NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
        [param setObject:self.seatTicket.sId forKey:@"id"];
        [param setObject:self.lbQlt.text forKey:@"qty"];
        
        AFHTTPRequestOperationManager *af = [AFHTTPRequestOperationManager manager];
        af.requestSerializer = [AFHTTPRequestSerializer serializer];
        af.responseSerializer = [AFHTTPResponseSerializer serializer];
        [af POST:link parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            if (operation.response.statusCode==200) {
                NSDictionary *dicResult = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                NSString *result = dicResult[@"status"];
                if (result.intValue==1) {
                    [SeatService alertFail:@"Request Submitted Successfully" andTitle:@""];
                    [SEConfig postNotify:NOTIFICATION_KEY_SUMMIT_TICKET];
                    NSUInteger ownIndex = [self.navigationController.viewControllers indexOfObject:self];
                    if (self.fromBuyerHome) {
                        [self.navigationController popViewControllerAnimated:YES];
                        
                    }else {
                        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:ownIndex - 3] animated:YES];
                    }
                }else {
                }
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [SeatService alertFail:@"Can't connect to server, Try again later" andTitle:@"Error"];
        }];
        
    }else {
        [SeatService alertFail:@"Your request is greater on ticket on hand" andTitle:@"Error"];
    }
}
-(NSString*)null2Empty:(NSString*)string
{
    if([[NSString stringWithFormat:@"%@", string] isEqualToString:@"<null>"])
    {
        return @"";
    }
    return [NSString stringWithFormat:@"%@",string];
}
@end
