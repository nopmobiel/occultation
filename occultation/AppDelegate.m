//
//  AppDelegate.m
//  occultation
//
//  Created by Norbert Schmidt on 12-09-13.
//  Copyright (c) 2013 Norbert Schmidt. All rights reserved.
//

#import "AppDelegate.h"
#import <Parse/Parse.h> 
#import "MapViewController.h"
#import "MyDataViewController.h"
#import "FirstViewController.h"

#import "SecondViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // start of your application:didFinishLaunchingWithOptions
    
    
    // The rest of your application:didFinishLaunchingWithOptions method
    // ...
    
    [Parse setApplicationId:@"0cnw89JsPaLAYpv8eiBPVwL100QdIKEcFK6tkCSF"
                  clientKey:@"AZGgWC4LfjdZhtFjHCYtCULah9klz2eXg8w7F0XW"];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];


    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    UIViewController *viewController1, *viewController2, *viewController3, *viewController4;

        viewController1 = [[FirstViewController alloc] initWithNibName:@"FirstViewController_iPhone" bundle:nil];
        viewController2 = [[SecondViewController alloc] initWithNibName:@"SecondViewController_iPhone" bundle:nil];
    viewController3 = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
    viewController4 = [[MyDataViewController alloc] initWithNibName:@"MyDataViewController" bundle:nil];




    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[viewController1, viewController2, viewController3,viewController4];
    self.tabBarController.tabBar.tintColor=[UIColor blackColor];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f) {
         [[UITabBar appearance] setBarTintColor:[UIColor blackColor]];
        [[UITabBar appearance] setTintColor:[UIColor redColor]];
    }
    
    [[UIApplication sharedApplication]
setStatusBarStyle:UIStatusBarStyleBlackOpaque animated:NO];


    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    sleep(3);
    
    
    
    
    
    
    
    
    
    NSString *strFirst     = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_name"];
    NSString *strSur     = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_surname"];
    NSString *strEmail     = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_email"];
    
    if ( ([strFirst length] == 0 ) || ([strSur length]==0) || ([strEmail length]==0) ) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Contact details"
                                                        message:@"Please enter your contact details"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        [self.tabBarController setSelectedIndex:1];
        
        
    }
    
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
    
    // Check if username not is null, if yes
    

    
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
