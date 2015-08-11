//
//  Home.m
//  SeatFillers
//
//  Created by LeDung on 6/11/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import "Home.h"
#import "SeatFillerDesign.h"
#import "AppDelegate.h"
#import "SeatFillerFlow.h"
#import "SellerHome.h"
#import "ChattingList.h"
#import "SellerHome.h"
#import "AppSetting.h"
#import "BuyerHome.h"
#import "ChattingList.h"
#import "SellerHome.h"
#import "AFHTTPRequestOperationManager.h"
#import "SeatService.h"
@interface Home ()
@property (nonatomic,strong) SellerHome *sellerHomeVc;
@property (nonatomic,strong) BuyerHome *buyerHome;

@end

@implementation Home

- (void)viewDidLoad {
    
    
    [[UINavigationBar appearance] setTitleTextAttributes: @{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [[UINavigationBar appearance] setBarTintColor:[SeatFillerDesign greenNavi]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];


    [super viewDidLoad];
    [self seatFillerDesign];
    AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
    self.seatUser =appDelegate.seatUser;
    
    self.sellerHomeVc = [[SellerHome alloc]init];
    self.sellerHomeVc.title = @"Seller";
    
    self.chattingList=[[ChattingList alloc]init];;
    self.chattingList.title =@"Seller Chatting";
    
    self.buyerListChat = [[BuyerListChat alloc]init];
    self.buyerListChat.title = @"Buyer Chatting";
    
    self.appSetting =[[AppSetting alloc]init];
    self.appSetting.title=@"Setting";
    
    self.buyerHome = [[BuyerHome alloc]init];
    self.buyerHome.title = @"Buyer Home";
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
    
}
-(void)seatFillerDesign
{
    [SeatFillerDesign buttonStyleWithGreenColor:self.btBuyer];
    [SeatFillerDesign buttonStyleWithGreenColor:self.btSeller];
    [self.btRound.layer setCornerRadius:25.0];
    [self.btRound setBackgroundColor:[UIColor whiteColor]];
    [self.btRound setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //an them code
    [SeatFillerDesign buttonStyleWithGreenColor:self.btLogOut];
    
    
    [SeatService boundView:self.Im_buyTic];
    [SeatService boundView:self.Im_searchTic];
}



-(void)creatMainTabbar
{
}
-(IBAction)btBuyerPress:(id)sender
{
    [self loadTicketByBuyer];
//    self.seatUser.type=@"buyer";
//    self.mainTabbar= [[UITabBarController alloc]init];
//    NSArray *array =[NSArray arrayWithObjects:[[BuyerHome alloc]init],self.chattingList,self.appSetting, nil];
//    [self.mainTabbar setViewControllers:array];
//    [self.navigationController pushViewController:self.mainTabbar animated:YES];
}

- (IBAction)btSellerPress:(id)sender {
    [self checkUserExpire];
    
}
- (void)goToSellerPage{
    self.seatUser.type=@"seller";
    self.mainTabbar= [[UITabBarController alloc]init];
    NSArray *array =[NSArray arrayWithObjects:self.sellerHomeVc,self.chattingList,self.appSetting, nil];
    [self.mainTabbar setViewControllers:array];
    [self.navigationController pushViewController:self.mainTabbar animated:YES];
    
}

- (IBAction)btLogOutPress:(id)sender {
    UIAlertView *alertLogOut = [[UIAlertView alloc]initWithTitle:@"Log out" message:@"Do you really want to log out" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    alertLogOut.tag = 100;
    [alertLogOut show];
    
   
    
}

- (IBAction)btSettingPress:(id)sender {
    [self.navigationController pushViewController:self.appSetting animated:YES];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==100) {
        if (buttonIndex==1) {
            AppDelegate *app = [[UIApplication sharedApplication]delegate];
            NSString *linkLogOut = [NSString stringWithFormat:@"%@%@",API_LOG_OUT,app.seatUser.token];
            NSLog(@"link log out %@",linkLogOut);
            
            AFHTTPRequestOperationManager *af = [AFHTTPRequestOperationManager manager];
            af.requestSerializer = [AFHTTPRequestSerializer serializer];
            af.responseSerializer = [AFHTTPResponseSerializer serializer];
            [af POST:linkLogOut parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                //
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                //
            }];
            
            
            
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }
    }
    if (alertView.tag) {
        if (buttonIndex==1) {
            
            PaymentVC *payment = [[PaymentVC alloc]init];
            [self.navigationController pushViewController:payment animated:YES];
//            UIAlertView *alertOngoing = [[UIAlertView alloc]initWithTitle:@"On The Way" message:@"Payment Feature Ongoing" delegate:self cancelButtonTitle:@"OK"otherButtonTitles:nil, nil];
//            [alertOngoing show];
            
            
        }
    }
}
- (void)loadTicketByBuyer{
    AppDelegate *app = [[UIApplication sharedApplication]delegate];
    NSString *link = [NSString stringWithFormat:@"%@%@&type=buyer",API_LIST_BUYER_TICKET,app.seatUser.token];
    NSLog(@"link list buyer ticket %@",link);
    AFHTTPRequestOperationManager *af = [AFHTTPRequestOperationManager manager];
    af.requestSerializer = [AFHTTPRequestSerializer serializer];
    af.responseSerializer = [AFHTTPResponseSerializer serializer];
    [af GET:link parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (operation.response.statusCode==200) {
            NSDictionary *dic_Result = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            NSString *result = dic_Result[@"status"];
            if (result.intValue==1) {
                NSArray *arrData = dic_Result[@"data"];
                if (arrData.count>0) {
                    self.seatUser.type=@"buyer";
                    self.mainTabbar= [[UITabBarController alloc]init];
                    NSArray *array =[NSArray arrayWithObjects:self.buyerHome,self.buyerListChat,self.appSetting, nil];
                    [self.mainTabbar setViewControllers:array];
                    [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"next"];
                    [self.navigationController pushViewController:self.mainTabbar animated:YES];
                }else {
                    //BuyerSearch *BuySearch = [[BuyerSearch alloc]init];
                    //[self.navigationController pushViewController:BuySearch animated:YES];
                   
                    self.seatUser.type=@"buyer";
                    self.mainTabbar= [[UITabBarController alloc]init];
                    NSArray *array =[NSArray arrayWithObjects:self.buyerHome,self.buyerListChat,self.appSetting, nil];
                    [self.mainTabbar setViewControllers:array];
                    [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"next"];
                    [self.navigationController pushViewController:self.mainTabbar animated:YES];
                    
                    
                    
                    
                }
                
            }
            
        }
        //
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SeatService alertFail:@"Can't not connect to server" andTitle:@"Error!"];
        
        
    }];
}
- (void)checkUserExpire{
    AppDelegate *app = [[UIApplication sharedApplication]delegate];
    NSString *link = [NSString stringWithFormat:@"%@%@",API_CHECK_USER_EXPIRE,app.seatUser.token];
    NSLog(@"link chek userExpire %@",link);
    
    AFHTTPRequestOperationManager *af = [AFHTTPRequestOperationManager manager];
    af.responseSerializer= [AFHTTPResponseSerializer serializer];
    af.requestSerializer = [AFHTTPRequestSerializer serializer];
    [af POST:link parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        if (operation.response.statusCode ==200) {
            NSDictionary *dicResult = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            NSString *result = dicResult[@"status"];
            if (result.intValue==1) {
                //push to view seller
                [self goToSellerPage];
                
            }else {
                //chua thanh toan hien alert
                UIAlertView *alertNotPay = [[UIAlertView alloc]initWithTitle:@"Payment" message:@"The Seller's account needs to be updated. Would you like to updated your account" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
                alertNotPay.tag = 105;
                [alertNotPay show];
                
                
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SeatService alertFail:[NSString stringWithFormat:@"%@",[error localizedDescription]] andTitle:@"Error"];
        
    }];
    
    
}



@end
