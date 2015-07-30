//
//  JRTVisibleViewController.m
//  
//
//  Created by Juan Garcia on 10/4/15.
//  Copyright (c) 2015 Jerti LLC. All rights reserved.
//

#import "JRTActualViewController.h"

@implementation JRTActualViewController

#pragma mark - helpers

+ (UIViewController *)topViewController:(UIViewController *)rootViewController
{
    if ([rootViewController isMemberOfClass:[UINavigationController class]] || [rootViewController isKindOfClass:[UINavigationController class]])
    {
        UINavigationController *navigationController = (UINavigationController *)rootViewController;
        UIViewController *visibleViewController = [navigationController visibleViewController];
        return [self topViewController:visibleViewController];
    }
    else if ([rootViewController isMemberOfClass:[UITabBarController class]] || [rootViewController isKindOfClass:[UITabBarController class]])
    {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        UIViewController *selectedViewController = [tabBarController selectedViewController];
        return [self topViewController:selectedViewController];
    }
    else if (rootViewController.presentedViewController)
    {
        return [self topViewController:rootViewController.presentedViewController];
    }
    else
    {
        return rootViewController;
    }
    
    
}

#pragma mark - public

+ (UIViewController *)actualViewController
{
    return [self topViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

+ (UIViewController *)rootViewController
{
    return [UIApplication sharedApplication].keyWindow.rootViewController;
}

@end
