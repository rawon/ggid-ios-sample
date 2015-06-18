//
//  AppDelegate.m
//  GGID Sample
//
//  Created by Aditya Wirayudha on 18/06/15.
//  Copyright (c) 2015 Erasys Consulting. All rights reserved.
//

#import "AppDelegate.h"
#import "NXOAuth2.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

+ (void)initialize{
    [[NXOAuth2AccountStore sharedStore] setClientID:@"your app client id"
                                             secret:@"your app client secret"
                                   authorizationURL:[NSURL URLWithString:@"https://gg-id.net/o/authorize/?app=x"] //change this accordingly
                                           tokenURL:[NSURL URLWithString:@"https://gg-id.net/o/token/?app=x"] //change this accordingly
                                        redirectURL:[NSURL URLWithString:@"http://localhost/"] //change this according your app redirect URI
                                     forAccountType:@"ggidService"];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    return YES;
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
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
