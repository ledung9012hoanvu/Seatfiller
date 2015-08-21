//
//  SeatService.m
//  SeatFillers
//
//  Created by LeDung on 6/12/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import "SeatService.h"
#import "SeatUser.h"
#import "AppDelegate.h"

@implementation SeatService
+(instancetype)sharedClient
{
    NSLog(@"share client");
    static SeatService *seatSevice =nil;
    static dispatch_once_t onceToken;
    dispatch_once (&onceToken,^
                   {
                      if(seatSevice ==nil)
                      {
                          seatSevice =[[SeatService alloc]initWithBaseURL:[NSURL URLWithString:SEATSEVERADDRESS]];
                          seatSevice.responseSerializer.acceptableContentTypes = [seatSevice.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
                      };
                   });
    return seatSevice;
}

+(NSString*)getRequesStringFromPath:(SeatAPIService)path
{
    NSString *request = nil;
    AppDelegate *app =[[UIApplication sharedApplication]delegate];
    SeatUser *seatUser =app.seatUser;
    
    switch (path)
    {
        case SeatAPISingUp:
            request = API_SIGNUP;
            break;
        case SeatAPISingIn:
            request = API_SIGNIN;
            break;
        case SeatAPIForgotPass:
            request = API_SIGNFORGOT;
            break;
        case SeatAPIGetListTicket:
            request = API_GETLISTTICKET;
            break;
        case SeatAPISearchTicket:
            request = [API_SEARCH stringByAppendingString:seatUser.token];
            break;
        case SeatAPISetting:
            request = API_SEARCH ;
            break;
        case SeatAPIAddTicket:
            request = [API_CREATETICKET stringByAppendingString:seatUser.token];
        case SeatAPIGetListComment:
            request=API_GET_LIST_COMMNET;
            break;
        case SeatAPIComment:
            request =API_COMMENT;
            break;
    }
    return request;
}



+(NSMutableDictionary*)callSignInWithUsername:(NSString*)username andPass:(NSString*)password andDeviceToken:(NSString*)deviceToken andDeviceType:(NSString*)deviceType andAppVersion:(NSInteger)appVersion
{
    NSMutableDictionary *dictionary =[[NSMutableDictionary alloc]init];
    [dictionary setValue:username forKey:USER_NAME];
    [dictionary setValue:password forKey:USER_PASS];
    return dictionary;
}

#pragma mark ----------------------------------Webservice ---------POST
+(AFHTTPRequestOperation*)callWebserviceAtRequestPOST:(BOOL)isPOST andApi:(SeatAPIService)path withParameters:(NSMutableDictionary *)params onSuccess:(void (^)(SeatServiceResult* result))successHandler onFailure:(void (^)(NSError *err))errorHandler;
{
    
    NSLog(@"parameter : %@",params);
    NSLog(@"path : %@",[SeatService getRequesStringFromPath:path]);

    
    if(isPOST)
    {
    return  [[SeatService sharedClient] POST:[SeatService getRequesStringFromPath:path] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
      [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        SeatServiceResult *result =[[SeatServiceResult alloc]init];
        result.dictionaryResponse = [[NSMutableDictionary alloc]initWithDictionary:responseObject copyItems:YES];
        NSLog(@"DictionatyResponse--------------%@",result.dictionaryResponse);
        result.statusCode = [(NSString*)[result.dictionaryResponse valueForKey:@"status"] integerValue];
        dispatch_async(dispatch_get_main_queue(), ^{
            successHandler(result);
        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",operation.responseString);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Error--------------%@",error.description);

            errorHandler(nil);
        });
    }];
    }
    
    
    else
    {
        return  [[SeatService sharedClient] GET:[SeatService getRequesStringFromPath:path] parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            SeatServiceResult *result =[[SeatServiceResult alloc]init];
            result.dictionaryResponse = [[NSMutableDictionary alloc]initWithDictionary:responseObject copyItems:YES];
            NSLog(@"DictionatyResponse--------------%@",result.dictionaryResponse);
            result.statusCode = [(NSString*)[result.dictionaryResponse valueForKey:@"status"] integerValue];
            dispatch_async(dispatch_get_main_queue(), ^{
                successHandler(result);
            });
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            NSLog(@"%@",operation.responseString);
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"Error--------------%@",error.description);
                errorHandler(nil);
            });
        }];
    }

    
}







#pragma mark ---------------------// CreatGetPath
+(NSString*)callListTicket:(NSString*)token andType:(NSString*)type andStatus:(NSString*)status
{
    NSString *path =[[SEATSEVERADDRESS stringByAppendingString:API_GETLISTTICKET] stringByAppendingString:@""];
    NSString *tokenKey =[[@"token=" stringByAppendingString:token] stringByAppendingString:@"&"];
    NSString *typeKey =[[@"type="stringByAppendingString:type] stringByAppendingString:@"&"];
    NSString *statusKey =[[@"status="stringByAppendingString:status] stringByAppendingString:@"&"];
    path =[[[path stringByAppendingString:tokenKey] stringByAppendingString:typeKey] stringByAppendingString:statusKey];
    return path;
}
+ (void)alertFail:(NSString*)message andTitle:(NSString*)title{
    UIAlertView *alertUpdate = [[UIAlertView alloc]initWithTitle:title message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertUpdate show];
}
+ (void)boundView:(UIView *)view{
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = view.frame.size.height/2;
    
}






@end


@implementation SeatServiceResult



@end
