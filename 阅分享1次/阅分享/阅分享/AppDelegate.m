//
//  AppDelegate.m
//  阅分享
//
//  Created by  任京记 on 16/6/14.
//  Copyright © 2016年  任京记. All rights reserved.
//

#import "AppDelegate.h"
#import "RJJTabBarVc.h"
#import "RJJNavigationVv.h"
#import "RJJMemberNavVC.h"
#import "RJJDotNavigationVc.h"
#import "RJJBookNavigaionVc.h"
#import "RJJFriendViewController.h"
#import "RJJBookViewController.h"
#import "RJJDotViewController.h"
#import "RJJMemberViewController.h"
#import "RJJLoginViewController.h"

@interface AppDelegate ()
@property (nonatomic, assign) BOOL isLogin;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    RJJTabBarVc *tabBarVC = [[RJJTabBarVc alloc] init];
    RJJLoginViewController *vc = [[RJJLoginViewController alloc] init];
    UINavigationController *RJJVC = [[UINavigationController alloc] initWithRootViewController:vc];
    RJJFriendViewController *friendVc = [[RJJFriendViewController alloc] init];
    RJJNavigationVv *followVC = [[RJJNavigationVv alloc] initWithRootViewController:friendVc];
    RJJBookViewController *bookVc = [[RJJBookViewController alloc] init];
    RJJBookNavigaionVc *bookVC = [[RJJBookNavigaionVc alloc] initWithRootViewController:bookVc];
    RJJDotViewController *dotVc = [[RJJDotViewController alloc] init];
    RJJDotNavigationVc *dotVC = [[RJJDotNavigationVc alloc] initWithRootViewController:dotVc];
    RJJMemberViewController *memberVc = [[RJJMemberViewController alloc] init];
    RJJMemberNavVC *memberVC = [[RJJMemberNavVC alloc] initWithRootViewController:memberVc];
    tabBarVC.viewControllers = @[followVC,bookVC,dotVC,memberVC];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userName = [defaults objectForKey:@"userName"];
    NSString *passWord = [defaults objectForKey:@"userId"];
    if (userName == nil && passWord == nil) {
        window.rootViewController = RJJVC;
        
    }else{
    window.rootViewController = tabBarVC;
    }
    [window makeKeyAndVisible];
    self.window = window;

    
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
