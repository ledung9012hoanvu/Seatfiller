
#import "PaymentVC.h"
#import "SeatMacro.h"
#import "PaymentCell.h"
#import "UIView+LeafUI.h"
#import "Interface.h"
#import "SeatFillerDesign.h"
#import "UIView+LeafUI.h"
#import "SeatService.h"
#import "AppDelegate.h"
#define TABLE_PRODUCT_LIST_CELL_HEIGH 50

@interface PaymentVC ()
@property(nonatomic,strong) AppDelegate *app;
@property(nonatomic,strong) NSString *upgradeIdSelected;
@end

@implementation PaymentVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self seatFillerDesign];
    self.arrayValidProducts =[[NSMutableArray alloc]init];
    self.app =[[UIApplication sharedApplication]delegate];
    [self getListProductFromServer];
}

-(void)getListProductFromServer
{
    NSMutableDictionary *params =[[NSMutableDictionary alloc]init];
    [params setValue:self.app.seatUser.token forKey:@"token"];
    [SeatService callWebserviceAtRequestPOST:NO andApi:SeatAPIGetListPlan withParameters:params onSuccess:^(SeatServiceResult *result) {
        
        NSArray *array =[result.dictionaryResponse valueForKey:@"data"];;
        for(NSDictionary *dictionnary in array)
        {
            Plan *plan =[[Plan alloc]init];
            plan.planId = [dictionnary valueForKey:@"id"];
            plan.planTile =[dictionnary valueForKey:@"title"];
            plan.planDescription =[dictionnary valueForKey:@"description"];
            plan.sort =[dictionnary valueForKey:@"sort"];
            
            [self.arrayValidProducts addObject:plan];
        }
        [self fetchAvailableProducts];

    } onFailure:^(NSError *err) {
        
    }];
}

-(void)seatFillerDesign
{
    [Interface boderView:4 andwidth:2 andColor:[SeatFillerDesign greenNavi] andView:self.tableProductList];
    [self.tableProductList setBackgroundColor:[UIColor clearColor]];
    [self.tableProductList setSeparatorColor:[SeatFillerDesign greenNavi]];
    [[UITableViewCell appearance] setLayoutMargins:UIEdgeInsetsZero];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"Payment";
    self.navigationController.navigationBarHidden = NO;
    [self.tableProductList setSeparatorColor:[UIColor whiteColor]];
}

#pragma IN APP PURCHASE
-(void)fetchAvailableProducts{
    [self.view setUserInteractionEnabled:NO];
    NSSet *productIdentifiers = [NSSet setWithObjects:INAPP_PRODUCT_ID_1,INAPP_PRODUCT_ID_2,INAPP_PRODUCT_ID_3,nil];
    productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifiers];
    productsRequest.delegate = self;
    [productsRequest start];
}

- (BOOL)canMakePurchases
{
    return [SKPaymentQueue canMakePayments];
}

- (void)purchaseMyProduct:(SKProduct*)product{
    if ([self canMakePurchases])
    {
        SKPayment *payment = [SKPayment paymentWithProduct:product];
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                                  @"Purchases are disabled in your device" message:nil delegate:
                                  self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alertView show];
    }
}
#pragma mark StoreKit Delegate

-(void)paymentQueue:(SKPaymentQueue *)queue
updatedTransactions:(NSArray *)transactions {
    for (SKPaymentTransaction *transaction in transactions) {
        [self.view setUserInteractionEnabled:NO];
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"Purchasing");
                break;
            case SKPaymentTransactionStatePurchased:
            {
                [self.view setUserInteractionEnabled:YES];
                NSLog(@"payment succedd");
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                NSMutableDictionary *dictionary =[[NSMutableDictionary alloc]init];
                [dictionary setValue:self.app.seatUser.token forKey:@"token"];
                [dictionary setValue:self.upgradeIdSelected forKey:@"paymentId"];
                [dictionary setValue:self.upgradeIdSelected forKey:@"plan_id"];
                
                [SeatService callWebserviceAtRequestPOST:YES andApi:SeatAPIUpgradePlan withParameters:dictionary onSuccess:^(SeatServiceResult *result) {
                   
                    NSLog(@"all succedd");
                    
                } onFailure:^(NSError *err) {
                    
                }];
                break;
            }
                
            case SKPaymentTransactionStateRestored:
            {
                [self.view setUserInteractionEnabled:YES];
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            }
            case SKPaymentTransactionStateFailed:
            {
                [self.view setUserInteractionEnabled:YES];
                
                NSString *purchaseFail = [NSString stringWithFormat:@"%@",transaction.error.localizedDescription];
                
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                                          @"Purchase failed" message:purchaseFail delegate:
                                          self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [alertView show];
            }
                break;
            default:
                break;
        }
    }
}

-(void)productsRequest:(SKProductsRequest *)request
    didReceiveResponse:(SKProductsResponse *)response
{
    
    NSLog(@"count : %d",self.arrayValidProducts.count);
    [self.tableProductList setHidden:NO];
    [self.view setUserInteractionEnabled:YES];
    
    for (SKProduct *product in response.products)
    {
        NSString *productId =[product.productIdentifier substringFromIndex:product.productIdentifier.length-1];
        for (Plan *plan in self.arrayValidProducts)
        {
            if([plan.planId isEqualToString:productId])
            {
                plan.planProduct =product;
            }
            
        }
    }
    self.tableLayoutHeigh.constant=self.arrayValidProducts.count*TABLE_PRODUCT_LIST_CELL_HEIGH;
    [self.tableProductList reloadData];
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"PaymentCell";
    PaymentCell *cell = (PaymentCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"PaymentCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    Plan *unit =self.arrayValidProducts[indexPath.row];
    cell.labelType.text =unit.planTile;
    cell.labelCost.text =[self stringPriceFromSKProduct:unit.planProduct];
    cell.labelDescription.text=unit.planDescription;

    
    [cell.labelCost setTextColor:[UIColor whiteColor]];
    [cell.labelType setTextColor:[UIColor whiteColor]];
    [cell.labelDescription setTextColor:[UIColor whiteColor]];
    [cell setBackgroundColor:[UIColor clearColor]];
     cell.layoutMargins = UIEdgeInsetsZero;
    return cell;
}
-(NSString*)stringPriceFromSKProduct:(SKProduct*)product
{   NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setLocale:product.priceLocale];
    NSString *str = [formatter stringFromNumber:product.price];
    return str;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrayValidProducts.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Plan *plan =self.arrayValidProducts[indexPath.row];
    self.upgradeIdSelected =plan.planId;
    [self purchaseMyProduct:plan.planProduct];
}



@end








@implementation Plan



@end