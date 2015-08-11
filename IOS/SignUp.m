//
//  SignUp.m
//  SeatFillers
//
//  Created by LeDung on 6/11/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import "SignUp.h"
#import "SeatService.h"
#import "AppDelegate.h"
#import "SeatService.h"
#import "SeatMacro.h"
#import "Home.h"
#import "SeatFillerDesign.h"
@interface SignUp ()

@end

@implementation SignUp

- (void)viewDidLoad {
    [super viewDidLoad];
    [self seatFillerDesign];
    [self.tpVIew setContentSize:CGSizeMake(self.tpVIew.frame.size.width, self.tpVIew.frame.size.height + 200)];
    
    
    
    

}


-(void)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)seatFillerDesign
{
    [SeatFillerDesign containView:self.containView];
    self.title =@"Sign Up";
    [SeatFillerDesign textField:self.tfEmail];
    [SeatFillerDesign textField:self.tfFirstName];
    [SeatFillerDesign textField:self.tfLastName];
    [SeatFillerDesign textField:self.tfPassword];
    [SeatFillerDesign textField:self.tfRetypePassword];
    [SeatFillerDesign textField:self.tfUserName];
    [SeatFillerDesign buttonStyleWithGreenColor:self.btSignUp];
    [SeatFillerDesign buttonStyleWithGreenColor:self.btTerm];
    [self.btTerm setBackgroundColor:[UIColor whiteColor]];
    [self.tpVIew setBackgroundColor:[UIColor clearColor]];
    
    [self.btTerm.layer setCornerRadius:17];
    [self.btTerm setBackgroundColor:[UIColor whiteColor]];
    self.btTerm.layer.masksToBounds =
    YES;
    [self.btTerm setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    
    UIBarButtonItem *add =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(goBack)];
    [add setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem =add;
    

    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:[SeatFillerDesign greenNavi]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark ---------------------------------------------TextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}
//-------------------------------------------------------------






#pragma mark ---------------------------------------------TextFieldDelegate

- (IBAction)btSignUpPress:(id)sender
{
    if ([self.tfPassword.text isEqualToString:self.tfRetypePassword.text]) {
        if(self.isAcceppt)
        {
            NSLog(@"signup press");
            [self.btSignUp setUserInteractionEnabled:NO];
            NSMutableDictionary *dictionary =[[NSMutableDictionary alloc]init];
            [dictionary setValue:self.tfUserName.text forKey:USER_NAME];
            [dictionary setValue:self.tfPassword.text forKey:USER_PASS];
            [dictionary setValue:self.tfFirstName.text forKey:USER_FIRSTNAME];
            [dictionary setValue:self.tfLastName.text forKey:USER_LASTNAME];
            [dictionary setValue:self.tfEmail.text forKey:USER_EMAIL];
            [dictionary setValue:self.tfRetypePassword.text forKey:USER_REPASS];
            
            
            NSLog(@"dictionary send : %@",dictionary);
            
            NSLog(@"user name : %@", self.tfUserName.text);
            [SeatService callWebserviceAtRequestPOST:YES andApi:SeatAPISingUp withParameters:dictionary onSuccess:^(SeatServiceResult *result) {
                [self.btSignUp setUserInteractionEnabled:YES];
                
                if(result.statusCode==1)
                {
                    [self signUpSucceed];
                }
                else
                {
                    [self  signinFailure];
                    
                }
                
            } onFailure:^(NSError *err)
             {
                 [self.btSignUp setUserInteractionEnabled:YES];
                 [self errorConnection];
             }];
            
        }
        else
        {
            [SeatService alertFail:@"You not agree Term of Use" andTitle:@"Error"];
        }

        
    }else {
        [SeatService alertFail:@"Password and Re-type PassWord don't same " andTitle:@"Error"];
    }
    
    
}//----------------------------------------------------------------------


-(void)signUpSucceed
{
    [self dismissViewControllerAnimated:YES completion:^{
        [_signUpDelegate SignUpFinishWithUserName:self.tfUserName.text andPass:self.tfPassword.text];
        [SeatService alertFail:@"Sign Up Successfull" andTitle:@""];
    }];
}


-(void)errorConnection
{
    UIAlertView *allerView =[[UIAlertView alloc]initWithTitle:@"Message" message:MESSAGE_ERROR_CONNECT delegate:self cancelButtonTitle:@"Dismiss" otherButtonTitles: nil];
    [allerView show];
    allerView = nil;
}
-(void)signinFailure
{
    [SeatService alertFail:@"Sign up Fail, Please Try again" andTitle:@"Error"];
    
    
}





- (IBAction)btTermPress:(id)sender
{
    if(self.isAcceppt)
    {
        self.isAcceppt =NO;
        [self.btTerm setBackgroundImage:nil forState:UIControlStateNormal];
    }
    else
    {
        self.isAcceppt=YES;
        [self.btTerm setBackgroundImage:[UIImage imageNamed:@"Accept"] forState:UIControlStateNormal];
    }
}
@end
