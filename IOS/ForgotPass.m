//
//  ForgotPass.m
//  SeatFillers
//
//  Created by LeDung on 6/11/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import "ForgotPass.h"
#import "SeatFillerDesign.h"
#import "SeatService.h"
@interface ForgotPass ()

@end

@implementation ForgotPass

-(void)seatFillerDesign
{
    [SeatFillerDesign containView:self.containView];
    [SeatFillerDesign textField:self.tfMail];
    [SeatFillerDesign buttonStyleWithGreenColor:self.btSubmit];
    
    self.title = @"Forgot Password";
    self.tfMail.delegate = self;
    
    UIBarButtonItem *add =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(goBack)];
    [add setTintColor:[UIColor whiteColor]];
    self.navigationItem.leftBarButtonItem =add;
    
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [self.navigationController.navigationBar setBarTintColor:[SeatFillerDesign greenNavi]];

}

-(void)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self seatFillerDesign];
    [self.ScrollAvoidKeyBoard setContentSize:CGSizeMake(self.view.frame.size.width, self.view.frame.size.height + 100)];
    
    
    


}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [self seatFillerDesign];

}

- (IBAction)btSubmitPress:(id)sender
{
    [self.btSubmit setUserInteractionEnabled:NO];
    NSMutableDictionary*dictionary =[[NSMutableDictionary alloc]init];
    [dictionary setValue:self.tfMail.text forKey:@"email"];
    [SeatService callWebserviceAtRequestPOST:YES andApi:SeatAPIForgotPass withParameters:dictionary onSuccess:^(SeatServiceResult *result)
     {
         [self.btSubmit setUserInteractionEnabled:YES];
         if(result.statusCode==1)
         {
             [self dismissViewControllerAnimated:YES completion:^{
                 [self.forgotDelegate forgotSuccess];
             }];
         }
         else
         {
             [SeatService alertFail:@"Try again" andTitle:@"Error"];
         }
         
     } onFailure:^(NSError *err)
     {
         [self.btSubmit setUserInteractionEnabled:YES];
          [SeatService alertFail:@"Try again" andTitle:@"Error"];
     }];
}

-(void)fogotSuccedd
{
    [SeatService alertFail:@"Please check your email to take new password" andTitle:@""];
}
-(void)forgotFailure
{
    
}

@end
