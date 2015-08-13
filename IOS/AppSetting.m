//
//  AppSetting.m
//  SeatFillers
//
//  Created by LeDung on 6/16/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
// thuyngan2797@yahoo.com

#import "AppSetting.h"
#import "CollapseClickCell.h"
#import "SeatFillerDesign.h"
#import "SeatFillerDesign.h"
#import "Interface.h"
#import "SeatService.h"
#import "AFHTTPRequestOperationManager.h"
#import "SignIn.h"
#import "UIView+LeafUI.h"



#define Swich_Right_margin 10

@interface AppSetting () <UITextFieldDelegate>

@end

@implementation AppSetting

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.collapseView setScrollEnabled:NO];
    
    self.app = [[UIApplication sharedApplication]delegate];
    self.lbnameUserSetting.text = [NSString stringWithFormat:@"%@ Setting",self.app.seatUser.lastName];
    
    [self.tpView setBackgroundColor:[UIColor clearColor]];
    [self.tpView setContentSize:CGSizeMake([Interface screedWidth], self.view.frame.size.height * 1.8)];
    self.collapseView.CollapseClickDelegate = self;
    [self.collapseView reloadCollapseClick];
    [self collapseDesign];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //NSLog(@"viewWillApper");
    [self.tabBarController setTitle:@"Setting"];
    
}



-(int)numberOfCellsForCollapseClick
{
    return 14;
}

-(NSString *)titleForCollapseClickAtIndex:(int)index
{
    switch (index) {
        case 0:
            return @"Notification";
            break;
        case 1:
            return @"Vibration";
            break;
        case 2:
            return @"Sound";
            break;
        case 3:
            return @"Change Username";
            break;
        case 4:
            return @"Change Email";
            break;
        case 5:
            return @"Change Password";
            break;
        case 6:
            return @"Infomation";
            break;
            
        default:
            break;
    }
    return nil;
    
    
}
-(UIView *)viewForCollapseClickContentViewAtIndex:(int)index
{
    switch (index) {
        case 0:
            return nil;
            break;
        case 1:
            return nil;
            break;
        case 2:
            return nil;
            break;
        case 3:
            return self.changUserNameView;
            break;
        case 4:
            return self.changeEmailView;
            break;
        case 5:
            return self.changePassView;
            break;
        case 6:
            return self.infoView;
            break;
    }
    return nil;
    
}
- (IBAction):(id)sender {
}
-(IBAction)btUpdatePress:(id)sender
{
    
}

- (IBAction)btChangePress:(id)sender {
}

- (IBAction)btTermPress:(id)sender
{
    NSURL *URL = [[NSBundle mainBundle] URLForResource:@"Term" withExtension:@"pdf"];
        self.documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:URL];
        [self.documentInteractionController setDelegate:self];
        [self.documentInteractionController presentPreviewAnimated:YES];
}

- (IBAction)btPrivacyPress:(id)sender
{
    NSURL *URL = [[NSBundle mainBundle] URLForResource:@"Privacy" withExtension:@"pdf"];
    self.documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:URL];
    [self.documentInteractionController setDelegate:self];
    [self.documentInteractionController presentPreviewAnimated:YES];
}

- (IBAction)btSellerPress:(id)sender
{
    NSURL *URL = [[NSBundle mainBundle] URLForResource:@"SellerRule" withExtension:@"pdf"];
    self.documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:URL];
    [self.documentInteractionController setDelegate:self];
    [self.documentInteractionController presentPreviewAnimated:YES];

}

- (UIViewController *) documentInteractionControllerViewControllerForPreview: (UIDocumentInteractionController *) controller {
    
    return self;
}


- (IBAction)btSafetyPress:(id)sender
{
    NSURL *URL = [[NSBundle mainBundle] URLForResource:@"Policy" withExtension:@"pdf"];
    self.documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:URL];
    [self.documentInteractionController setDelegate:self];
    [self.documentInteractionController presentPreviewAnimated:YES];
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

-(void)collapseDesign
{
    [[[self.collapseView collapseClickCellForIndex:0] TitleArrow] setHidden:YES];
    [[[self.collapseView collapseClickCellForIndex:1] TitleArrow] setHidden:YES];
    [[[self.collapseView collapseClickCellForIndex:2] TitleArrow] setHidden:YES];
    [[[self.collapseView collapseClickCellForIndex:3] TitleArrow] setHidden:YES];
    [[[self.collapseView collapseClickCellForIndex:4] TitleArrow] setHidden:YES];
    [[[self.collapseView collapseClickCellForIndex:5] TitleArrow] setHidden:YES];
    [[[self.collapseView collapseClickCellForIndex:6] TitleArrow] setHidden:YES];
    [[[self.collapseView collapseClickCellForIndex:7] TitleArrow] setHidden:YES];
    
    CollapseClickCell *cellNotification=[self.collapseView collapseClickCellForIndex:0];
    UISwitch *onOffNotifcation = [[UISwitch alloc] initWithFrame: CGRectZero];
    onOffNotifcation.frame=CGRectMake(cellNotification.frame.size.width-180, onOffNotifcation.frame.origin.y, onOffNotifcation.frame.size.width, onOffNotifcation.frame.size.height);
    [onOffNotifcation setOn:YES];
    [cellNotification addSubview:onOffNotifcation];
    [onOffNotifcation setXTLocation:Swich_Right_margin];


    CollapseClickCell *cellVibration=[self.collapseView collapseClickCellForIndex:1];
    UISwitch *onOffVibration = [[UISwitch alloc] initWithFrame: CGRectZero];
    onOffVibration.frame=CGRectMake(cellVibration.frame.size.width-180, onOffVibration.frame.origin.y, onOffVibration.frame.size.width, onOffVibration.frame.size.height);
    [onOffVibration setOn:YES];
    [cellVibration addSubview:onOffVibration];
    [onOffVibration setXTLocation:Swich_Right_margin];
    
    CollapseClickCell *cellSound=[self.collapseView collapseClickCellForIndex:2];
    UISwitch *onOffSound = [[UISwitch alloc] initWithFrame: CGRectZero];
    onOffSound.frame=CGRectMake(cellSound.frame.size.width-180, onOffSound.frame.origin.y, onOffSound.frame.size.width, onOffSound.frame.size.height);
    [onOffSound setOn:YES];
    
    [cellSound addSubview:onOffSound];
    [onOffSound setXTLocation:Swich_Right_margin];
    
    CollapseClickCell *cellAbout = [self.collapseView collapseClickCellForIndex:8];
    UIButton *btAbout = [[UIButton alloc]initWithFrame:CGRectMake(30, 0, 120, 50)];
    [btAbout setTitle:@"About us" forState:UIControlStateNormal];
    [btAbout.titleLabel setTintColor:[UIColor whiteColor]];
    [btAbout addTarget:self action:@selector(clickAboutBt) forControlEvents:UIControlEventTouchUpInside];
    [cellAbout addSubview:btAbout];
    
    CollapseClickCell *cellContact = [self.collapseView collapseClickCellForIndex:9];
    UIButton *btContact = [[UIButton alloc]initWithFrame:CGRectMake(30, 0, 120, 50)];
    [btContact setTitle:@" Contact us" forState:UIControlStateNormal];
    [btContact.titleLabel setTintColor:[UIColor whiteColor]];
    [btContact addTarget:self action:@selector(clikButtonContact) forControlEvents:UIControlEventTouchUpInside];
    [cellContact addSubview:btContact];
    
    CollapseClickCell *cellSignOut = [self.collapseView collapseClickCellForIndex:11];
   // CGPoint pointCenter = self.view.center;
    UIButton *btSignOut = [[UIButton alloc]initWithFrame:CGRectMake(95, 0, 120, 50)];
    //btSignOut.center = pointCenter;
    
    
    //btSignOut.center = cellSignOut.center;
    //cellSignOut.backgroundColor = [UIColor redColor];
    
    [btSignOut setTitle:@"Sign Out" forState:UIControlStateNormal];
    [btSignOut.titleLabel setTintColor:[UIColor whiteColor]];
    [btSignOut addTarget:self action:@selector(clickButtonSignOut) forControlEvents:UIControlEventTouchUpInside];
    [cellSignOut addSubview:btSignOut];
    
    
    
    
    
    
    
    [self.infoView setBackgroundColor:[UIColor clearColor]];
    [self.changeEmailView setBackgroundColor:[UIColor clearColor]];
    [self.changePassView setBackgroundColor:[UIColor clearColor]];
    [self.changUserNameView setBackgroundColor:[UIColor clearColor]];
    [self.collapseView setBackgroundColor:[UIColor clearColor]];
    
    [SeatFillerDesign textFieldInSettingStyle:self.tfEmail andSupperView:self.collapseView];
    [SeatFillerDesign textFieldInSettingStyle:self.tfPassword andSupperView:self.collapseView];
    [SeatFillerDesign textFieldInSettingStyle:self.tfReEmail andSupperView:self.collapseView];
    [SeatFillerDesign textFieldInSettingStyle:self.tfRepassword andSupperView:self.collapseView];
    [SeatFillerDesign textFieldInSettingStyle:self.tfReUser andSupperView:self.collapseView];
    [SeatFillerDesign textFieldInSettingStyle:self.tfUser andSupperView:self.collapseView];
    
    [SeatFillerDesign buttonInSettingStyle:self.btTerm andSupperView:nil];
    [SeatFillerDesign buttonInSettingStyle:self.btSafety andSupperView:nil];
    [SeatFillerDesign buttonInSettingStyle:self.btPrivacy andSupperView:nil];
    [SeatFillerDesign buttonInSettingStyle:self.btSeller andSupperView:nil];
    [SeatFillerDesign buttonInSettingStyle:self.btUpdateEmail andSupperView:nil];
    
    [SeatFillerDesign buttonInSettingStyle:self.btUpdateUsername andSupperView:nil];
    [SeatFillerDesign buttonInSettingStyle:self.btUpdatePassword andSupperView:nil];


    
}


- (IBAction)btUpdateEmailPress:(id)sender {
    if ([self.tfEmail.text isEqualToString:self.tfReEmail.text] && self.tfEmail.text.length>0) {
        //change API
        NSString *linkChangeEmail = [NSString stringWithFormat:@"%@%@",API_CHANGEMAIL,self.app.seatUser.token];
        AFHTTPRequestOperationManager *af= [AFHTTPRequestOperationManager manager];
        af.responseSerializer = [AFHTTPResponseSerializer serializer];
        af.requestSerializer = [AFHTTPRequestSerializer serializer];
        NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
        [param setObject:self.tfEmail.text forKey:@"email"];
        [af POST:linkChangeEmail parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (operation.response.statusCode ==200) {
                NSDictionary *dicResult = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                NSString *result = dicResult[@"status"];
                if (result.intValue==1) {
                    [SeatService alertFail:@"Change Email Success" andTitle:@"Success"];
                    
                }else {
                    [SeatService alertFail:[NSString stringWithFormat:@"Change Email not complete, Please Try again later"] andTitle:@"ERROR"];
                    
                    
                    
                }
                
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [SeatService alertFail:[NSString stringWithFormat:@"%@",error.localizedDescription] andTitle:@"ERROR"];
            
        }];
        
        
        
    }else {
        [SeatService alertFail:@"Email and Retype Email does not match " andTitle:@"Error"];
        
    }

    
}


- (IBAction)btUpdateUserNamePress:(id)sender {
    if ([self.tfUser.text isEqualToString:self.tfReUser.text] && self.tfUser.text.length>0) {
        //change API
        NSString *linkChangeUserName = [NSString stringWithFormat:@"%@%@",API_CHANGE_USERNAME,self.app.seatUser.token];
        AFHTTPRequestOperationManager *af= [AFHTTPRequestOperationManager manager];
        af.responseSerializer = [AFHTTPResponseSerializer serializer];
        af.requestSerializer = [AFHTTPRequestSerializer serializer];
        NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
        [param setObject:self.tfUser.text forKey:@"username"];
        [af POST:linkChangeUserName parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (operation.response.statusCode ==200) {
                NSDictionary *dicResult = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                NSString *result = dicResult[@"status"];
                if (result.intValue==1) {
                    [SeatService alertFail:@"Change Username Success" andTitle:@"Success"];
                    
                }else {
                    [SeatService alertFail:[NSString stringWithFormat:@"Change Username not complete, Please Try again later"] andTitle:@"ERROR"];
                    
                     
                    
                }
                
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [SeatService alertFail:[NSString stringWithFormat:@"%@",error.localizedDescription] andTitle:@"ERROR"];
            
        }];
        
        
        
    }else {
        [SeatService alertFail:@"Username and Retype Username does not match " andTitle:@"Error"];
        
    }
}

- (IBAction)btUpdatePassPress:(id)sender {
    if ([self.tfPassword.text isEqualToString:self.tfRepassword.text] && self.tfPassword.text.length>0) {
        //change API
        NSString *linkChangePassWord = [NSString stringWithFormat:@"%@%@",API_CHANGEPASS,self.app.seatUser.token];
        AFHTTPRequestOperationManager *af= [AFHTTPRequestOperationManager manager];
        af.responseSerializer = [AFHTTPResponseSerializer serializer];
        af.requestSerializer = [AFHTTPRequestSerializer serializer];
        NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
        [param setObject:self.tfPassword.text forKey:@"password"];
        [af POST:linkChangePassWord parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (operation.response.statusCode ==200) {
                NSDictionary *dicResult = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
                NSString *result = dicResult[@"status"];
                if (result.intValue==1) {
                    [SeatService alertFail:@"Change Password Success" andTitle:@"Success"];
                    
                }else {
                    [SeatService alertFail:[NSString stringWithFormat:@"Change Password not complete, Please Try again later"] andTitle:@"ERROR"];
                    
                    
                    
                }
                
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [SeatService alertFail:[NSString stringWithFormat:@"%@",error.localizedDescription] andTitle:@"ERROR"];
            
        }];
        
        
        
    }else {
        [SeatService alertFail:@"Password and Retype Password does not match " andTitle:@"Error"];
        
    }

}
- (void)clickAboutBt{
    

    NSLog(@"clik about");
    NSURL *URL = [[NSBundle mainBundle] URLForResource:@"About" withExtension:@"pdf"];
    self.documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:URL];
    [self.documentInteractionController setDelegate:self];
    [self.documentInteractionController presentPreviewAnimated:YES];
    
}


- (void)clikButtonContact{
    

    NSLog(@"clik contact");
    MFMailComposeViewController *mf = [[MFMailComposeViewController alloc]init];
    mf.mailComposeDelegate = self;
    NSArray *toRecipents = [NSArray arrayWithObject:@"customerservice@seatfillersapp.com"];//customerservice@seatfillersapp.com
    [mf setToRecipients:toRecipents];
    
    [self presentViewController:mf animated:YES completion:nil];
    
    
    
}
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            [SeatService alertFail:@"Mail Send" andTitle:@" "];
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}


- (void)clickButtonSignOut{
    

    NSLog(@"clik sign out");
    UIAlertView *alertLogOut = [[UIAlertView alloc]initWithTitle:@"Log out" message:@"Do you really want to log out" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    alertLogOut.tag = 100;
    [alertLogOut show];
    
    
}




-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma alertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag==100) {
        if (buttonIndex==1) {
            AppDelegate *app = [[UIApplication sharedApplication]delegate];
            NSString *linkLogOut = [NSString stringWithFormat:@"%@%@",API_LOG_OUT,app.seatUser.token];
            AFHTTPRequestOperationManager *af = [AFHTTPRequestOperationManager manager];
            af.requestSerializer = [AFHTTPRequestSerializer serializer];
            af.responseSerializer = [AFHTTPResponseSerializer serializer];
            [af POST:linkLogOut parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                //
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                //
            }];
            SignIn *signIn = [[SignIn alloc]init];
            self.app.window.rootViewController = signIn;
            
            
        }
    }

}





@end
