
//
//  AppSetting.h
//  SeatFillers
//
//  Created by LeDung on 6/16/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollapseClick.h"
#import "SeatMacro.h"
#import "TPKeyboardAvoidingScrollView.h"
#import "AppDelegate.h"
#import <MessageUI/MessageUI.h>
@interface AppSetting : UIViewController <CollapseClickDelegate,UIDocumentInteractionControllerDelegate,UIAlertViewDelegate,MFMailComposeViewControllerDelegate>
@property(nonatomic,strong) NSArray *settingArray;
@property (weak, nonatomic) IBOutlet UIButton *btChangePass;
@property (weak, nonatomic) IBOutlet UIButton *btUpdateAccount;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UITextField *tfRepassword;
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfReEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfUser;
@property (weak, nonatomic) IBOutlet UITextField *tfReUser;
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *tpView;

@property (weak, nonatomic) IBOutlet UIButton *btTerm;
@property (weak, nonatomic) IBOutlet UIButton *btPrivacy;
@property (weak, nonatomic) IBOutlet UIButton *btSeller;
@property (weak, nonatomic) IBOutlet UIButton *btSafety;
@property (weak, nonatomic) IBOutlet UIButton *btIsUpAccount;
@property (weak, nonatomic) IBOutlet UIButton *btIsUpPass;
@property (weak, nonatomic) IBOutlet CollapseClick *collapseView;

@property (strong, nonatomic) IBOutlet UIView *notificationView;
@property (strong, nonatomic) IBOutlet UIView *changeEmailView;
@property (strong, nonatomic) IBOutlet UIView *changUserNameView;
@property (strong, nonatomic) IBOutlet UIView *changePassView;
@property (strong, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UIButton *btUpdateEmail;
@property (weak, nonatomic) IBOutlet UIButton *btUpdatePassword;
@property (weak, nonatomic) IBOutlet UIButton *btUpdateUsername;

@property (strong,nonatomic) AppDelegate *app;
@property (weak, nonatomic) IBOutlet UILabel *lbnameUserSetting;



@property (strong, nonatomic) UIDocumentInteractionController *documentInteractionController;
@property(nonatomic,strong) NSURL *pdfURL;







- (IBAction)btUpdatePress:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btIsUpEmail;
- (IBAction)btChangePress:(id)sender;
- (IBAction)btTermPress:(id)sender;
- (IBAction)btPrivacyPress:(id)sender;
- (IBAction)btSellerPress:(id)sender;
- (IBAction)btSafetyPress:(id)sender;




@end


