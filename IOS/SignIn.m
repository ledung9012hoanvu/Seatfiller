//
//  SignIn.m
//  SeatFillers
//
//  Created by LeDung on 6/11/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import "SignIn.h"
#import "Home.h"
#import "AFHTTPRequestOperationManager.h"
#import "JGActionSheet.h"
#import "SignUp.h"
#import "ForgotPass.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
@interface SignIn ()<FBSDKLoginButtonDelegate,UIAlertViewDelegate>
@property (strong,nonatomic) NSString *accessToken;
@property (strong,nonatomic) NSString *deviceToken;

@property (strong,nonatomic) FBSDKLoginManager *fbManager;


@end

@implementation SignIn 

-(void)forgotSuccess
{
    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"Message" message:@"Please check your email !" delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
    [alert show];
    alert = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.app = [[UIApplication sharedApplication]delegate];
    self.deviceToken = [[NSUserDefaults standardUserDefaults]valueForKey:NEWTOKEN];
    if (self.deviceToken.length<1) {
        self.deviceToken = @"test";
    }
    [self setUpFaceBook];
    [self.ScrollKeyBoard setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + 50)];
    [self seatFillerDesign];
    [self fakeUsername];
}
- (void)setUpFaceBook{
    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    loginButton.delegate = self;
    loginButton.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    loginButton.frame = self.btLoginFB.frame;
    self.btLoginFB.alpha = 0;
    [self.viewSignIn addSubview:loginButton];
    self.fbManager = [[FBSDKLoginManager alloc]init];
    [self.fbManager logOut];
    [loginButton setFrame:CGRectMake(loginButton.frame.origin.x, loginButton.frame.origin.y,SCREEN_WIDTH-60, loginButton.frame.size.height)];
}

-(void)fakeUsername{
    self.tfUserName.text=@"dunglh9012";
    self.tfPassword.text=@"thanhdung";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.fbManager logOut];
    
}


//-----------------------------------------------ConnectLogin;
- (IBAction)btSignUpPress:(id)sender
{
    
    SignUp *signUp=[[SignUp alloc]init];
    UINavigationController *navi =[[UINavigationController alloc]initWithRootViewController:signUp];
    [self presentViewController:navi animated:YES completion:nil];
}



- (IBAction)btSigInPress:(id)sender
{
    
    
    [self.btSignIn setUserInteractionEnabled:NO];
    NSMutableDictionary *dictionary =[[NSMutableDictionary alloc]init];
    [dictionary setValue:self.tfUserName.text forKey:USER_NAME];
    [dictionary setValue:self.tfPassword.text forKey:USER_PASS];
    [dictionary setValue:self.deviceToken forKey:USER_DEVICETOKEN];
    [dictionary setValue:DEVICE_TYPE forKey:USER_DEVICETYPE];
    [dictionary setValue:APPVERSION forKey:@"app_version"];

    
    [SeatService callWebserviceAtRequestPOST:YES andApi:SeatAPISingIn withParameters:dictionary onSuccess:^(SeatServiceResult *result)
    {
        [self.btSignIn setUserInteractionEnabled:YES];
        if(result.statusCode==1)
        {
            [self signInSucceed];
            AppDelegate *appDelegate =[[UIApplication sharedApplication]delegate];
            appDelegate.seatUser =[SeatUser initWithDictionaryString:result.dictionaryResponse];
        }
        else
        {
            [self  signinFailure];
        }
        
    } onFailure:^(NSError *err)
    {
        [self.btSignIn setUserInteractionEnabled:YES];
        [self errorConnection];
    }];
}

- (IBAction)btFogotPress:(id)sender
{
    ForgotPass *fogot = [[ForgotPass alloc]init];
    fogot.forgotDelegate=self;
    UINavigationController *navi =[[UINavigationController alloc]initWithRootViewController:fogot];
    [self presentViewController:navi animated:YES completion:nil];
}
-(void)signInSucceed
{
    Home *home = [[Home alloc]init];
    UINavigationController *navi =[[UINavigationController alloc]initWithRootViewController:home];
    [self presentViewController:navi animated:YES completion:nil];
}
-(void)signinFailure
{
    NSLog(@"log error");
    [SeatService alertFail:@"Login Fail, Please Try Again" andTitle:@""];
}
-(void)errorConnection
{
    UIAlertView *allerView =[[UIAlertView alloc]initWithTitle:@"Message" message:@"Error Connection" delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
    [allerView show];
    allerView = nil;
}



//---------------------------------------------UITextfieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

//-----------------------------------------------



//-----------------------------------------------Code Interface
-(void)seatFillerDesign
{
    [SeatFillerDesign containView:self.viewSignIn];
    [SeatFillerDesign buttonStyleWithGreenColor:self.btSignIn];
    [SeatFillerDesign navigationDesign:self.navigationController];
    [SeatFillerDesign textField:self.tfPassword];
    [SeatFillerDesign textField:self.tfUserName];
    self.title=@"Sign In";
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}
-(void)dismissKeyboard
{
    [self.tfPassword resignFirstResponder];
    [self.tfUserName resignFirstResponder];
}



-(void)SignUpFinishWithUserName:(NSString *)userName andPass:(NSString *)pass
{
    NSLog(@"done Delegate");
    self.tfUserName.text =userName;
    self.tfPassword.text=pass;
}
- (void)logInFaceBook{
    NSString *link = [NSString stringWithFormat:@"%@",API_LOG_IN_FACEBOOK];
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setObject:self.accessToken forKey:@"accessToken"];
    [param setObject:self.deviceToken forKey:@"device_token"];
    [param setObject:APPVERSION forKey:@"app_version"];
    AFHTTPRequestOperationManager *af = [AFHTTPRequestOperationManager manager];
    af.responseSerializer = [AFHTTPResponseSerializer serializer];
    af.requestSerializer = [AFHTTPRequestSerializer serializer];
    [af POST:link parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        if (operation.response.statusCode==200) {
            NSMutableDictionary *dicResult = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            NSString *result = dicResult[@"status"];
            NSString *message = dicResult[@"message"];
            NSLog(@"dic login facebook %@",dicResult);
            
            if (result.intValue==1) {
                self.app.seatUser = [SeatUser initWithDictionaryString:dicResult];
                [self signInSucceed];
                
            }else {
                [SeatService alertFail:message andTitle:@"Error"];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SeatService alertFail:@"Can't login by Facebook, Try again!" andTitle:@"Error"];
    }];
}
#pragma FaceBook 
- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{
    NSLog(@"log out");
}
- (void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error{
    if (error==nil) {
        self.accessToken = [FBSDKAccessToken currentAccessToken].tokenString;
        if (self.accessToken.length>1) {
            //log in
            [self logInFaceBook];
        }else {
            [SeatService alertFail:@"Can't log in by Facebook, Try again!" andTitle:@"Error"];
        }
    }
}
#pragma Alert View 
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==1) {
        NSLog(@"click to payment view");
    }
}


@end
