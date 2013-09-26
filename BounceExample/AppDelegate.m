//
//  AppDelegate.m
//  BounceExample
//
//  Created by Benjamin Vogelzang on 9/25/13.
//  Copyright (c) 2013 Ben Vogelzang. All rights reserved.
//

#import "AppDelegate.h"
#import "BounceMenuController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    BounceMenuController *bounceMenuController = [[BounceMenuController alloc] init];
    
    // load view controllers from a storyboard
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"StoryboardiPhone" bundle:nil];
//    UIViewController *vc1 = [sb instantiateViewControllerWithIdentifier:@"ViewController1"];
//    UIViewController *vc2 = [sb instantiateViewControllerWithIdentifier:@"ViewController2"];
//    UIViewController *vc3 = [sb instantiateViewControllerWithIdentifier:@"ViewController3"];
    
    

    // optionally create view controllers from code
    UIViewController* vc1 = [[UIViewController alloc] init];
    vc1.view.backgroundColor = [UIColor colorWithRed:0.21f green:0.33f blue:0.53f alpha:1.00f];
    vc1.tabBarItem.image = [UIImage imageNamed:@"location.png"];
    
    UIViewController* vc2 = [[UIViewController alloc] init];
    vc2.view.backgroundColor = [UIColor colorWithRed:0.29f green:0.22f blue:0.56f alpha:1.00f];
    vc2.tabBarItem.image = [UIImage imageNamed:@"rocket.png"];
    
    UIViewController* vc3 = [[UIViewController alloc] init];
    vc3.view.backgroundColor = [UIColor colorWithRed:0.14f green:0.50f blue:0.45f alpha:1.00f];
    vc3.tabBarItem.image = [UIImage imageNamed:@"bolt.png"];

    
    // set the view controllers for the bounc menu
    NSArray* controllers = [NSArray arrayWithObjects:vc1, vc2, vc3, nil];
    bounceMenuController.viewControllers = controllers;
    
    self.window.rootViewController = bounceMenuController;
    
    [self.window makeKeyAndVisible];
    
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

@end
