//
//  AppDelegate.m
//  SlideTabBar
//
//  Created by Mr.LuDashi on 15/6/25.
//  Copyright (c) 2015年 李泽鲁. All rights reserved.
//

#import "AppDelegate.h"
#import "PushWebViewController.h"

@interface AppDelegate ()<UIAlertViewDelegate>

@property (nonatomic, strong) NSDictionary *userInfo;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
     application.applicationIconBadgeNumber = 1;
    
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    if (version >= 8.0) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    } else {
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
        [application registerForRemoteNotifications];
    }
    
    return YES;
}


//获取DeviceToken成功
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    
    
    NSLog(@"DeviceToken: {%@}",deviceToken);
    //这里进行的操作，是将Device Token发送到服务端
    
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:nil message:[NSString stringWithFormat:@"DeviceToken:%@",deviceToken] delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}

//注册消息推送失败
- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"Register Remote Notifications error:{%@}",error);
    //    NSLog(@"Register Remote Notifications error:{%@}",error.localizedDescription);
}

//处理收到的消息推送
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSLog(@"Receive remote notification : %@",userInfo);
    self.userInfo = userInfo;
    
    
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"通知" message:@"通知" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"查看", nil];
    [alter show];
    
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        //跳转到WebView
        UINavigationController *webViewControllerNav = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"PushWebViewControllerNav"];
        
        PushWebViewController *webViewController = webViewControllerNav.viewControllers[0];
        webViewController.url = _userInfo[@"aps"][@"alert"];
        
        [self.window.rootViewController presentViewController:webViewControllerNav animated:YES completion:^{
            
        }];
    }
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
