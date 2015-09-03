//
//  SellerReview.m
//  SeatFillers
//
//  Created by phan hoang quoc an on 7/16/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import "SellerReview.h"
#import "SellerAddEvent.h"
#import "SeatService.h"



@interface SellerReview ()

@end

@implementation SellerReview

- (void)viewDidLoad {
    [super viewDidLoad];
    [self SetUpInterface];
    [self setMap];
    [self showInformation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)SetUpInterface{
    self.btImage.layer.cornerRadius = 5.0f;
    self.title = @"Seller Review";
    [self.mainScrollView setContentSize:CGSizeMake(self.view.frame.size.width, self.mainScrollView.frame.size.height * 1.5)];
    self.btEdit.layer.cornerRadius=self.btEdit.frame.size.height/2;
    [self.btEdit setBackgroundColor:[SeatFillerDesign greenNavi]];
    [self.btEdit.layer setMasksToBounds:YES];
}
- (void)setMap{
    self.MyMapView.delegate = self;
    MKPointAnnotation *annotation =[[MKPointAnnotation alloc]init];
    annotation.coordinate = CLLocationCoordinate2DMake(self.seatTicket.lat.floatValue, self.seatTicket.lng.floatValue);
    annotation.title = self.seatTicket.address;
    [self.MyMapView addAnnotation:annotation];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake(self.seatTicket.lat.floatValue, self.seatTicket.lng.floatValue), 1000, 1000);
    
    [self.MyMapView setRegion:region];
    
    
    
    
    
}
- (void)showInformation{
    
    NSLog(@"show info");
    self.appDelegate = [[UIApplication sharedApplication]delegate];
    self.lbUserNameVL.text= self.appDelegate.seatUser.userName;
    self.lbEventTypeVl.text = self.seatTicket.typeName;
    self.lbEventVl.text = self.seatTicket.title;
    self.lbDateTimeVl.text = [NSString stringWithFormat:@"%@, %@",self.seatTicket.startDate,[self.seatTicket.starTime substringToIndex:5]];
    self.lbLocationVl.text =[NSString stringWithFormat:@"%@, %@",[self.seatTicket.city stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]],self.seatTicket.state];
    self.lbNotefromSellerVl.text = self.seatTicket.note;
    self.lbPriceRangeVl.text = self.seatTicket.priceRange;
    self.lbTixOnHandVl.text = self.seatTicket.qty;
    
}
- (IBAction)btEditPress:(id)sender {
    NSLog(@"edit press");
    SellerAddEvent *addEvent = [[SellerAddEvent alloc]init];
    addEvent.isEdit = YES;
    addEvent.seatTicket = self.seatTicket;
    [self.navigationController pushViewController:addEvent animated:YES];
    
    
}

- (IBAction)btImagePress:(id)sender {
    NSString *linkPhoto = self.seatTicket.imageURLString;
    NSLog(@"LINK PHOTO %@ ",linkPhoto);
    if([[NSString stringWithFormat:@"%@",linkPhoto] isEqualToString:@"<null>"])
    {
       [SeatService alertFail:@"NO Photos Availble" andTitle:@"No Photo"];
    }else {
        SellerImage *sellerImage = [[SellerImage alloc]init];
        [self.navigationController pushViewController:sellerImage animated:YES];
        
        
        [[NSUserDefaults standardUserDefaults]setObject:[self null2Empty:self.seatTicket.imageURLString] forKey:PHOTO_LINK];
        
    }
    
    
        
    
    
        


   
    
    

    
   
    
}
-(NSString*)null2Empty:(NSString*)string
{
    if([[NSString stringWithFormat:@"%@", string] isEqualToString:@"<null>"])
    {
        return @" ";
    }
    return [NSString stringWithFormat:@"%@",string];
}
@end
