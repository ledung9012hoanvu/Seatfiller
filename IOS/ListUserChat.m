//
//  ListUserChat.m
//  SeatFillers
//
//  Created by phan hoang quoc an on 7/22/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import "ListUserChat.h"
#import "SeatMacro.h"
#import "Interface.h"

@interface ListUserChat ()
@property (weak, nonatomic) IBOutlet UITableView *tbListChat;
@property (strong,nonatomic) AppDelegate *app;


@end

@implementation ListUserChat

- (void)viewDidLoad {
    [super viewDidLoad];
    [Interface boderView:4 andwidth:2 andColor:[UIColor blueColor] andView:self.tbListChat];
    
    
    
    [self callListUserChat];
    
    //NSLog(@"id: %@",self.ticket_id);
    
    // Do any additional setup after loading the view from its nib.
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *indentifier = @"cellListChat";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        
    }
    BookTicket *bookTic = self.listUser[indexPath.row];
    cell.textLabel.text = bookTic.byDisplayName;
    NSLog(@"buyerid:%@--bookid:%@",bookTic.BuyerId,bookTic.sid);
    
    
    
    //cell.textLabel.text = dic[@"by_displayname"];
    
    
    return cell;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listUser.count;
}
- (void)callListUserChat{
    self.app = [[UIApplication sharedApplication]delegate];
    self.listUser = [[NSMutableArray alloc]init];
    
    NSString *link = [NSString stringWithFormat:@"%@%@%@&ticket_id=%@",SEATSEVERADDRESS,API_BOOK_USER_TICKET,self.app.seatUser.token,self.ticket_id];
    NSLog(@"link book ticket:%@",link);
    
    AFHTTPRequestOperationManager *af = [AFHTTPRequestOperationManager manager];
    af.requestSerializer = [AFHTTPRequestSerializer serializer];
    af.responseSerializer =[AFHTTPResponseSerializer serializer];
    [af GET:link parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (operation.response.statusCode ==200) {
            NSDictionary *dic_result = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
            NSString *result = dic_result[@"status"];
            if (result.intValue==1) {
                //self.listUser = dic_result[@"data"];
                NSArray *arrBook = dic_result[@"data"];
                for (int i=0; i<arrBook.count; i++) {
                    BookTicket *bookTic = [BookTicket ticketFromDictionary:arrBook[i]];
                    [self.listUser addObject:bookTic];
                    
                    
                }
                [self.tbListChat reloadData];
                
            }else {
                NSLog(@"error result string");
                
            }
            
        }else {
            NSLog(@"error server");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self alertFail:[NSString stringWithFormat:@"%@",error.localizedDescription] andTitle:@"Error"];
    }];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ChatDetail *chatDetailVc = [[ChatDetail alloc]init];
    chatDetailVc.bookTic = self.listUser[indexPath.row];
    [self.navigationController pushViewController:chatDetailVc animated:YES];
    
    
}


- (void)alertFail:(NSString*)message andTitle:(NSString*)title{
    UIAlertView *alertUpdate = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertUpdate show];
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
