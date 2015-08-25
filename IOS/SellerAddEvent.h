//
//  SellerAddEvent.h
//  SeatFillers
//
//  Created by LeDung on 6/29/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"
#import "Interface.h"
#import "SeatFillerDesign.h"
#import "CollapseClick.h"
#import "SeatTicket.h"



@interface SellerAddEvent : UIViewController <CollapseClickDelegate>
@property (nonatomic, weak) IBOutlet TPKeyboardAvoidingScrollView *scrollView;

@property (weak, nonatomic) IBOutlet CollapseClick *collapseView;

@property (strong, nonatomic) IBOutlet UIView *viewEventDate;
@property (strong, nonatomic) IBOutlet UIView *viewEventQuantity;
@property (strong, nonatomic) IBOutlet UIView *viewEventType;
@property (strong, nonatomic) IBOutlet UIView *viewEventTime;
@property (strong, nonatomic) IBOutlet UIView *viewEventCity;
@property (strong, nonatomic) IBOutlet UIView *viewEventState;
@property (strong, nonatomic) IBOutlet UIView *viewEventPrice;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;


@property (nonatomic) BOOL isEdit;
@property (nonatomic,weak) SeatTicket *seatTicket;

@property (nonatomic,strong) NSMutableDictionary *dicAddress;
@property (nonatomic, strong) NSDictionary *cityDictionary;
@property (nonatomic, strong) NSArray *stateArray;
@property (nonatomic, strong) NSArray *quantityArray;
@property (nonatomic, strong) NSArray *cityArray;
@property (nonatomic, strong) NSArray *typeArray;
@property (nonatomic, strong) NSArray *typeArrayCharacter;
@property (nonatomic, strong) NSArray *rangeArray;
@property (nonatomic, strong) NSString *selectedState;
@property (nonatomic, strong) NSString *selectedCity;
@property (nonatomic, strong) NSString *selectedType;
@property (nonatomic, strong) NSString *typeName;
@property (nonatomic, strong) NSString *selectedDate;
@property (nonatomic, strong) NSString *selectedTime;
@property (nonatomic, strong) NSString *selectedQuantity;
@property (nonatomic, strong) NSString *selectedPriceRange;
@property (nonatomic, strong) NSString *encodedStr;
@property (nonatomic, strong) UITextField *eventNameTf;

@property (nonatomic,strong) NSString *selectedAddress;
@property (nonatomic,strong) NSString *selectedLat;
@property (nonatomic,strong) NSString *selectedLng;
@property (nonatomic,strong) UILabel *lbAddress;

@property (nonatomic, strong) UITextField *noteTf;
@property (nonatomic, strong) IBOutlet UIPickerView *quantityPicker;
@property (nonatomic, strong) IBOutlet UIPickerView *rangePicker;
@property (nonatomic, strong) IBOutlet UIPickerView *typePicker;
@property (nonatomic, strong) IBOutlet UIPickerView *statePicker;
@property (nonatomic, strong) IBOutlet UIPickerView *cityPicker;

@property (nonatomic) BOOL isBack;

@end
