//
//  MainTabBarController.m
//  YZNavTabBar
//
//  Created by Apple on 2017/10/20.
//  Copyright © 2017年 yan. All rights reserved.
//

#import "MainTabBarController.h"
#import "MainNavigationController.h"

#define CLASS_NAME      @"className"
#define TITLE           @"title"
#define IMAGE           @"image"
#define SELECTED_IMAGE  @"selectedImage"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tabBar.barTintColor = [UIColor blackColor];// 设置tabBar背景颜色
    self.tabBar.translucent= NO;// 设置tabBar不透明
    
    NSArray *items = @[
                       @{
                           CLASS_NAME       :   @"FirstViewController",
                           TITLE            :   @"第一个",
                           IMAGE            :   @"",
                           SELECTED_IMAGE   :   @""
                           },
                       @{
                           CLASS_NAME       :   @"SecondViewController",
                           TITLE            :   @"第二个",
                           IMAGE            :   @"",
                           SELECTED_IMAGE   :   @""
                           },
                       @{
                           CLASS_NAME       :   @"ThirdViewController",
                           TITLE            :   @"第三个",
                           IMAGE            :   @"",
                           SELECTED_IMAGE   :   @""
                           },
                       @{
                           CLASS_NAME       :   @"FourthViewController",
                           TITLE            :   @"第四个",
                           IMAGE            :   @"",
                           SELECTED_IMAGE   :   @""
                           }
                       ];
    
    NSMutableArray  *viewControllers = [[NSMutableArray alloc] init];
    // 使用block方法遍历集合
    [items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIViewController *viewController = [[NSClassFromString(obj[CLASS_NAME]) alloc] init];// 根据类名称动态创建类
        viewController.title = obj[TITLE];
        viewController.tabBarItem.image = [UIImage imageNamed:obj[IMAGE]];
        viewController.tabBarItem.selectedImage = [UIImage imageNamed:obj[SELECTED_IMAGE]];
        
        MainNavigationController *mainNav = [[MainNavigationController alloc] initWithRootViewController:viewController];
        [viewControllers addObject:mainNav];
        
    }];
    
    self.viewControllers = viewControllers;// 设置tabBar视图集合
    UITabBarItem *item = [UITabBarItem appearance];// 获取tabBarItem的外观
    [item setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor brownColor]} forState:UIControlStateSelected];// 设置tabBar选中颜色
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
