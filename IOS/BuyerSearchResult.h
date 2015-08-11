//
//  BuyerSearchResult.h
//  SeatFillers
//
//  Created by LeDung on 6/14/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "BuyerRequetstTicket.h"

@interface BuyerSearchResult : UIViewController<UITableViewDataSource,UITableViewDelegate,MKMapViewDelegate,MKAnnotation>
@property(nonatomic,strong) NSMutableArray *resultArray;
@property (weak, nonatomic) IBOutlet UITableView *tbSearchResult;
@property (weak, nonatomic) IBOutlet MKMapView *myMapView;
@property (weak, nonatomic) IBOutlet UIButton *btList;
@property (weak, nonatomic) IBOutlet UIButton *btMap;



- (IBAction)btListPress:(id)sender;
- (IBAction)btMapPress:(id)sender;

@end
