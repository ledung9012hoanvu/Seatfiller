//
//  SignUp.h
//  SeatFillers
//
//  Created by LeDung on 6/11/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPKeyboardAvoidingScrollView.h"
#import "SeatFillerDesign.h"




@protocol SignUpDelegate <NSObject>

@required
-(void)SignUpFinishWithUserName:(NSString*)userName andPass:(NSString*)pass;

@end


@interface SignUp : UIViewController <UITextFieldDelegate>
{
    
    id <SignUpDelegate>  __weak  _signUpDelegate;
}

@property (weak, nonatomic) IBOutlet UIView *containView;
@property(nonatomic,weak) id signUpDelegate;


- (IBAction)btSignUpPress:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfFirstName;
@property (weak, nonatomic) IBOutlet UITextField *tfLastName;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UITextField *tfRetypePassword;
@property (weak, nonatomic) IBOutlet UIButton *btTerm;
@property (weak, nonatomic) IBOutlet UITextField *tfUserName;
@property (weak, nonatomic) IBOutlet UIButton *btSignUp;
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *tpVIew;
@property (weak, nonatomic) IBOutlet UITextView *tfTerm;

@property(nonatomic)BOOL isAcceppt;
- (IBAction)btTermPress:(id)sender;
@end
