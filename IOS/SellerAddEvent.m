//
//  SellerAddEvent.m
//  SeatFillers
//
//  Created by LeDung on 6/29/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import "SellerAddEvent.h"
#import "Interface.h"
#import "AppDelegate.h"
#import "SeatService.h"
#import "SeatMacro.h"
#import "SellerMap.h"
#import "AFHTTPRequestOperationManager.h"
@interface SellerAddEvent ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextFieldDelegate>

- (IBAction)dateChanged:(id)sender;
- (IBAction)timeChanged:(id)sender;

@end

@implementation SellerAddEvent
   


-(void)showInfomation
{
    self.eventNameTf.text = self.seatTicket.title;
    [[self.collapseView collapseClickCellForIndex:3]TitleLabel].text = [NSString stringWithFormat:@"Event Type:%@",self.seatTicket.typeName];
    
    self.selectedType = self.seatTicket.type;//
    self.selectedCity = self.seatTicket.city;
    [[self.collapseView collapseClickCellForIndex:8]TitleLabel].text = [NSString stringWithFormat:@"City:%@",self.selectedCity];
    
    self.selectedState = self.seatTicket.state;
    [[self.collapseView collapseClickCellForIndex:7]TitleLabel].text =[NSString stringWithFormat:@"State:%@",self.selectedState];
    
    self.selectedQuantity = self.seatTicket.qty;
    [[self.collapseView collapseClickCellForIndex:9]TitleLabel].text = [NSString stringWithFormat:@"Tix on hand:%@",self.selectedQuantity];
    
    self.selectedPriceRange = self.seatTicket.priceRange;
    [[self.collapseView collapseClickCellForIndex:10]TitleLabel].text = [NSString stringWithFormat:@"Price Range:%@",self.selectedPriceRange];
    
    self.noteTf.text = self.seatTicket.note;
    
    self.selectedDate = self.seatTicket.startDate;
    [[self.collapseView collapseClickCellForIndex:6]TitleLabel].text = [NSString stringWithFormat:@"Date:%@",self.selectedDate];
    
    self.selectedTime = self.seatTicket.starTime;
    [[self.collapseView collapseClickCellForIndex:5]TitleLabel].text = [NSString stringWithFormat:@"Time:%@",self.selectedTime];
    
    self.selectedAddress = self.seatTicket.address;
    self.lbAddress.text = [NSString stringWithFormat:@"Address:%@",self.selectedAddress];
    
    self.selectedLat = self.seatTicket.lat;
    self.selectedLng = self.seatTicket.lng;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.scrollView setContentSize:CGSizeMake([Interface screedWidth], self.view.frame.size.height * 2.0f)];
    self.collapseView.CollapseClickDelegate = self;
    [self.collapseView reloadCollapseClick];
    self.collapseView.contentSize =CGSizeMake([Interface screedWidth], 1000
                                              );
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
    self.typeArray=@[@"1",@"2",@"3"];
    self.typeArrayCharacter = @[@"Sports",@"Concert",@"Liberal Arts"];
    
    self.quantityArray=@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"];
    self.rangeArray=@[@"10-100",@"100-200",@"200-300",@"300-500",@"500+"];
        self.selectedType=@"Event Type";
        self.selectedCity=@"City";
        self.selectedQuantity=@"Tix On hand";
        self.selectedPriceRange=@"Price Range";
    
    if(self.isEdit)
    {
       // NSLog(@"edit---");
        self.navigationItem.title = @"Update";
        [self showInfomation];
        
    }else {
        //NSLog(@"add**");
        self.navigationItem.title = @"Seller Ticket Info";
    }
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.isBack) {
        self.lbAddress.text = [NSString stringWithFormat:@"Address:%@",self.selectedAddress];
    }
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
            return @"Tix On hand";
            break;
        case 10:
            return @"Price Range";
            break;
        case 11:
            return @"";
            break;
        case 12:
            return @"";
            break;
        case 13:
            return @"";
            break;
        default:
            break;
    }
    return nil;
}
-(int)numberOfCellsForCollapseClick
{
    return 20;//an sua code
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
            return self.viewEventQuantity;
            break;
        case 10:
            return self.viewEventPrice;
            break;
        case 11:
            return nil;
            break;
        case 12:
            return nil;
            break;
        case 13:
            return nil;
            break;
        case 14:
            return nil;
            break;
    }
    return nil;
}

-(void)collapseDesign{
    CollapseClickCell *lbCell = [self.collapseView collapseClickCellForIndex:2];
    UILabel *lbText = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, lbCell.frame.size.width, lbCell.frame.size.height)];
    [lbText setTextAlignment:NSTextAlignmentLeft];
    [lbText setFont:[UIFont systemFontOfSize:10]];
    lbText.numberOfLines = 2;
    [lbText setTextColor:[UIColor whiteColor]];
    if (self.isEdit) {
        lbText.text =@"Please update your ticket";
    }else{
        lbText.text = @" Please input the ticket information below that you would like to sell.";
        lbText.numberOfLines =2;
    }
    
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

    CollapseClickCell *addressCell=[self.collapseView collapseClickCellForIndex:11];
    self.lbAddress = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, addressCell.frame.size.width-10, addressCell.frame.size.height)];
    if (self.isEdit) {
        self.lbAddress.text = [NSString stringWithFormat:@"Address:%@",self.selectedAddress];
        }else{
        self.lbAddress.text = @"Address";
    }
    
    self.lbAddress.textColor =[UIColor whiteColor];
    [self.lbAddress setFont:[UIFont systemFontOfSize:15]];
    self.lbAddress.userInteractionEnabled = YES;
    UITapGestureRecognizer *taplbAddress = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(GoToSellerMap:)];
    [self.lbAddress addGestureRecognizer:taplbAddress];
    [addressCell addSubview:self.lbAddress];
    
    CollapseClickCell *noteCell=[self.collapseView collapseClickCellForIndex:12];
    self.noteTf = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, noteCell.frame.size.width-10, noteCell.frame.size.height)];
    self.noteTf.borderStyle = UITextBorderStyleNone;
    self.noteTf.font = [UIFont systemFontOfSize:15];
    self.noteTf.placeholder = @"Note";
    self.noteTf.textColor=[UIColor whiteColor];
    self.noteTf.autocorrectionType = UITextAutocorrectionTypeNo;
    self.noteTf.keyboardType = UIKeyboardTypeDefault;
    self.noteTf.returnKeyType = UIReturnKeyDone;
    self.noteTf.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.noteTf.delegate = self;
    [noteCell addSubview:self.noteTf];
    
    CollapseClickCell *postTicketCell=[self.collapseView collapseClickCellForIndex:14];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    if (self.isEdit)
    {
        [button setTitle:@"Update" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(updateTicket) forControlEvents:UIControlEventTouchUpInside];
        
    }else{
        [button setTitle:@"Post Event" forState:UIControlStateNormal];
        [button addTarget:self
                   action:@selector(postTicket)
         forControlEvents:UIControlEventTouchUpInside];
    }
    
    button.frame = CGRectMake(postTicketCell.frame.size.width/3, 0, postTicketCell.frame.size.width/3, postTicketCell.frame.size.height);
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    NSLog(@"%@",NSStringFromCGRect(button.frame));
    [postTicketCell addSubview:button];
    
    CollapseClickCell *takePhotoCell=[self.collapseView collapseClickCellForIndex:13];
    UIButton *takePhotoBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [takePhotoBtn addTarget:self
               action:@selector(choosePhoto)
     forControlEvents:UIControlEventTouchUpInside];
    if (self.isEdit) {
        [takePhotoBtn setTitle:@"Update Photo" forState:UIControlStateNormal];
    }else {
        [takePhotoBtn setTitle:@"Add Photo" forState:UIControlStateNormal];
        
    }
    
    takePhotoBtn.frame = CGRectMake(takePhotoCell.frame.size.width/3, 0, takePhotoCell.frame.size.width/3, takePhotoCell.frame.size.height);
    [takePhotoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    NSLog(@"%@",NSStringFromCGRect(button.frame));
    [takePhotoCell addSubview:takePhotoBtn];
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

-(void)choosePhoto{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"SeatFillers" message:@"Do you want to take photo or choose photo from library?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Take Photo",@"Choose Photo", nil];
    [alert show];
}

-(void)postTicket{
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:_eventNameTf.text forKey:@"title"];
    [dic setValue:_selectedType forKey:@"type"];
    [dic setValue:_selectedDate forKey:@"start_date"];
    [dic setValue:_selectedTime forKey:@"start_time"];
    [dic setValue:_selectedState forKey:@"state"];
    [dic setValue:_selectedCity forKey:@"city"];
    [dic setValue:self.selectedAddress forKey:@"address"];
    
    [dic setValue:_selectedQuantity forKey:@"qty"];
    [dic setValue:_selectedPriceRange forKey:@"price_range"];
    [dic setValue:self.selectedLat forKey:@"lat"];
    [dic setValue:self.selectedLng forKey:@"lng"];
    [dic setValue:_noteTf.text forKey:@"note"];
    [dic setValue:[[NSTimeZone systemTimeZone] name] forKey:@"time_zone"];
    [dic setValue:_encodedStr forKey:@"image"];
   
    [SeatService callWebserviceAtRequestPOST:YES andApi:SeatAPIAddTicket withParameters:dic onSuccess:^(SeatServiceResult *result) {
        [self.navigationController popViewControllerAnimated:YES];
    } onFailure:^(NSError *err) {
        NSString *message =[NSString stringWithFormat:@"%@",err.localizedDescription];
        UIAlertView *alertError = [[UIAlertView alloc]initWithTitle:@"Error" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertError show];
    }];
    
}
- (void)updateTicket{
    NSLog(@"update Ticket");
    AppDelegate *app = [[UIApplication sharedApplication]delegate];
    NSString *link =[NSString stringWithFormat:@"%@%@%@&id=%@",SEATSEVERADDRESS,API_UPDATE_TICKET,app.seatUser.token,self.seatTicket.sId];
    NSLog(@"link update %@",link);
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    [dic setValue:_eventNameTf.text forKey:@"title"];
    [dic setValue:_selectedType forKey:@"type"];
    [dic setValue:_selectedDate forKey:@"start_date"];
    [dic setValue:_selectedTime forKey:@"start_time"];
    [dic setValue:_selectedState forKey:@"state"];
    [dic setValue:_selectedCity forKey:@"city"];
    [dic setValue:self.selectedAddress forKey:@"address"];
    
    [dic setValue:_selectedQuantity  forKey:@"qty"];
    
    [dic setValue:_selectedPriceRange forKey:@"price_range"];
    [dic setValue:self.selectedLat forKey:@"lat"];
    [dic setValue:self.selectedLng forKey:@"lng"];
    [dic setValue:_noteTf.text forKey:@"note"];
    [dic setValue:[[NSTimeZone systemTimeZone] name] forKey:@"time_zone"];
    [dic setValue:_encodedStr forKey:@"image"];
    
    
    
    AFHTTPRequestOperationManager *af = [AFHTTPRequestOperationManager manager];
    af.responseSerializer = [AFHTTPResponseSerializer serializer];
    af.requestSerializer = [AFHTTPRequestSerializer serializer];
    [af POST:link parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (operation.response.statusCode==200) {
            //NSLog(@"ope %@",operation.responseString);
            NSDictionary *dicResult = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            NSString *resultStatus = dicResult[@"status"];
            if (resultStatus.integerValue==1) {
                NSLog(@"update success");
                NSUInteger ownIndex = [self.navigationController.viewControllers indexOfObject:self];
                [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:ownIndex - 2] animated:YES];
            }else {
                NSLog(@"error");
                [self alertUpdateFail];
            }
        }else {
            NSLog(@"error status code");
            [self alertUpdateFail];
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //
        NSLog(@"error:%@",error.localizedDescription);
        //[self alertUpdateFail];
        UIAlertView *alertUpdate = [[UIAlertView alloc]initWithTitle:@"Error Update" message:[NSString stringWithFormat:@"%@",error.localizedDescription] delegate:self cancelButtonTitle:@"Try again" otherButtonTitles:nil, nil];
        [alertUpdate show];
    }];
   
    
}
- (void)alertUpdateFail{
    UIAlertView *alertUpdate = [[UIAlertView alloc]initWithTitle:@"Error Update" message:@"Update Error" delegate:self cancelButtonTitle:@"Try again" otherButtonTitles:nil, nil];
    [alertUpdate show];
    
}
- (void)GoToSellerMap:(UITapGestureRecognizer*)tapLbAddress{
    if (self.isEdit) {
         SellerMap *sellMap = [[SellerMap alloc]init];
        sellMap.isEdit = YES;
        sellMap.address = self.selectedAddress;
        sellMap.lat = self.selectedLat;
        sellMap.lng = self.selectedLng;
        sellMap.addEvent = self;
        [self.navigationController pushViewController:sellMap animated:YES];
    }
    else
    {
        SellerMap *sellMap = [[SellerMap alloc]init];
        sellMap.addEvent = self;
        [self.navigationController pushViewController:sellMap animated:YES];
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
    } else if(pickerView==self.quantityPicker){
        return self.rangeArray.count;
    }
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView==self.statePicker) {
        return [self.stateArray objectAtIndex:row];
    } else if(pickerView==self.cityPicker){
        return [[self getCityFromState] objectAtIndex:row];
    } else if(pickerView==self.typePicker){
        return [self.typeArrayCharacter objectAtIndex:row];
    } else if(pickerView==self.rangePicker){
        return [self.rangeArray objectAtIndex:row];
    } else if(pickerView==self.quantityPicker){
        return [self.quantityArray objectAtIndex:row];
    }
    return @"";
}

#pragma mark - UIPicker Delegate

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (pickerView==self.statePicker) {
        self.selectedState=[self.stateArray objectAtIndex:row];
        
        self.cityArray=[self getCityFromState];
        [[self.collapseView collapseClickCellForIndex:7]TitleLabel].text = [NSString stringWithFormat:@"States:%@",self.selectedState];
        
        [self.cityPicker reloadAllComponents];
    } else if(pickerView==self.cityPicker){
        self.selectedCity=[[self getCityFromState] objectAtIndex:row];
        [[self.collapseView collapseClickCellForIndex:8]TitleLabel].text = [NSString stringWithFormat:@"City:%@",self.selectedCity];
    } else if(pickerView==self.typePicker){
        
        self.selectedType=[self.typeArray objectAtIndex:row];
        self.typeName = [self.typeArrayCharacter objectAtIndex:row];
        
        [[self.collapseView collapseClickCellForIndex:3]TitleLabel].text = [NSString stringWithFormat:@"Event Type:%@",self.typeName];
        
    } else if(pickerView==self.rangePicker){
        self.selectedPriceRange=[self.rangeArray objectAtIndex:row];
         [[self.collapseView collapseClickCellForIndex:10]TitleLabel].text = [NSString stringWithFormat:@"Price Range:%@",self.selectedPriceRange];
    } else if(pickerView==self.quantityPicker){
        self.selectedQuantity=[self.quantityArray objectAtIndex:row];
         [[self.collapseView collapseClickCellForIndex:9]TitleLabel].text = [NSString stringWithFormat:@"Tix On hand:%@",self.selectedQuantity];
    }
}

#pragma mark -UIAlertViewDelegate
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    // tap Take Photo
    if (buttonIndex == 1)
    {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Seat Fillers" message:@"Device has no camera"
                delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [myAlertView show];
            picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        } else {
            picker.sourceType=UIImagePickerControllerSourceTypeCamera;
            [self presentViewController:picker animated:YES completion:NULL];
        }
    } else if(buttonIndex ==2){
        picker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:NULL];
    }
}

#pragma mark -UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.encodedStr=[UIImagePNGRepresentation(chosenImage) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)dateChanged:(id)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:_datePicker.date];
    self.selectedDate = strDate;
    [[self.collapseView collapseClickCellForIndex:6]TitleLabel].text = [NSString stringWithFormat:@"Date:%@",self.selectedDate];
    
}

- (IBAction)timeChanged:(id)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"H:mm:ss"];
    NSString *strTime = [dateFormatter stringFromDate:_timePicker.date];
    self.selectedTime = strTime;
    [[self.collapseView collapseClickCellForIndex:5]TitleLabel].text = [NSString stringWithFormat:@"Time:%@",self.selectedTime];
}

@end
