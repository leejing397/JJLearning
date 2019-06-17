//
//  AppDelegate.m
//  GXAppearanceDemo
//
//  Created by Iris on 2019/6/17.
//  Copyright © 2019年 国信司南（北京）地理信息技术有限公司. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self set];
    return YES;
}

- (void)set {

    //导航条上标题的颜色
    NSDictionary *navbarTitleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
    [[UINavigationBar appearance] setTintColor:[UIColor redColor]];
    //TabBar选中图标的颜色,默认是蓝色
    [[UITabBar appearance] setTintColor:[UIColor greenColor]];
    //导航条的背景颜色
    [[UINavigationBar appearance] setBarTintColor:[UIColor yellowColor]];
    
    //TabBar的背景颜色
    [[UITabBar appearance] setBarTintColor:[UIColor brownColor]];
    
    [UISearchBar appearance].tintColor = [UIColor redColor];
    //当某个class被包含在另外一个class内时，才修改外观。
    [[UIButton appearanceWhenContainedInInstancesOfClasses:@[[UIView class]]] setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [[UITextView appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTextColor:[UIColor yellowColor]];
    
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor magentaColor];
    pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
    
    [[UITextField appearance] setTintColor:[UIColor purpleColor]];
    [[UITextView appearance]  setTintColor:[UIColor darkGrayColor]];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
