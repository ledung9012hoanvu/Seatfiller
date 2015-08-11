//
//  Home.h
//  SeatFillers
//
//  Created by LeDung on 6/11/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"
#import "SeatUser.h"
#import "AppSetting.h"
#import "ChattingList.h"
#import "BuyerSearch.h"
#import "BuyerListChat.h"
#import "PaymentVC.h"
@interface Home : UIViewController<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *btBuyer;
@property (weak, nonatomic) IBOutlet UIButton *btSeller;
@property(nonatomic,strong) SeatUser *seatUser;
@property (weak, nonatomic) IBOutlet UILabel *LbWelcome;
@property (weak, nonatomic) IBOutlet UIButton *btSetting;




@property(nonatomic,strong) UITabBarController *mainTabbar;
@property(nonatomic,strong) AppSetting *appSetting;
@property(nonatomic,strong) ChattingList *chattingList;
@property (nonatomic,strong) BuyerListChat *buyerListChat;



@property (weak, nonatomic) IBOutlet UIButton *btLogOut;



@property (weak, nonatomic) IBOutlet UIImageView *Im_searchTic;


@property (weak, nonatomic) IBOutlet UIImageView *Im_buyTic;



- (IBAction)btBuyerPress:(id)sender;
- (IBAction)btSellerPress:(id)sender;
- (IBAction)btLogOutPress:(id)sender;
- (IBAction)btSettingPress:(id)sender;



@property (weak, nonatomic) IBOutlet UIButton *btRound;

@end
