//
//  AppDelegate.m
//  Act
//
//  Created by Shinya Matsuyama on 10/27/13.
//  Copyright (c) 2013 Shinya Matsuyama. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Color

//  アプリで共通して使う色
- (UIColor*)darkColor
{
    return UIColorFromRGB(0x12826c);
}

- (UIColor*)lightColor
{
    return UIColorFromRGB(0x1abc9c);
}

- (UIColor*)lightDownColor
{
    return UIColorFromRGB(0x18ad8f);
}

- (UIColor*)textColor
{
    return UIColorFromRGB(0xffffff);
}

#pragma mark - Font

//  アプリで共通して使うフォント
- (UIFont*)naviTitleFont
{
    return [UIFont fontWithName:@"Futura-CondensedMedium" size:28.0];
}

@end
