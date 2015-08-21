//
//  PaymentVC.h
//  SeatFillers
//
//  Created by phan hoang quoc an on 8/3/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import "ViewController.h"
#import <StoreKit/StoreKit.h>



#define INAPP_PRODUCT_ID_1 @"HoanVu.Type1"
#define INAPP_PRODUCT_ID_2 @"HoanVu.Type2"
#define INAPP_PRODUCT_ID_3 @"HoanVu.Type3"


@interface PaymentVC : ViewController<SKPaymentTransactionObserver,SKProductsRequestDelegate,UITableViewDelegate,UITableViewDataSource>{
        SKProductsRequest *productsRequest;
}
@property(nonatomic,strong) NSArray *arrayValidProducts;


- (void)fetchAvailableProducts;
- (BOOL)canMakePurchases;
- (void)purchaseMyProduct:(SKProduct*)product;
@property (weak, nonatomic) IBOutlet UITableView *tableProductList;


@end
