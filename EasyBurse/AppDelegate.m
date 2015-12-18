//
//  AppDelegate.m
//  EasyBurse
//
//  Created by 魏凡缤 on 15/12/2.
//  Copyright © 2015年 com.blueboyhi. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "MV_PageViewController.h"
#import "EBViewController.h"
#import "EBTags.h"
#import "SQLBaseManager.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "YLCheckToUnlockViewController.h"
#import "UMessage.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"

#define UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define _IPHONE80_ 80000

@interface AppDelegate ()
@property (nonatomic, retain) NSDictionary *userInfo;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstStart"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstStart"];
        // 创建数据
        [self initData];
    }
    
    
    MV_PageViewController *pageVC = [[MV_PageViewController alloc] init];
    pageVC.pageAnimatable = YES;
    pageVC.postNotification = YES;
    pageVC.bounces = YES;
    //pageVC.menuHeight = 44;
    pageVC.menuViewStyle = WMMenuViewStyleLine;
    pageVC.menuBGColor = WhiteColor;
    pageVC.titleColorNormal = FONT_COLOR_33;
    pageVC.titleColorSelected = UIColorFromRGB(0xe4007f, 1.0f);
    pageVC.progressHeight = 3.f;
    pageVC.viewFrame = rect(0, NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT);
    pageVC.keys = @[@"stateType",@"stateType",@"stateType"];
    pageVC.titleColorSelected = GreenColor;
    pageVC.titleColorNormal = UIColorFromRGB(0x888888, 1.0f);
    pageVC.menuBGColor = UIColorFromRGB(0xf1f1f1, 1.0f);
//    pageVC.values = @[@(SelectedStateType_All),
//                      @(SelectedStateType_Progressing),
//                      @(SelectedStateType_Announced)
//                      ];

    
    
    
    EBViewController *nav = [[EBViewController alloc] initWithRootViewController:pageVC];
    
    [nav setNavigationBarHidden:YES];
    [nav.navigationBar setHidden:YES];
    if (IOS_7_OR_LATER) {
        nav.interactivePopGestureRecognizer.enabled = YES;
    }
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = nav;
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = YES;

    
    [UMSocialData setAppKey:@"5670c678e0f55a6e7d001119"];
    [UMSocialWechatHandler setWXAppId:@"wxb13bf0b5a606b4cf" appSecret:@"84bb768799b85c0be36df379507268d3" url:@"http://www.quanyu-tech.com/"];
    [UMSocialData openLog:YES];
    
    //set AppKey and AppSecret
    [UMessage startWithAppkey:@"5670c678e0f55a6e7d001119" launchOptions:launchOptions];
    

    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= _IPHONE80_
    if(UMSYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
    {
        //register remoteNotification types （iOS 8.0及其以上版本）
        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
        action1.identifier = @"action1_identifier";
        action1.title=@"Accept";
        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
        
        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
        action2.identifier = @"action2_identifier";
        action2.title=@"Reject";
        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        action2.destructive = YES;
        
        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
        categorys.identifier = @"category1";//这组动作的唯一标示
        [categorys setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
        
        UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert
                                                                                     categories:[NSSet setWithObject:categorys]];
        [UMessage registerRemoteNotificationAndUserNotificationSettings:userSettings];
        
    } else{
        //register remoteNotification types (iOS 8.0以下)
        [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
         |UIRemoteNotificationTypeSound
         |UIRemoteNotificationTypeAlert];
    }
#else
    
    //register remoteNotification types (iOS 8.0以下)
    [UMessage registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge
     |UIRemoteNotificationTypeSound
     |UIRemoteNotificationTypeAlert];
    
#endif
    //for log
    [UMessage setLogEnabled:YES];
    
    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *pushToken = [[[[deviceToken description]
                             
                             stringByReplacingOccurrencesOfString:@"<" withString:@""]
                            
                            stringByReplacingOccurrencesOfString:@">" withString:@""]
                           
                           stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSLog(@"Device Token=%@", pushToken);
    
    [UMessage registerDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    //关闭友盟自带的弹出框
    //  [UMessage setAutoAlert:NO];
    
    [UMessage didReceiveRemoteNotification:userInfo];
    
    self.userInfo = userInfo;
    //定制自定的的弹出框
    if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"标题"
                                                            message:@"Test On ApplicationStateActive"
                                                           delegate:self
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
        
        [alertView show];
        
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [UMessage sendClickReportForRemoteNotification:self.userInfo];
}

- (void)initData
{
    EBTags *tag1 = [EBTags new];
    tag1.tname = @"房产";
    tag1.ttype = @"1";
    tag1.timage = @"fangc";
    tag1.tnote = @"不吃饭也要攒钱买房子";
    
    
    EBTags *tag2 = [EBTags new];
    tag2.tname = @"工资";
    tag2.ttype = @"1";
    tag2.timage = @"gongz";
    tag2.tnote = @"把每一分钱都攒到兜里面";
    
    EBTags *tag3 = [EBTags new];
    tag3.tname = @"股票";
    tag3.ttype = @"1";
    tag3.timage = @"gup";
    tag3.tnote = @"上下五千点";
    
    EBTags *tag4 = [EBTags new];
    tag4.tname = @"基金";
    tag4.ttype = @"1";
    tag4.timage = @"jij";
    tag4.tnote = @"建设性投资";
    
    EBTags *tag5 = [EBTags new];
    tag5.tname = @"打牌";
    tag5.ttype = @"1";
    tag5.timage = @"dap";
    tag5.tnote = @"能赢就好。。。";
    
    EBTags *tag6 = [EBTags new];
    tag6.tname = @"其他";
    tag6.ttype = @"1";
    tag6.timage = @"qit";
    tag6.tnote = @"";
    
    EBTags *tag7 = [EBTags new];
    tag7.tname = @"餐饮";
    tag7.ttype = @"0";
    tag7.timage = @"cany";
    tag7.tnote = @"对自己好一点，但注意超重。。。";
    
    EBTags *tag8 = [EBTags new];
    tag8.tname = @"出行";
    tag8.ttype = @"0";
    tag8.timage = @"chux";
    tag8.tnote = @"说走就走的旅行";
    
    EBTags *tag9 = [EBTags new];
    tag9.tname = @"购物";
    tag9.ttype = @"0";
    tag9.timage = @"gouw";
    tag9.tnote = @"有钱天天双十一";
    
    EBTags *tag10 = [EBTags new];
    tag10.tname = @"烟酒";
    tag10.ttype = @"0";
    tag10.timage = @"yanj";
    tag10.tnote = @"都戒掉吧";
    
    EBTags *tag11 = [EBTags new];
    tag11.tname = @"娱乐";
    tag11.ttype = @"0";
    tag11.timage = @"yul";
    tag11.tnote = @"玩点刺激的";
    
    EBTags *tag12 = [EBTags new];
    tag12.tname = @"电影";
    tag12.ttype = @"0";
    tag12.timage = @"diany";
    tag12.tnote = @"多看点经典的";
    
    EBTags *tag13 = [EBTags new];
    tag13.tname = @"打牌";
    tag13.ttype = @"0";
    tag13.timage = @"maj";
    tag13.tnote = @"三缺一";
    
    EBTags *tag14 = [EBTags new];
    tag14.tname = @"药";
    tag14.ttype = @"0";
    tag14.timage = @"yao";
    tag14.tnote = @"到点该吃的东西";
    
    EBTags *tag15 = [EBTags new];
    tag15.tname = @"学习";
    tag15.ttype = @"0";
    tag15.timage = @"xuex";
    tag15.tnote = @"投资自己永远不亏";
    
    EBTags *tag16 = [EBTags new];
    tag16.tname = @"种地";
    tag16.ttype = @"0";
    tag16.timage = @"biyt";
    tag16.tnote = @"锄禾日当午";
    
    EBTags *tag17 = [EBTags new];
    tag17.tname = @"租买房";
    tag17.ttype = @"0";
    tag17.timage = @"zuf";
    tag17.tnote = @"默默为GDP贡献自己的汗水。。。";
    
    EBTags *tag18 = [EBTags new];
    tag18.tname = @"其他";
    tag18.ttype = @"0";
    tag18.timage = @"qit";
    tag18.tnote = @"";
    
    [SQLBaseManager insertTagModel:tag1];
    [SQLBaseManager insertTagModel:tag2];
    [SQLBaseManager insertTagModel:tag3];
    [SQLBaseManager insertTagModel:tag4];
    [SQLBaseManager insertTagModel:tag5];
    [SQLBaseManager insertTagModel:tag6];
    [SQLBaseManager insertTagModel:tag7];
    [SQLBaseManager insertTagModel:tag8];
    [SQLBaseManager insertTagModel:tag9];
    [SQLBaseManager insertTagModel:tag10];
    [SQLBaseManager insertTagModel:tag11];
    [SQLBaseManager insertTagModel:tag12];
    [SQLBaseManager insertTagModel:tag13];
    [SQLBaseManager insertTagModel:tag14];
    [SQLBaseManager insertTagModel:tag15];
    [SQLBaseManager insertTagModel:tag16];
    [SQLBaseManager insertTagModel:tag17];
    [SQLBaseManager insertTagModel:tag18];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [MV_Utils setHavePass:NO];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    if ([MV_Utils getPassWord] && ![MV_Utils isHavePass]) {
        YLCheckToUnlockViewController *controller = [YLCheckToUnlockViewController new];
        [self.window.rootViewController presentViewController:controller animated:YES completion:nil];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
