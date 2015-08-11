//
//  SignIn.h
//  SeatFillers
//
//  Created by LeDung on 6/11/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeatFillerDesign.h"
#import "SeatTicket.h"
#import "SeatUser.h"
#import "SeatService.h"
#import "AppDelegate.h"
#import "SignUp.h"
#import "ForgotPass.h"
#import "TPKeyboardAvoidingScrollView.h"

@interface SignIn : UIViewController <UITextFieldDelegate,SignUpDelegate,ForgotDelegate>
@property (weak, nonatomic) IBOutlet UIView *viewSignIn;
@property (weak, nonatomic) IBOutlet UITextField *tfUserName;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UIButton *btSignIn;
@property (weak, nonatomic) IBOutlet UIButton *btSignUp;
@property (weak, nonatomic) IBOutlet UIButton *btForgot;
@property (nonatomic,strong) SignUp *signUp;
- (IBAction)btSignUpPress:(id)sender;

- (IBAction)btSigInPress:(id)sender;
- (IBAction)btFogotPress:(id)sender;
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *ScrollKeyBoard;

@property (weak, nonatomic) IBOutlet UIButton *btLoginFB;
@property (strong,nonatomic) AppDelegate *app;



@end
