//
//  AppDelegate.m
//  LyricPictureDemo
//
//  Created by silicon on 17/1/3.
//  Copyright © 2017年 com.snailgames. All rights reserved.
//

#import "AppDelegate.h"
@interface YYExampleNavBar : UINavigationBar

@end

@implementation YYExampleNavBar {
    CGSize _previousSize;
}

- (CGSize)sizeThatFits:(CGSize)size{
    size = [super sizeThatFits:size];
    if([UIApplication sharedApplication].statusBarHidden){
        size.height = 64;
    }
    
    return size;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if(CGSizeEqualToSize(self.bounds.size, _previousSize)){
        _previousSize = self.bounds.size;
        [self.layer removeAllAnimations];
        [self.layer.sublayers makeObjectsPerformSelector:@selector(removeAllAnimations)];
    }
    
}

@end

@interface YYExampleNavController : UINavigationController

@end

@implementation YYExampleNavController

- (BOOL)shouldAutorotate{
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation{
    return UIInterfaceOrientationPortrait;
}

@end

@interface AppDelegate ()

@end


@implementation AppDelegate
@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.viewController = [ViewController new];
    YYExampleNavController *nav = [[YYExampleNavController new] initWithNavigationBarClass:[YYExampleNavBar class] toolbarClass:[UIToolbar class]];
    
    if([nav respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]){
        nav.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [nav pushViewController:self.viewController animated:NO];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    return YES;
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
