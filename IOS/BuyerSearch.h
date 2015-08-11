


#import <UIKit/UIKit.h>
#import "MARKRangeSlider.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "NSDate+Calendar.h"
#import "NSDate+Helper.h"
#import "BuyerSearchResult.h"



@interface BuyerSearch : UIViewController <UIScrollViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *tpView;

@property(nonatomic,strong)NSMutableArray *arrEventType;
@property(nonatomic,strong)NSMutableDictionary *cityDictionary;


@end
