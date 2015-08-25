//
//  BuyerRequetstTicket.h
//  SeatFillers
//
//  Created by LeDung on 6/14/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeatFillerDesign.h"
#import "SeatTicket.h"
#import "AppDelegate.h"
#import "BuyerRequetstTicket.h"
#import "SellerImage.h"
#import "SeatService.h"
#import "BuyerHome.h"

#import <MapKit/MapKit.h>

@interface BuyerRequetstTicket : UIViewController<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *mainScroll;

@property (weak, nonatomic) IBOutlet UILabel *lbTicketrequest;
@property (weak, nonatomic) IBOutlet UILabel *lbQlt;
@property (weak, nonatomic) IBOutlet UILabel *lbUsernameVL;
@property (weak, nonatomic) IBOutlet UILabel *lbEventTypeVl;
@property (weak, nonatomic) IBOutlet UILabel *lbEventVl;
@property (weak, nonatomic) IBOutlet UILabel *lbEventLocationVl;
@property (weak, nonatomic) IBOutlet UILabel *lbDateTimeVl;
@property (weak, nonatomic) IBOutlet UILabel *lbPriceRange;
@property (weak, nonatomic) IBOutlet UITextView *tvNote;
@property (weak, nonatomic) IBOutlet UILabel *lbTixOnHand;
@property (weak, nonatomic) IBOutlet MKMapView *myMap;
@property (weak, nonatomic) IBOutlet UIStepper *myStepper;
@property (weak, nonatomic) IBOutlet UIView *containView;

@property (strong,nonatomic) AppDelegate *app;
@property (weak, nonatomic) IBOutlet UIStepper *btStepper;





@property(nonatomic,strong) SeatTicket *seatTicket;
@property (nonatomic) BOOL fromBuyerHome;



- (IBAction)btStep:(id)sender;
- (IBAction)btPhotoPress:(id)sender;
- (IBAction)btSubmitNotification:(id)sender;



@end
