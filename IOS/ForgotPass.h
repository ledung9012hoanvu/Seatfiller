//
//  ForgotPass.h
//  SeatFillers
//
//  Created by LeDung on 6/11/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SeatFillerDesign.h"
#import "TPKeyboardAvoidingScrollView.h"



@protocol ForgotDelegate <NSObject>

@optional
-(void)forgotSuccess;

@end


@interface ForgotPass : UIViewController<UITextFieldDelegate>
{
    id  <ForgotDelegate> __weak _forgotDelegate ;
}
@property (weak, nonatomic) IBOutlet UITextField *tfMail;

@property (weak, nonatomic) IBOutlet UIButton *btSubmit;
- (IBAction)btSubmitPress:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *containView;
@property (nonatomic,weak) id forgotDelegate ;
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *ScrollAvoidKeyBoard;



@end
