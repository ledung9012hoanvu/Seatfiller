//
//  SeatService.h
//  SeatFillers
//
//  Created by LeDung on 6/12/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"
#import "SeatMacro.h"





@interface SeatServiceResult : NSObject
@property(nonatomic,assign) NSInteger statusCode;
@property(nonatomic,strong) NSString *message;
@property(nonatomic,strong) NSString *error;
@property(nonatomic,strong) NSMutableDictionary *dictionaryResponse;

@end


@interface SeatService : AFHTTPRequestOperationManager
typedef enum
{
    SeatAPISingIn,
    SeatAPISingUp,
    SeatAPIForgotPass,
    SeatAPISetting,
    SeatAPISearchTicket,
    SeatAPIGetListTicket,
    SeatAPIAddTicket
} SeatAPIService;
+(instancetype)sharedClient;
+(AFHTTPRequestOperation*)callWebserviceAtRequestPOST:(BOOL)isPOST andApi:(SeatAPIService)path withParameters:(NSMutableDictionary *)params onSuccess:(void (^)(SeatServiceResult* result))successHandler onFailure:(void (^)(NSError *err))errorHandler;
+ (void)alertFail:(NSString*)message andTitle:(NSString*)title;
+ (void)boundView:(UIView*)view;

@end
