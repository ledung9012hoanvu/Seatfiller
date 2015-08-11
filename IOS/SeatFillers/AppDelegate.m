//
//  AppDelegate.m
//  SeatFillers
//
//  Created by LeDung on 6/11/15.
//  Copyright (c) 2015 ; Solutions. All rights reserved.
//

#import "AppDelegate.h"
#import "CSVParser.h"
#import "CHCSVParser.h"
#import "USCityReader.h"
#import "SignIn.h"
#import "SellerReview.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>

#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface AppDelegate () <CHCSVParserDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.dictionaryCiteState =[[NSMutableDictionary alloc]init];
    [USCityReader sharedClient];
    
    
    
    self.window.rootViewController =[[SignIn alloc]init];
    //self.window.rootViewController = [[SellerReview alloc]init];
    
    
    [application setStatusBarStyle:UIStatusBarStyleLightContent];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        UIUserNotificationSettings *settings =
        [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert |
         UIUserNotificationTypeBadge |
         UIUserNotificationTypeSound
                                          categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    else
    {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         UIRemoteNotificationTypeAlert |
         UIRemoteNotificationTypeBadge |
         UIRemoteNotificationTypeSound];
    }
    
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                    didFinishLaunchingWithOptions:launchOptions];
}
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken
{
    // Store the deviceToken.
    NSLog(@"------------%@", newDeviceToken);
    NSString *newToken = [newDeviceToken description];
    newToken = [newToken stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    newToken = [newToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (newToken.length>0){
        [[NSUserDefaults standardUserDefaults]setObject:newToken forKey:NEWTOKEN];
        
    }
    
    
    NSLog(@"My token is: %@", newToken);
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"Failed To Register For Remote Notifications With Error: %@", error);
    
    
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"receipush user info *@",userInfo);
    
    
    
}

- (void)parser:(CHCSVParser *)parser didReadField:(NSString *)field atIndex:(NSInteger)fieldIndex
{
    NSLog(@"field %@ ",field);
}

-(void)parserDidEndDocument:(CHCSVParser *)parser
{
    NSLog(@"----%@",parser );
}

- (void) parser:(CHCSVParser *)parser didStartDocument:(NSString *)csvFile {
    NSLog(@"Parser started!");
}

- (void) parser:(CHCSVParser *)parser didStartLine:(NSUInteger)lineNumber {
    NSLog(@"Parser started line: %i", lineNumber);
    
}

- (void) parser:(CHCSVParser *)parser didEndLine:(NSUInteger)lineNumber {
    
}

- (void) parser:(CHCSVParser *)parser didReadField:(NSString *)field
{
    NSLog(@"Parser didReadField: %@", field);
}

- (void) parser:(CHCSVParser *)parser didEndDocument:(NSString *)csvFile
{
    NSLog(@"Parser ended document: %@", csvFile);
}

- (void) parser:(CHCSVParser *)parser didFailWithError:(NSError *)error
{
    NSLog(@"Parser failed with error: %@ %@", [error localizedDescription], [error userInfo]);
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [FBSDKAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

@end
