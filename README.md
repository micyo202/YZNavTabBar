# UINavigationController与UITabBarController整合Demo（纯代码模式）

## 效果预览GIF
<img src="https://github.com/micyo202/YZNavTabBar/raw/master/20171020102449.gif" alt="效果预览" title="效果预览">

## 介绍
**UINavigationController**：同级页面之间的跳转，界面典型的特点就是页面上部有一UINavigationBar导航条，导航条可以设置标题、左上角的按钮（一般用于返回），右上角的按钮，也可以自定义这些元素。<br>
**UITabBarController**：父子页面之间的嵌套关系，界面典型的特点是耍耍下部有一UITabBar选项组，通过点击Tab，可切换上面的视图的变换。<br>
UIViewController、UINavigationController、UITabBarController三者的整合使用，可以开发出大部分的App应用页面框架。

## 思路
我们需要把 Navigation View 加到 Tab Bar View 的内容上去，Tab Bar View再加到 Window 上去。<br>
就是 Window 套 UITabBarController，UITabBarController 套 UINavigationController, UINavigationController 套 UIViewController。<br>
但当页面使用 UITabBarController + UINavigationController 的时候，当跳转到详情页面的时候，如果 UITabBar 仍然存在的话就会造成逻辑混乱，用户体验也会下降，因此我们就有一个在详情页将 UITabBar 隐藏的需求，接下来就来介绍这个框架完美的搭建方式

## 步骤
### 1.打开Xcode创建一个 Single View App 工程，由于我们这里使用纯代码模式，固工程创建好后删除项目中生成的 ViewController.h、ViewController.m、Main.storyboard 这三个文件，并在 info.plist 文件中，将 Main storyboard file base name 对应的值 Main 删掉。

### 2.创建继承 UINavigationController 的类 MainNavigationController，在其对应的.m文件中

重写 pushViewController 方法，为了控制导航栏 push 页面隐藏底部 tabBar
```C
#pragma mark - 重写pushViewController:方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if(self.viewControllers.count > 0){
        [viewController setHidesBottomBarWhenPushed:YES];// 隐藏底部tabBar
    }
    [super pushViewController:viewController animated:animated];
}
```

### 3.创建继承 UITabBarController 的类 MainTabBarController，在其对应的.m文件中

在 viewDidLoad 方法中代码如下：
```C
NSArray *items = @[
                   @{
                       CLASS_NAME       :   @"FirstViewController",
                       TITLE            :   @"第一个",
                       IMAGE            :   @"tabbar_news",
                       SELECTED_IMAGE   :   @"tabbar_newsHL"
                       },
                   @{
                       CLASS_NAME       :   @"SecondViewController",
                       TITLE            :   @"第二个",
                       IMAGE            :   @"tabbar_app",
                       SELECTED_IMAGE   :   @"tabbar_appHL"
                       },
                   @{
                       CLASS_NAME       :   @"ThirdViewController",
                       TITLE            :   @"第三个",
                       IMAGE            :   @"tabbar_msg",
                       SELECTED_IMAGE   :   @"tabbar_msgHL"
                       },
                   @{
                       CLASS_NAME       :   @"FourthViewController",
                       TITLE            :   @"第四个",
                       IMAGE            :   @"tabbar_mine",
                       SELECTED_IMAGE   :   @"tabbar_mineHL"
                       }
                   ];

NSMutableArray  *viewControllers = [[NSMutableArray alloc] init];
// 使用block方法遍历集合
[items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

    UIViewController *viewController = [[NSClassFromString(obj[CLASS_NAME]) alloc] init];// 根据类名称动态创建类
    viewController.title = obj[TITLE];
    viewController.tabBarItem.image = [UIImage imageNamed:obj[IMAGE]];
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:obj[SELECTED_IMAGE]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    MainNavigationController *mainNav = [[MainNavigationController alloc] initWithRootViewController:viewController];
    [viewControllers addObject:mainNav];

}];

self.viewControllers = viewControllers;// 设置tabBar视图集合
```

### 4.创建显示的子视图：FirstViewContoller、SecondViewController、ThirdViewController、FourthViewController

### 5.在 AppDelegate.m 文件中的 didFinishLaunchingWithOptions 方法中添加如下代码：
```C
// 隐藏顶部状态栏设为NO
[UIApplication sharedApplication].statusBarHidden = NO;
// 设置顶部状态栏字体为白色
[UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;

// 设置主window视图
_window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
_window.backgroundColor = [UIColor clearColor];

_mainTabBarController = [[MainTabBarController alloc] init];
//_mainTabBarController.view.userInteractionEnabled = NO;// 欢迎动画加载期间不允许永不与视图交互，加载完毕后设置为YES即可

// 设置root视图控制器
_window.rootViewController = _mainTabBarController;
[_window makeKeyAndVisible];
```
好了到这里最基本的整合过程就完成了，可下载本demo进行查看详细代码及运行效果，希望本文章对你有帮助！
