//
//  BuyerSearch.m
//  SeatFillers
//
//  Created by LeDung on 6/14/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
// slogan Hi username Please input the ticket information below in order to search the tickets that you want

#import "BuyerSearch.h"
#import "SeatMacro.h"
#import "SeatFillerDesign.h"
#import "AppDelegate.h"
#import "CollapseClick.h"
#import "SeatService.h"
#import "SeatTicket.h"
#import "BuyerSearchResult.h"
#import "AFHTTPRequestOperationManager.h"

@interface BuyerSearch ()<CollapseClickDelegate, UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIView *viewEventDate;
@property (strong, nonatomic) IBOutlet UIView *viewEventType;
@property (strong, nonatomic) IBOutlet UIView *viewEventTime;
@property (strong, nonatomic) IBOutlet UIView *viewEventCity;
@property (strong, nonatomic) IBOutlet UIView *viewEventState;
@property (weak, nonatomic) IBOutlet CollapseClick *collapseView;
@property (strong, nonatomic) IBOutlet UIView *viewEventPrice;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;
@property (weak, nonatomic) IBOutlet UIPickerView *quantityPicker;
@property (weak, nonatomic) IBOutlet UIPickerView *cityPicker;
@property (nonatomic, strong) NSArray *stateArray;
@property (nonatomic, strong) NSArray *cityArray;
@property (nonatomic, strong) NSArray *typeArray;
@property (nonatomic,strong) NSArray *typeArrNumber;
@property (nonatomic, strong) NSArray *rangeArray;
@property (nonatomic, strong) NSString *selectedState;
@property (nonatomic, strong) NSString *selectedCity;
@property (nonatomic, strong) NSString *selectedType;
@property (nonatomic, strong) NSString *selectedDate;
@property (nonatomic, strong) NSString *selectedTime;
@property (nonatomic, strong) NSString *selectedQuantity;
@property (nonatomic, strong) NSString *selectedPriceRange;
@property (nonatomic, strong) NSString *encodedStr;
@property (nonatomic, strong) UITextField *eventNameTf;
@property (nonatomic, strong) UITextField *addressTf;
@property (nonatomic, strong) IBOutlet UIPickerView *rangePicker;
@property (nonatomic, strong) IBOutlet UIPickerView *typePicker;
@property (nonatomic, strong) IBOutlet UIPickerView *statePicker;
@property (strong,nonatomic) NSArray *arrType;
@property (strong,nonatomic) NSArray *arrQuantity;
@property (strong,nonatomic) AppDelegate *app;



- (IBAction)dateChanged:(id)sender;
- (IBAction)timeChanged:(id)sender;

@end

@implementation BuyerSearch


-(void)fillData
{
    
    self.title=@"Buyer Search";
    self.navigationController.navigationBarHidden=NO;
    
}
- (void)viewDidLoad {
    self.app = [[UIApplication sharedApplication]delegate];
    
    
    [self fillData];
    [self seatFillerDesign];
    
    [super viewDidLoad];
    self.collapseView.CollapseClickDelegate = self;
    [self.collapseView reloadCollapseClick];
    self.collapseView.contentSize =CGSizeMake([Interface screedWidth], 900);
    [self.datePicker setValue:[UIColor whiteColor] forKeyPath:@"textColor"];
    [self.timePicker setValue:[UIColor whiteColor] forKeyPath:@"textColor"];
    [[self.collapseView collapseClickCellForIndex:0] setAlpha:0];
    [[self.collapseView collapseClickCellForIndex:1] setAlpha:0];
    //[[self.collapseView collapseClickCellForIndex:2] setAlpha:0];
    [self collapseDesign];

    
    AppDelegate *app =[[UIApplication sharedApplication]delegate];
    self.cityDictionary =[NSMutableDictionary dictionaryWithDictionary:app.dictionaryCiteState];
    self.stateArray=[self.cityDictionary allKeys];
    //self.selectedState=[self.stateArray objectAtIndex:0];
    
    self.cityArray=[self getCityFromState];
    self.typeArray=[NSMutableArray arrayWithArray:TICKET_TYPE_ARAY];
    self.typeArrNumber =@[@"1",@"2",@"3"];
    self.rangeArray=@[@"10-100",@"100-200",@"200-300",@"300-500",@"500+"];
    self.arrQuantity = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20"];
    

}

-(NSArray *)getCityFromState{
    NSArray *citiesArr=[self.cityDictionary objectForKey:self.selectedState];
    return citiesArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSString *)titleForCollapseClickAtIndex:(int)index
{
    switch (index) {
        case 0:
            return @"";
            break;
        case 1:
            return @"";
            break;
        case 2:
            return @"";
            break;
        case 3:
            return @"Event Type";
            break;
        case 4:
            return @"";
            break;
        case 5:
            return @"Event Time";
            break;
        case 6:
            return @"Event Date";
            break;
        case 7:
            return @"States";
            break;
        case 8:
            return @"City";
            break;
        case 9:
            return @"Quantity";
            break;
        case 10:
            return @"Price Range";
            break;
        case 11:
            return @"";
            break;
        default:
            break;
    }
    return nil;
}
-(int)numberOfCellsForCollapseClick
{
    return 12;
}
-(UIView *)viewForCollapseClickContentViewAtIndex:(int)index
{
    switch (index) {
        case 3:
            return self.viewEventType;
            break;
        case 4:
            return nil;
            break;
        case 5:
            return self.viewEventTime;
            break;
        case 6:
            return self.viewEventDate;
            break;
        case 7:
            return self.viewEventState;
            break;
        case 8:
            return self.viewEventCity;
            break;
        case 9:
            return self.quantityPicker;
            break;
        case 10:
            return self.viewEventPrice;
            break;
        case 11:
            return nil;
            break;
    }
    return nil;
}

-(UIColor*)colorForTitleLabelAtIndex:(int)index
{
    return [UIColor whiteColor];
}
-(UIColor*)colorForTitleArrowAtIndex:(int)index
{
    return [UIColor clearColor];
}
-(UIColor*)colorForCollapseClickTitleViewAtIndex:(int)index
{
    return [UIColor clearColor];
}


-(void)collapseDesign{
    CollapseClickCell *lbCell = [self.collapseView collapseClickCellForIndex:2];
    UILabel *lbText = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, lbCell.frame.size.width, lbCell.frame.size.height)];
    [lbText setTextAlignment:NSTextAlignmentLeft];
    [lbText setFont:[UIFont systemFontOfSize:14]];
    lbText.numberOfLines = 2;
    [lbText setTextColor:[UIColor whiteColor]];
    lbText.text = [NSString stringWithFormat:@"Hi %@ Please input the ticket information below in order to search the tickets that you want.",self.app.seatUser.userName];
    [lbCell addSubview:lbText];
    
    
    
    
    
    
    
    CollapseClickCell *eventNameCell=[self.collapseView collapseClickCellForIndex:4];
    self.eventNameTf= [[UITextField alloc] initWithFrame:CGRectMake(10, 0, eventNameCell.frame.size.width-10, eventNameCell.frame.size.height)];
    
    self.eventNameTf.borderStyle = UITextBorderStyleNone;
    self.eventNameTf.font = [UIFont systemFontOfSize:15];
    self.eventNameTf.placeholder = @"Event Name";
    self.eventNameTf.textColor=[UIColor whiteColor];
    self.eventNameTf.autocorrectionType = UITextAutocorrectionTypeNo;
    self.eventNameTf.keyboardType = UIKeyboardTypeDefault;
    self.eventNameTf.returnKeyType = UIReturnKeyDone;
    self.eventNameTf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.eventNameTf.delegate = self;
    [eventNameCell addSubview:self.eventNameTf];
    CollapseClickCell *searchBtnCell=[self.collapseView collapseClickCellForIndex:11];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(searchTicket)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"Search" forState:UIControlStateNormal];
    button.frame = CGRectMake(0, -10, searchBtnCell.frame.size.width, 50);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [searchBtnCell addSubview:button];
    
    UIImageView *line =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, searchBtnCell.frame.size.width, 1)];
    [searchBtnCell addSubview:line];
    [line setBackgroundColor:[UIColor whiteColor]];
    [line setAlpha:0.5];
}




-(void)seatFillerDesign
{
    [self.tpView setContentSize:CGSizeMake(SCREEN_WIDTH, 737)];
    self.title =@"Buyer Search";
    [Interface setFullWidth:self.viewEventCity];
    [Interface setFullWidth:self.typePicker];
    [Interface setFullWidth:self.cityPicker];
    [Interface setFullWidth:self.viewEventDate];
    [Interface setFullWidth:self.datePicker];
    [Interface setFullWidth:self.viewEventPrice];
    [Interface setFullWidth:self.viewEventState];
    [Interface setFullWidth:self.viewEventTime];
    [Interface setFullWidth:self.timePicker];
}

-(void)searchTicket{
    NSString *linkSearch = [NSString stringWithFormat:@"http://52.68.134.162/api/ticket/search?token=%@",self.app.seatUser.token];
    
    if (self.selectedType.length>0) {
        linkSearch = [linkSearch stringByAppendingString:[NSString stringWithFormat:@"&type=%@",self.selectedType]];
        if (self.eventNameTf.text.length>0) {
            linkSearch =[linkSearch stringByAppendingString:[NSString stringWithFormat:@"&title=%@",self.eventNameTf.text]];
            
        }
        if (self.selectedState.length>0) {
            self.selectedState = [self.selectedState stringByReplacingOccurrencesOfString:@" " withString:@""];
            linkSearch = [linkSearch stringByAppendingString:[NSString stringWithFormat:@"&state=%@",self.selectedState]];
            
        }
        if (self.selectedCity.length>0) {
            self.selectedCity = [self.selectedCity stringByReplacingOccurrencesOfString:@" " withString:@""];
            
            linkSearch = [linkSearch stringByAppendingString:[NSString stringWithFormat:@"&city=%@",self.selectedCity]];
            
        }
        if (self.selectedDate.length>0) {
            self.selectedDate = [self.selectedDate stringByReplacingOccurrencesOfString:@" " withString:@""];
            linkSearch = [linkSearch stringByAppendingString:[NSString stringWithFormat:@"&start_date=%@",self.selectedDate]];
            
        }
        if (self.selectedTime.length>0) {
            self.selectedTime = [self.selectedTime stringByReplacingOccurrencesOfString:@" " withString:@""];
            linkSearch = [linkSearch stringByAppendingString:[NSString stringWithFormat:@"&start_time=%@",self.selectedTime]];
            
        }
        if (self.selectedPriceRange.length>0) {
            linkSearch = [linkSearch stringByAppendingString:[NSString stringWithFormat:@"&price-range=%@",self.selectedPriceRange]];
        }
        AFHTTPRequestOperationManager *af = [AFHTTPRequestOperationManager manager];
        af.requestSerializer = [AFHTTPRequestSerializer serializer];
        af.responseSerializer = [AFHTTPResponseSerializer serializer];
        [af GET:linkSearch parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dicResult = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            NSString *result = dicResult[@"status"];
            if (result.integerValue==1) {
                NSMutableArray *arrResult = [[NSMutableArray alloc]init];
                
                NSArray *arrData = dicResult[@"data"];
                if (arrData.count>0) {
                    for (int i=0; i<arrData.count; i++) {
                        NSMutableDictionary *dic = arrData[i];
                        SeatTicket *seatTic = [SeatTicket ticketFromDictionary:dic];
                        [arrResult addObject:seatTic];
                        dic = nil;
                        seatTic = nil;
                    }
                    BuyerSearchResult *buyerSearchResult = [[BuyerSearchResult alloc]init];
                    buyerSearchResult.resultArray = arrResult;
                    [self.navigationController pushViewController:buyerSearchResult animated:YES];
                }else{
                    [SeatService alertFail:@"No ticket available found" andTitle:@"Not Found"];
                    
                }
            }else {
                [SeatService alertFail:@"No ticket available found" andTitle:@"Not Found"];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [SeatService alertFail:[NSString stringWithFormat:@"%@",error.localizedDescription] andTitle:@"Error"];
        }];
    }else {
        [SeatService alertFail:@"Event type can't be blank" andTitle:@"Error"];
    }
}

#pragma mark - Picker View Data source
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    if (pickerView==self.statePicker) {
        return [self.stateArray count];
    } else if(pickerView==self.cityPicker){
        return [self getCityFromState].count;
    } else if(pickerView==self.typePicker){
        return self.typeArray.count;
    } else if(pickerView==self.rangePicker){
        return self.rangeArray.count;
    }else if (pickerView==self.quantityPicker)
        return self.arrQuantity.count;
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView==self.statePicker) {
        return [self.stateArray objectAtIndex:row];
    } else if(pickerView==self.cityPicker){
        return [[self getCityFromState] objectAtIndex:row];
    } else if(pickerView==self.typePicker){
        return [self.typeArray objectAtIndex:row];
    } else if(pickerView==self.rangePicker){
        //return [self.rangeArray objectAtIndex:row];
        return [NSString stringWithFormat:@"$%@",self.rangeArray[row]];
    } else if (pickerView==self.quantityPicker)
        return ([self.arrQuantity objectAtIndex:row]);
    return @"";
}

#pragma mark - UIPicker Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (pickerView==self.statePicker) {
        self.selectedState=[self.stateArray objectAtIndex:row];
        self.cityArray=[self getCityFromState];
        [self.cityPicker reloadAllComponents];
        self.selectedCity = @"";
        [[self.collapseView collapseClickCellForIndex:8]TitleLabel].text = [NSString stringWithFormat:@"City"];
        
        [[self.collapseView collapseClickCellForIndex:7]TitleLabel].text=[NSString stringWithFormat:@"State:%@",self.selectedState];
        
        
    } else if(pickerView==self.cityPicker){
        self.selectedCity=[[self getCityFromState] objectAtIndex:row];
        [[self.collapseView collapseClickCellForIndex:8]TitleLabel].text = [NSString stringWithFormat:@"City:%@",self.selectedCity];
        
    } else if(pickerView==self.typePicker){
        self.selectedType=[self.typeArrNumber objectAtIndex:row];
        NSString *typeString = self.typeArray[row];
        [[self.collapseView collapseClickCellForIndex:3]TitleLabel].text = [NSString stringWithFormat:@"Event Type:%@",typeString];
        
    } else if(pickerView==self.rangePicker){
        self.selectedPriceRange=[self.rangeArray objectAtIndex:row];
        [[self.collapseView collapseClickCellForIndex:10]TitleLabel].text = [NSString stringWithFormat:@"Price range:$%@",self.selectedPriceRange];
    }else if (pickerView==self.quantityPicker){
        [[self.collapseView collapseClickCellForIndex:9]TitleLabel].text = [NSString stringWithFormat:@"Quanlity:%@",self.arrQuantity[row]];
    }
}

#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)dateChanged:(id)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    NSString *strDate = [dateFormatter stringFromDate:_datePicker.date];
    self.selectedDate = strDate;
    [[self.collapseView collapseClickCellForIndex:6]TitleLabel].text = [NSString stringWithFormat:@"Date:%@",self.selectedDate];
}

- (IBAction)timeChanged:(id)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setDateFormat:@"H:mm:ss"];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *strTime = [dateFormatter stringFromDate:_timePicker.date];
    self.selectedTime = strTime;
    [[self.collapseView collapseClickCellForIndex:5]TitleLabel].text=[NSString stringWithFormat:@"Time:%@",self.selectedTime];
}
@end
