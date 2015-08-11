#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "SellerAddEvent.h"

@interface SellerMap : UIViewController <	UISearchBarDelegate,
UISearchControllerDelegate,
CLLocationManagerDelegate,
UITableViewDataSource,
UITableViewDelegate,MKMapViewDelegate> {
@private
    CGRect _searchTableViewRect;
}

// Search
@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) MKLocalSearch *localSearch;
@property (strong, nonatomic) MKLocalSearchResponse *results;

// Map
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;

//address
@property (strong,nonatomic) SellerAddEvent *addEvent;
@property (strong, nonatomic) IBOutlet UILabel *lbAddress;
@property (strong,nonatomic) NSString *address;
@property (strong,nonatomic) NSString *lat;
@property (strong,nonatomic) NSString *lng;
@property (nonatomic) BOOL isEdit;


@end
