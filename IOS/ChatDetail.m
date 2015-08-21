//
//  AMViewController.m
//  BubbleTableDemo
//
//  Created by Andrea on 21/01/14.
//  Copyright (c) 2014 Fancy Pixel. All rights reserved.
//

#import "ChatDetail.h"
#import "AFHTTPRequestOperationManager.h"

@interface ChatDetail () <AMBubbleTableDataSource, AMBubbleTableDelegate>

@property (nonatomic, strong) NSMutableArray* data;

@end

@implementation ChatDetail

- (void)viewDidLoad
{
    // Bubble Table setup
    self.app = [[UIApplication sharedApplication]delegate];
    //NSLog(@"user name %@",self.app.seatUser.lastName);
    
    
    [self setDataSource:self]; // Weird, uh?
    [self setDelegate:self];
    
    [self setTitle:@"Chat"];
    self.data =[[NSMutableArray alloc] init];
    [self setTableStyle:AMBubbleTableStyleFlat];
    [self setBubbleTableOptions:@{AMOptionsBubbleDetectionType: @(UIDataDetectorTypeAll),
                                  AMOptionsBubblePressEnabled: @NO,
                                  AMOptionsBubbleSwipeEnabled: @NO,
                                  AMOptionsButtonTextColor: [UIColor colorWithRed:1.0f green:1.0f blue:184.0f/256 alpha:1.0f]}];
    
    [super viewDidLoad];
    
    [self.tableView setContentInset:UIEdgeInsetsMake(64, 0, 0, 0)];
    
    self.addLastComment = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(RequestAgain) userInfo:nil repeats:YES];
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.addLastComment invalidate];
    
}
- (void)getListComment{
    self.app = [[UIApplication sharedApplication]delegate];
    
    NSString *link =[NSString stringWithFormat:@"%@%@%@&book_id=%@&type=seller",SEATSEVERADDRESS,API_GET_LISTCOMMENT,self.app.seatUser.token,self.self.bookTic.sid];
    
    NSLog(@"link get comment:%@",link);
    AFHTTPRequestOperationManager *af = [AFHTTPRequestOperationManager manager];
    af.requestSerializer = [AFHTTPRequestSerializer serializer];
    af.responseSerializer = [AFHTTPResponseSerializer serializer];
   [af GET:link parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
       //
       if (operation.response.statusCode ==200) {
           NSDictionary *dic_result = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
           NSString *result = dic_result[@"status"];
           if (result.intValue==1) {
               NSArray *data = dic_result[@"data"];
               self.arrListChat = [self arrChar:data];
               for (int i=0; i<self.arrListChat.count; i++) {
                   NSDictionary *dicCom = self.arrListChat[i];
                   NSString *userId = dicCom[@"user_id"];
                   if (userId.intValue==self.bookTic.sellerId.intValue) {
                       //
                       NSMutableDictionary *dicComUser = [[NSMutableDictionary alloc]init];
                       NSString *message = [dicCom valueForKey:@"comment"];
                       [dicComUser setObject:[self null2Empty:[dicCom valueForKey:@"comment"]] forKey:@"text"];
                       [dicComUser setObject:@"1" forKey:@"type"];
                       [dicComUser setObject:self.app.seatUser.lastName forKey:@"username"];
                       [dicComUser setObject:[dicCom valueForKey:@"created"] forKey:@"time"];
                       [dicComUser setObject:[UIColor greenColor] forKey:@"color"];
                       [self.data addObject:dicComUser];
                       
                   }else {
                       NSMutableDictionary *dicComUser = [[NSMutableDictionary alloc]init];
                       [dicComUser setObject:@"2" forKey:@"type"];
                       [dicComUser setObject:[self null2Empty:[dicCom valueForKey:@"comment"]] forKey:@"text"];
                       [dicComUser setObject:self.bookTic.byDisplayName forKey:@"username"];
                       [dicComUser setObject:[dicCom valueForKey:@"created"] forKey:@"time"];
                       [dicComUser setObject:[UIColor blueColor] forKey:@"color"];
                       [self.data addObject:dicComUser];
                       }
                   [self.tableView reloadData];
                   [self scrollToBottomAnimated:NO];
               }
           }
       }
   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       [self alertFail:@"Can't loading message" andTitle:@"Error"];
   }];
    
}
- (NSMutableArray*)arrChar:(NSArray*)arrData{
    NSMutableArray *arrComment = [[NSMutableArray alloc]init];
    for (int i=(int)arrData.count-1; i>=0; i--) {
        NSDictionary *dic = arrData[i];
        NSString *userID = dic[@"user_id"];
        NSString *parent_id = dic[@"parent_id"];
        if ((userID.intValue==self.bookTic.sellerId.intValue ||userID.intValue==self.bookTic.BuyerId.intValue) && (parent_id.intValue==self.bookTic.sellerId.intValue ||parent_id.intValue==self.bookTic.BuyerId.intValue)) {
            [arrComment addObject:dic];
            
            
        }
        
    }
   // NSLog(@"crack app");
    return arrComment;
    
}

- (void)swipedCellAtIndexPath:(NSIndexPath *)indexPath withFrame:(CGRect)frame andDirection:(UISwipeGestureRecognizerDirection)direction
{
    NSLog(@"swiped");
}

#pragma mark - AMBubbleTableDataSource

- (NSInteger)numberOfRows
{
    return self.data.count;
}

- (AMBubbleCellType)cellTypeForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.data[indexPath.row][@"type"] intValue];
}

- (NSString *)textForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.data[indexPath.row][@"text"];
}

- (NSDate *)timestampForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self converFromTimeStamp:self.data[indexPath.row][@"time"]];
}

- (UIImage*)avatarForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [UIImage imageNamed:@"avatar"];
}

#pragma mark - AMBubbleTableDelegate

- (void)didSendText:(NSString*)text
{
    if (text.length>0) {
        NSString *link =[NSString stringWithFormat:@"%@%@&book_id=%@&recevier=%@&type=seller",API_COMMENT,self.app.seatUser.token,self.bookTic.sid,self.bookTic.BuyerId];
        NSLog(@"link send comment %@",link);
        NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
        [param setObject:text forKey:@"comment"];
        AFHTTPRequestOperationManager *af = [AFHTTPRequestOperationManager manager];
        af.requestSerializer = [AFHTTPRequestSerializer serializer];
        af.responseSerializer = [AFHTTPResponseSerializer serializer];
        [af POST:link parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (operation.response.statusCode==200) {
                [self getlastComment];
                
            }else {
                [self alertFail:@"Can't chat, Try again" andTitle:@"Error"];
                
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self alertFail:[NSString stringWithFormat:@"%@",error.localizedDescription] andTitle:@"Error"];
            
        }];
        
    }else {
        
    }
    
    
    
    
}

- (NSString*)usernameForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.data[indexPath.row][@"username"];
}

- (UIColor*)usernameColorForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.data[indexPath.row][@"color"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
- (NSDate*)converFromTimeStamp:(NSString*)timeStamp{
    double time = timeStamp.doubleValue;
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:time];
    return date;

}
- (void)RequestAgain{
    if (self.data==nil) {
        self.data = [[NSMutableArray alloc]init];
        self.idLastMessage = 0;
        NSLog(@"data nil");
        
        
    }else {
        NSDictionary *lastMessage = [self.data lastObject];
        NSString *lastMessageString = lastMessage[@"id"];
        if (lastMessageString.intValue>0) {
            self.idLastMessage=lastMessageString;
        }
        
    }
    [self getlastComment];
    
    
    
}
- (void)getlastComment
{
    NSLog(@"get last");
    self.app = [[UIApplication sharedApplication]delegate];
    NSString *link =[NSString stringWithFormat:@"%@%@%@&book_id=%@&type=seller",SEATSEVERADDRESS,API_GET_LISTCOMMENT,self.app.seatUser.token,self.bookTic.sid];
    NSLog(@"link get comment:%@",link);
    AFHTTPRequestOperationManager *af = [AFHTTPRequestOperationManager manager];
    af.requestSerializer = [AFHTTPRequestSerializer serializer];
    af.responseSerializer = [AFHTTPResponseSerializer serializer];
    [af GET:link parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //
        if (operation.response.statusCode ==200) {
            NSDictionary *dic_result = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            NSString *result = dic_result[@"status"];
            if (result.intValue==1) {
                NSArray *data = dic_result[@"data"];
                self.arrListChat = [self arrChar:data];
                for (int i=0; i<self.arrListChat.count; i++) {
                    NSDictionary *dicCom = self.arrListChat[i];
                    NSString *lastMess = dicCom[@"id"];
                    if (self.idLastMessage.floatValue<lastMess.floatValue) {
                        NSString *userId = dicCom[@"user_id"];
                        if (userId.intValue==self.bookTic.sellerId.intValue) {
                            //
                            NSMutableDictionary *dicComUser = [[NSMutableDictionary alloc]init];
                            [dicComUser setObject:[dicCom valueForKey:@"comment"] forKey:@"text"];
                            [dicComUser setObject:@"1" forKey:@"type"];
                            [dicComUser setObject:self.app.seatUser.lastName forKey:@"username"];
                            [dicComUser setObject:[dicCom valueForKey:@"created"] forKey:@"time"];
                            //[dicComUser setObject:[UIColor greenColor] forKey:@"color"];
                            [dicComUser setObject:[dicCom valueForKey:@"id"] forKey:@"id"];
                            self.idLastMessage = lastMess;
                            [self.data addObject:dicComUser];
                            
                        }else {
                            NSMutableDictionary *dicComUser = [[NSMutableDictionary alloc]init];
                            [dicComUser setObject:@"2" forKey:@"type"];
                            [dicComUser setObject:[dicCom valueForKey:@"comment"] forKey:@"text"];
                            [dicComUser setObject:self.bookTic.byDisplayName forKey:@"username"];
                            [dicComUser setObject:[dicCom valueForKey:@"created"] forKey:@"time"];
                            //[dicComUser setObject:[UIColor blueColor] forKey:@"color"];
                            [dicComUser setObject:[dicCom valueForKey:@"id"] forKey:@"id"];
                            self.idLastMessage = lastMess;
                            [self.data addObject:dicComUser];
                        }
                        [self.tableView reloadData];
                        [self scrollToBottomAnimated:NO];
                    }
                }
            }
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self alertFail:@"Can't loading message" andTitle:@"Error"];
    }];

    
}

- (void)alertFail:(NSString*)message andTitle:(NSString*)title{
    UIAlertView *alertUpdate = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertUpdate show];
}
-(NSString*)null2Empty:(NSString*)string
{
    if([[NSString stringWithFormat:@"%@", string] isEqualToString:@"<null>"])
    {
        return @" ";
    }
    return [NSString stringWithFormat:@"%@",string];
}

@end
