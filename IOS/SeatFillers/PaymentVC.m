//
//  PaymentVC.m
//  SeatFillers
//
//  Created by phan hoang quoc an on 8/3/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import "PaymentVC.h"
#import "SeatMacro.h"

@interface PaymentVC ()

@end

@implementation PaymentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // IN APP PURCHASE
    
    [self fetchAvailableProducts];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.title = @"Payment";
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma IN APP PURCHASE

-(void)fetchAvailableProducts{
    NSSet *productIdentifiers = [NSSet
                                 setWithObjects:ITEM_PURCHASE,nil];
    productsRequest = [[SKProductsRequest alloc]
                       initWithProductIdentifiers:productIdentifiers];
    productsRequest.delegate = self;
    [productsRequest start];
    NSLog(@"product : %@",productIdentifiers);
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
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"Purchasing");
                break;
            case SKPaymentTransactionStatePurchased:
            {
                
               //goi  API mua thanh cong
                
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            }
                
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"Restored ");
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
            {
                
                
                //NSLog(@"Purchase failed %@",transaction.error.localizedDescription);
                NSString *purchaseFail = [NSString stringWithFormat:@"%@",transaction.error.localizedDescription];
                
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                                          @"Purchase failed" message:purchaseFail delegate:
                                          self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [alertView show];
                //buttonBuy.enabled = YES;
                
                
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
    SKProduct *validProduct = nil;
    long count = [response.products count];
    if (count>0) {
        validProducts = response.products;
        validProduct = [response.products objectAtIndex:0];
        if ([validProduct.productIdentifier
             isEqualToString:ITEM_PURCHASE]) {
            NSLog(@"Product Title:%@. Product Price: %@. Product Description: %@. Product identifier:%@",validProduct.localizedTitle,validProduct.price,validProduct.localizedDescription,validProduct.productIdentifier);
            
            
        }
    } else {
        UIAlertView *tmp = [[UIAlertView alloc]
                            initWithTitle:@"Not Available"
                            message:@"No products to purchase"
                            delegate:self
                            cancelButtonTitle:nil
                            otherButtonTitles:@"Ok", nil];
        [tmp show];
    }
    //[activityIndicatorView stopAnimating];
    //buttonBuy.hidden = NO;
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
