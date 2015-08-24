//
//  PaymentVC.m
//  SeatFillers
//
//  Created by phan hoang quoc an on 8/3/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import "PaymentVC.h"
#import "SeatMacro.h"
#import "PaymentCell.h"
#import "UIView+LeafUI.h"
#import "Interface.h"
#import "SeatFillerDesign.h"

#define TABLE_PRODUCT_LIST_CELL_HEIGH 50
@interface PaymentVC ()

@end

@implementation PaymentVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self seatFillerDesign];
    [self fetchAvailableProducts];
}

-(void)seatFillerDesign
{
    [Interface boderView:4 andwidth:2 andColor:[SeatFillerDesign greenNavi] andView:self.tableProductList];
    [self.tableProductList setBackgroundColor:[UIColor clearColor]];
    self.tableProductList.separatorStyle=UITableViewCellSeparatorStyleNone;
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
    NSSet *productIdentifiers = [NSSet
                                 setWithObjects:@"SeatFiller.Type1",nil];
    productsRequest = [[SKProductsRequest alloc]
                       initWithProductIdentifiers:productIdentifiers];
    
    productsRequest.delegate = self;
    [productsRequest start];
}

- (BOOL)canMakePurchases
{
    return [SKPaymentQueue canMakePayments];
}

- (void)purchaseMyProduct:(SKProduct*)product{
    if ([self canMakePurchases]) {
        SKPayment *payment = [SKPayment paymentWithProduct:product];
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
    else{
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
    
    for (NSString *invalidProductId in response.invalidProductIdentifiers)
    {
        NSLog(@"Invalid product id: %@" , invalidProductId);
    }

    NSLog(@"response : %@",response.products);
    [self.tableProductList setHidden:NO];
    [self.view setUserInteractionEnabled:YES];
        self.arrayValidProducts = response.products;
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
    
    SKProduct *unit =self.arrayValidProducts[indexPath.row];
    cell.labelType.text =unit.localizedTitle;
    cell.labelCost.text =[NSString stringWithFormat:@"$%@",@"abc"];
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell.labelCost setTextColor:[UIColor redColor]];
    [cell.labelType setTextColor:[UIColor redColor]];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"counter : %d",self.arrayValidProducts.count);
    return self.arrayValidProducts.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SKProduct *product =self.arrayValidProducts[indexPath.row];
    [self purchaseMyProduct:product];
}

@end
