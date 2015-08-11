//
//  PaymentVC.h
//  SeatFillers
//
//  Created by phan hoang quoc an on 8/3/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import "ViewController.h"
#import <StoreKit/StoreKit.h>

@interface PaymentVC : ViewController<SKPaymentTransactionObserver,SKProductsRequestDelegate>{
    
    //IN APP PURCHASE
    SKProductsRequest *productsRequest;
    NSArray *validProducts;
}
//In APP Purchase

- (void)fetchAvailableProducts;
- (BOOL)canMakePurchases;
- (void)purchaseMyProduct:(SKProduct*)product;


@end
