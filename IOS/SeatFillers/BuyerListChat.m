
#import "BuyerListChat.h"
#import "BuyerHome.h"
#import "ChatDetail.h"
#import "SEConfig.h"
#import "AppDelegate.h"
#import "SeatFillerDesign.h"
#import "BuyerListChatCell.h"
#import "UIImageView+AFNetworking.h"

@interface BuyerListChat ()
@property(nonatomic,strong)AppDelegate *appDelegate;
@end

@implementation BuyerListChat

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.tabBarController setTitle:@"Buyer Chat Room"];
}

- (void)viewDidLoad {
    self.appDelegate =[[UIApplication sharedApplication]delegate];
    [super viewDidLoad];
    [self setUpInterFace];
    self.buyerHome =self.tabBarController.viewControllers[0];
    [self fillData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fillData) name:NOTIFICATION_KEY_CHANGE_TICKET object:nil];
}
- (void)setUpInterFace{
    [SeatFillerDesign viewGeneralWithBlueHeader:self.tbLishChat];
    [self.tbLishChat setSeparatorColor:[UIColor clearColor]];
    [self seatFillerDesign];
}

-(void)seatFillerDesign
{
}
- (void)fillData
{
    self.arrayUserChat =[NSMutableArray arrayWithArray:self.buyerHome.ticketArray];
    [self.tbLishChat reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *simpleTableIdentifier = @"BuyerListChatCell";
    BuyerListChatCell *cell = (BuyerListChatCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"BuyerListChatCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    SeatTicket *unitSeatTicket = self.arrayUserChat[indexPath.row];
    UIImageView *line =[[UIImageView alloc]initWithFrame:CGRectMake(0, cell.frame.size.height-1, 600, 1)];
    [line setBackgroundColor:[SeatFillerDesign greenNavi]];
    [cell addSubview: line];
    cell.lbTicketType.text = unitSeatTicket.title;
    cell.lbUser.text =unitSeatTicket.byUser;
    [cell.imgTicket setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",FOLDER_IMAGE,unitSeatTicket.imageURLString]] placeholderImage:[UIImage imageNamed:@"ic_attach_photos"]];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    [Interface boderView:4 andwidth:0.5 andColor:[UIColor clearColor] andView:cell.imgTicket];
    return cell;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayUserChat.count;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ChatDetail *chatDetail =[[ChatDetail alloc]init];
    SeatTicket *seatTicket = self.arrayUserChat[indexPath.row];
    BookTicket *bookTicket =[[BookTicket alloc]init];
    bookTicket.sid = seatTicket.bookId;
    bookTicket.sellerId=seatTicket.userId;
    bookTicket.BuyerId =self.appDelegate.seatUser.userId;
    bookTicket.byUsername=seatTicket.username;
    chatDetail.bookTic=bookTicket;
    [self.navigationController pushViewController:chatDetail animated:YES];
}


@end
