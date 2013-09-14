//
//  AppDelegate.m
//  MOPCON
//
//  Created by Evan Wu on 13/7/16.
//  Copyright (c) 2013年 MOPCON. All rights reserved.
//

#import "AppDelegate.h"
#import "SessionViewController.h"
#import "NewsViewController.h"
#import "MapViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  // Override point for customization after application launch.
  UIViewController  *viewController1;
  UIViewController  *viewController2;
  UIViewController  *viewController3;

  if ([[UIScreen mainScreen] bounds].size.height == 568) {
    viewController1 = [[SessionViewController alloc] initWithNibName:@"SessionViewController568" bundle:nil];
    viewController2 = [[NewsViewController alloc] initWithNibName:@"NewsViewController568" bundle:nil];
    viewController3 = [[MapViewController alloc] initWithNibName:@"MapViewController568" bundle:nil];
  } else {
    viewController1 = [[SessionViewController alloc] initWithNibName:@"SessionViewController" bundle:nil];
    viewController2 = [[NewsViewController alloc] initWithNibName:@"NewsViewController" bundle:nil];
    viewController3 = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
  }

  UINavigationController *sessionNavi = [[UINavigationController alloc] initWithRootViewController:viewController1];
  UINavigationController *newsNavi = [[UINavigationController alloc] initWithRootViewController:viewController2];
  
  self.tabBarController = [[UITabBarController alloc] init];
  self.tabBarController.viewControllers = @[sessionNavi, viewController2, viewController3];
  self.window.rootViewController = self.tabBarController;
  [self.tabBarController.tabBar setTintColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0]];
  [self.window makeKeyAndVisible];

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

/*
 *   // Optional UITabBarControllerDelegate method.
 *   - (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
 *   {
 *   }
 */

/*
 *   // Optional UITabBarControllerDelegate method.
 *   - (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
 *   {
 *   }
 */

@end
