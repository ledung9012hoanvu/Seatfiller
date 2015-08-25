//
//  ViewController.m
//  MKLocalSearch-Example
//
//  Created by Victor Kristof on 19.09.14.
//  Copyright (c) 2014 Victor Krisotf. All rights reserved.
//

#import "SellerMap.h"

@interface SellerMap ()

- (void) setupLocationManager;
- (BOOL) enableLocationServices;
- (void) setupSearchController;
- (void) setupSearchBar;
- (void) searchQuery:(NSString *)query;

@end

@implementation SellerMap

@synthesize searchController;
@synthesize localSearch;
@synthesize results;
@synthesize mapView;
@synthesize locationManager;

- (void) viewDidLoad {
    [super viewDidLoad];
    self.title = @"Map";
    
    self.edgesForExtendedLayout = UIRectEdgeLeft | UIRectEdgeBottom | UIRectEdgeRight;
    [self.navigationController.view setBackgroundColor:[UIColor whiteColor]];
    
    
    // Set up search operators
    [self setupSearchController];
    [self setupSearchBar];
    
    self.definesPresentationContext = YES;
    if (self.isEdit) {
        self.lbAddress.text = self.address;
        MKCoordinateRegion region =MKCoordinateRegionMake(CLLocationCoordinate2DMake(self.lat.floatValue, self.lng.floatValue), MKCoordinateSpanMake(1.0f, 1.0f));
        [self.mapView setRegion:region];
        
    }else {
        [self setupLocationManager];
        locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        locationManager.distanceFilter=kCLDistanceFilterNone;
        [locationManager requestWhenInUseAuthorization];
        [locationManager startMonitoringSignificantLocationChanges];
        [self.locationManager startUpdatingLocation];
    }
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    UIBarButtonItem *btDone = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(btDonePress)];
    self.navigationItem.rightBarButtonItem = btDone;
    
}
- (void)btDonePress{
    NSLog(@"press Done");
    self.addEvent.selectedAddress = self.address;
    
    self.addEvent.selectedLat = self.lat;
    self.addEvent.selectedLng = self.lng;
    self.addEvent.isBack = YES;
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    __block BOOL update;
    if (update==NO) {
        CLLocation *currentLocation = [locations lastObject];
        CLGeocoder *ceo = [[CLGeocoder alloc]init];
        [ceo reverseGeocodeLocation:currentLocation completionHandler:^(NSArray *placemarks, NSError *error) {
            
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            
            self.lbAddress.text = [NSString stringWithFormat:@"%@ %@",[self null2Empty:placemark.name],[self null2Empty:placemark.locality]];
            self.lat = [NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude];
            self.lng = [NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude];
            update = YES;
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) setupSearchController {
    
    // The TableViewController used to display the results of a search
    UITableViewController *searchResultsController = [[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
    searchResultsController.automaticallyAdjustsScrollViewInsets = NO; // Remove table view insets
    searchResultsController.tableView.dataSource = self;
    searchResultsController.tableView.delegate = self;
    
    // Initialize our UISearchController
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:searchResultsController];
    self.searchController.delegate = self;
    self.searchController.searchBar.delegate = self;
    
}
- (void)mapViewDidFinishLoadingMap:(MKMapView *)mapView{
    NSLog(@"did finish");
    
}
- (void)mapViewDidFinishRenderingMap:(MKMapView *)mapView fullyRendered:(BOOL)fullyRendered{
    NSLog(@"did finish render");
}
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    CLGeocoder *ceo = [[CLGeocoder alloc]init];
    CLLocationCoordinate2D coordinate = self.mapView.region.center;
    CLLocation *loca = [[CLLocation alloc]initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    [ceo reverseGeocodeLocation:loca completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        self.lat = [NSString stringWithFormat:@"%f",coordinate.latitude];
        self.lng = [NSString stringWithFormat:@"%f",coordinate.longitude];
        self.address = [NSString stringWithFormat:@"%@ %@",[self null2Empty:placemark.name],[self null2Empty:placemark.locality]];
        self.lbAddress.text = self.address;
    }];
}

-(void) setupSearchBar {
    
    // Set search bar dimension and position
    CGRect searchBarFrame = self.searchController.searchBar.frame;
    CGRect viewFrame = self.view.frame;
    self.searchController.searchBar.frame = CGRectMake(searchBarFrame.origin.x,
                                                       searchBarFrame.origin.y,
                                                       viewFrame.size.width,
                                                       44.0);
    
    // Add SearchController's search bar to our view and bring it to front
    [self.view addSubview:self.searchController.searchBar];
    [self.view bringSubviewToFront:self.searchController.searchBar];
    
}

- (BOOL) enableLocationServices {
    
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager.distanceFilter = 10;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        [self.locationManager startUpdatingLocation];
        [self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
        return YES;
    } else {
        return NO;
    }
}

- (void) setupLocationManager {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    // Will call locationManager:didChangeAuthorizationStatus: delegate method
    [CLLocationManager authorizationStatus];
}

- (void) locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    NSString *message = @"You must enable Location Services for this app in order to use it.";
    NSString *button = @"Ok";
    NSString *title;
    
    if (status == kCLAuthorizationStatusDenied) {
        title = @"Location Services Disabled";
        [[[UIAlertView alloc] initWithTitle:title
                                    message:message
                                   delegate:self
                          cancelButtonTitle:nil
                          otherButtonTitles:button, nil] show];
    } else if(status == kCLAuthorizationStatusRestricted) {
        title = @"Location Services Restricted";
        [[[UIAlertView alloc] initWithTitle:title
                                    message:message
                                   delegate:self
                          cancelButtonTitle:nil
                          otherButtonTitles:button, nil] show];
    } else if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        // Note: kCLAuthorizationStatusAuthorizedWhenInUse depends on the request...Authorization
        // (Always or WhenInUse)
        if ([self enableLocationServices]) {
            NSLog(@"Location Services enabled.");
        } else {
            NSLog(@"Couldn't enable Location Services. Please enable them in Settings > Privacy > Location Services.");
        }
    } else if (status == kCLAuthorizationStatusNotDetermined) {
        NSLog(@"Error : Authorization status not determined.");
        [self.locationManager requestWhenInUseAuthorization];
    }
}

- (void)searchQuery:(NSString *)query {
    // Cancel any previous searches.
    [self.localSearch cancel];
    
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = query;
    //request.region = self.mapView.region;
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    self.localSearch = [[MKLocalSearch alloc] initWithRequest:request];
    
    [self.localSearch startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error){
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        if (error != nil) {
            [[[UIAlertView alloc] initWithTitle:@"Map Error"
                                        message:[error description]
                                       delegate:nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil] show];
            return;
        }
        
        
        self.results = response;
        
        [[(UITableViewController *)self.searchController.searchResultsController tableView] reloadData];
    }];
}

-(void)willPresentSearchController:(UISearchController *)aSearchController {
    
    aSearchController.searchBar.bounds = CGRectInset(aSearchController.searchBar.frame, 0.0f, 0.0f);
    if (CGRectIsEmpty(_searchTableViewRect)) {
        CGRect tableViewFrame = ((UITableViewController *)aSearchController.searchResultsController).tableView
        .frame;
        tableViewFrame.origin.y = tableViewFrame.origin.y + 64; //status bar (20) + nav bar (44)
        tableViewFrame.size.height =  tableViewFrame.size.height;
        
        _searchTableViewRect = tableViewFrame;
    }
    
    [((UITableViewController *)aSearchController.searchResultsController).tableView setFrame:_searchTableViewRect];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if (![searchText isEqualToString:@""]) {
        [self searchQuery:searchText];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)aSearchBar {
    [self searchQuery:aSearchBar.text];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.results.mapItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *IDENTIFIER = @"SearchResultsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:IDENTIFIER];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:IDENTIFIER];
    }
    
    MKMapItem *item = self.results.mapItems[indexPath.row];
    
    cell.textLabel.text = item.placemark.name;
    cell.detailTextLabel.text = item.placemark.addressDictionary[@"Street"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     [self setupLocationManager];
    

    [self.searchController setActive:NO];
    
    MKMapItem *item = self.results.mapItems[indexPath.row];
    
   // [self.mapView addAnnotation:item.placemark];
    [self.mapView selectAnnotation:item.placemark animated:YES];
    [self.mapView setCenterCoordinate:item.placemark.location.coordinate animated:YES];
    [self.mapView setUserTrackingMode:MKUserTrackingModeNone];
    
}
-(NSString*)null2Empty:(NSString*)string
{
    if([[NSString stringWithFormat:@"%@", string] isEqualToString:@"(null)"])
    {
        return @" ";
    }
    return [NSString stringWithFormat:@"%@",string];
}


@end
