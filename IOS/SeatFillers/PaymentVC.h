//
//  PaymentVC.h
//  SeatFillers
//
//  Created by phan hoang quoc an on 8/3/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import "ViewController.h"
#import <StoreKit/StoreKit.h>






@interface Plan : NSObject
@property(nonatomic,strong)NSString     *planTile;
@property(nonatomic,strong)NSString     *planDay;
@property(nonatomic,strong)NSString     *planDescription;
@property(nonatomic,strong)SKProduct    *planProduct;
@property(nonatomic,strong)NSString     *planId;
@property(nonatomic,strong)NSString     *sort;



@end



@interface UnitPrice : NSObject
@property(nonatomic,strong) NSString *upId;
@end

#define INAPP_PRODUCT_ID_1 @"SeatFiller.ID1"
#define INAPP_PRODUCT_ID_2 @"SeatFiller.ID2"
#define INAPP_PRODUCT_ID_3 @"SeatFiller.ID3"

@interface PaymentVC : ViewController<SKPaymentTransactionObserver,SKProductsRequestDelegate,UITableViewDelegate,UITableViewDataSource>{
        SKProductsRequest *productsRequest;
}
@property(nonatomic,strong) NSMutableArray *arrayValidProducts;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableLayoutHeigh;


- (void)fetchAvailableProducts;
- (BOOL)canMakePurchases;
- (void)purchaseMyProduct:(SKProduct*)product;
@property (weak, nonatomic) IBOutlet UITableView *tableProductList;


@end
