//
//  SeatMacro.h
//  SeatFillers
//
//  Created by LeDung on 6/12/15.
//  Copyright (c) 2015 HoangVu Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SeatMacro : NSObject


#pragma mark----------------------------------------------APP MESSAGE
#define MESSAGE_ERROR_CONNECT @"Error connection"
#define MESSAGE_SIGNUP_COMLETE @""
#define MESSAGE_ADD_TICKET_SUCCESS @""
#define MESSAGE_PASS_USER_NAME_INVAL


#pragma mark----------------------------------------------API KEY


#define TICKET_ID                   @"id"
#define TICKET_TITLE                 @"title"
#define TICKET_CREATED              @"created"
#define TICKET_STATUS               @"status"
#define TICKET_START_DATE           @"start_date"
#define TICKET_TIME                 @"start_time"
#define TICKET_ADDRESS              @"address"
#define TICKET_PRICE_RANGE          @"price_range"
#define TICKET_NOTE                 @"note"
#define TICKET_QTY                  @"qty"
#define TICKET_TYPE                  @"type"

#define TICKET_STATE                 @"state"
#define TICKET_CITY                  @"city"





#define USER_ID             @"user_id"
#define USER_NAME           @"username"
#define USER_EMAIL          @"email"
#define USER_PASS           @"password"
#define USER_REPASS         @"repassword"

#define USER_TYPE           @"type"
#define USER_FIRSTNAME      @"first_name"
#define USER_LASTNAME       @"last_name"
#define USER_DEVICETOKEN    @"device_token"
#define USER_TOKEN          @"token"
#define USER_PLANID         @"plan_id"
#define USER_FBID           @"facebook_id"
#define USER_STATUS         @"status"
#define USER_DEVICETYPE     @"device_type"
#define TOKEN_ACCESS        @"token"




#define IS_IPHONE_4 ( [ [ UIScreen mainScreen ] bounds ].size.height < 568)
#define IS_IPHONE_5 ( [ [ UIScreen mainScreen ] bounds ].size.height == 568)
#define IS_IPHONE_6 ( [ [ UIScreen mainScreen ] bounds ].size.height == 667)
#define IS_IPHONE_6P ( [ [ UIScreen mainScreen ] bounds ].size.height > 667)
#define SCREEN_WIDTH [ [ UIScreen mainScreen ] bounds ].size.width




#define TICKET_TYPE_ARAY    [NSArray arrayWithObjects:@"Sports",@"Concert",@"Liberal Arts", nil]
#define SETTING_ARRAY    [NSArray arrayWithObjects:@"Notifications",@"Sound",@"Vibretion",@"Change Password",@"Update Account" nil]







#pragma marm-------------------------------------------------APP INFOMATION

#define APPVERSION  @"1.0"
#define DEVICE_TYPE @"IPHONE"

#pragma mark--------------------------------------------------API PATH

#define SEATSEVERADDRESS            @"http://52.68.134.162"
#define API_LOGIN_SOCIAL
#define API_SIGNUP                  @"/api/user/register"
#define API_SIGNIN                  @"/api/user/login"
#define API_SIGNFORGOT              @"/api/user/forgotPassword"
#define API_CHANGEPASS              @"http://52.68.134.162/api/user/changePassword?token="
#define API_CHANGEMAIL              @"http://52.68.134.162/api/user/changeEmail?token="
#define AP_DELETE_COMMENT
#define API_SEND_COMMENT
#define API_CHANGE_USERNAME         @"http://52.68.134.162/api/user/changeUsername?token="


#define API_CREATETICKET            @"/api/ticket/create?token="
#define API_GETLISTTICKET           @"/api/ticketbook/getList"
#define API_SEARCH                  @"/api/ticket/search?token="
#define API_DELETE_TICKET           @"/api/ticket/delete?token="
#define API_UPDATE_TICKET           @"/api/ticket/update?token="
#define API_LIST_COMMNET



#define API_VIEW_TICKET           @"/api/ticketbook/view"
#define API_BOOK_TICKET           @"/api/ticket/bookTicket"
#define FOLDER_IMAGE               @"http://52.68.134.162/www/uploads/events/"
#define API_REPORT                 @"/api/user/sendReport?token="
#define API_BOOK_USER_TICKET            @"/api/ticketbook/getListUserBook?token="
#define API_GET_LISTCOMMENT         @"/api/comment/getList?token="
#define API_COMMENT                 @"http://52.68.134.162/api/comment/replyTo?token="
#define API_LIST_BUYER_TICKET       @"http://52.68.134.162/api/ticketbook/getList?token="
#define API_SUBMIT_TICKET            @"http://52.68.134.162/api/ticket/bookTicket?token="

#define API_LOG_OUT                  @"http://52.68.134.162/api/token/logout?token="
#define API_LOG_IN_FACEBOOK          @"http://52.68.134.162/api/user/loginFb"
#define API_CHECK_USER_EXPIRE        @"http://52.68.134.162/api/user/checkUserExpired?token="

#pragma mark-----------------------------clik add event
#define CLICK_ADD_EVENT @"clickAddEvent"
#define PUSH_SEAT @"PushSeat"


#define PHOTO_LINK @"photoLink"
#define NEWTOKEN @"newtoken"

#define ITEM_PURCHASE    @"1029357497"









@end
