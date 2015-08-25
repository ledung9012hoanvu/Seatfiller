//
//  SellerImage.m
//  SeatFillers
//
//  Created by phan hoang quoc an on 7/17/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import "SellerImage.h"

@interface SellerImage ()

@end

@implementation SellerImage

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Photo";
    NSString *link = [[NSUserDefaults standardUserDefaults]objectForKey:PHOTO_LINK];
    NSString *ImageLinkString = [NSString stringWithFormat:@"%@/%@",FOLDER_IMAGE,link];
    

    

    
    [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:YES];
    dispatch_async(dispatch_queue_create("download_image", nil), ^{
        NSData *dataImage = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageLinkString]];
       dispatch_async(dispatch_get_main_queue(), ^{
           
           
           
           [UIView transitionWithView:self.mainImageView
                             duration:0.5f
                              options:UIViewAnimationOptionTransitionFlipFromBottom
                           animations:^{
                               [self.mainImageView setImage:[UIImage imageWithData:dataImage]];
                           } completion:nil];

           
           [[UIApplication sharedApplication]setNetworkActivityIndicatorVisible:NO];
           
       });
    
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
