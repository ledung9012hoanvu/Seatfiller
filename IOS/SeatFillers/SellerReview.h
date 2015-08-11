//
//  SellerReview.h
//  SeatFillers
//
//  Created by phan hoang quoc an on 7/16/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "SeatTicket.h"
#import "AppDelegate.h"
#import "SellerImage.h"
@interface SellerReview : UIViewController<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@property (weak, nonatomic) IBOutlet UILabel *lbUserNameVL;
@property (weak, nonatomic) IBOutlet UILabel *lbEventTypeVl;
@property (weak, nonatomic) IBOutlet UILabel *lbEventVl;
@property (weak, nonatomic) IBOutlet UILabel *lbLocationVl;
@property (weak, nonatomic) IBOutlet UILabel *lbDateTimeVl;
@property (weak, nonatomic) IBOutlet UILabel *lbPriceRangeVl;
@property (weak, nonatomic) IBOutlet UILabel *lbNotefromSellerVl;
@property (weak, nonatomic) IBOutlet UILabel *lbTixOnHandVl;
@property (weak, nonatomic) IBOutlet MKMapView *MyMapView;
@property (strong,nonatomic) AppDelegate *appDelegate;



//@property(nonatomic,assign) BOOL isUpdate;
@property(nonatomic,strong) SeatTicket * seatTicket;






@property (weak, nonatomic) IBOutlet UIButton *btEdit;
@property (weak, nonatomic) IBOutlet UIButton *btImage;






- (IBAction)btEditPress:(id)sender;
- (IBAction)btImagePress:(id)sender;



@end
