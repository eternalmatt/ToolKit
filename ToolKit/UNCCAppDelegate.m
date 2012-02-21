//
//  UNCCAppDelegate.m
//  ToolKit
//
//  Created by Matt Senn on 2/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "UNCCAppDelegate.h"
#import "GPSViewController.h"
#import "AccelerationViewController.h"

@implementation UNCCAppDelegate
@synthesize window = _window;
@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.viewController = [[UIViewController alloc] initWithNibName:nil bundle:nil];
    /*
    AccelerationViewController *accelerometer = [[AccelerationViewController alloc] initWithNibName:nil bundle:nil];
    GPSViewController *location = [[GPSViewController alloc] initWithNibName:nil bundle:nil];
    
    UIView *view = self.viewController.view;
    accelerometer.view.frame = CGRectMake(0,0,320,100);
    location.view.frame = CGRectMake(0,100,320,300);
    [view addSubview:accelerometer.view];
    [view addSubview:location.view];
    */
    
    UINavigationController *navcon = [[UINavigationController alloc] initWithRootViewController:self.viewController];
    self.window.rootViewController = navcon;
    

    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
