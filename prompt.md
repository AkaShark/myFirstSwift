##总结提示 :
### 关于隐藏tabbar的三种方法：
1.直接隐藏 

```

// 显示tabBar
self.tabBarController.tabBar.hidden = NO;
// 隐藏tabBar
self.tabBarController.tabBar.hidden = YES;

```
2.push的时候设置隐藏常用的尤其是在Nav和tab结合使用的时候

```

// 在push跳转时隐藏tabBar
UIViewController *vc2 = [UIViewController new];
vc2.hidesBottomBarWhenPushed = YES;
[vc1 pushViewController:vc2 animated:YES];

```

3.没有用过但是感觉很不错的方法

原理：UITabBarController的subview 共有两个，一个叫 UITabBar，就是底下的那个 Bar；另一个叫UITranstionview，就是 Bar 上面的视图。这两个 view 下面还有其他的subview，这就不用去管它了。把UITabBar的 y 向下移49个单位，把UITranstionview 的 hight 加长 49 个单位。

```

- (void)hidesTabBar:(BOOL)hidden{
     
     [UIView beginAnimations:nil context:NULL];
     [UIView setAnimationDuration:0];
     
     for (UIView *view in self.tabBarController.view.subviews) {
         if ([view isKindOfClass:[UITabBar class]]) {
             if (hidden) {
                 [view setFrame:CGRectMake(view.frame.origin.x, [UIScreen mainScreen].bounds.size.height, view.frame.size.width , view.frame.size.height)];
                
             }else{
                 [view setFrame:CGRectMake(view.frame.origin.x, [UIScreen mainScreen].bounds.size.height - 49, view.frame.size.width, view.frame.size.height)];
                 
             }
         }else{
             if([view isKindOfClass:NSClassFromString(@"UITransitionView")]){
                 if (hidden) {
                     [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, [UIScreen mainScreen].bounds.size.height)];
                     
                 }else{
                     [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, [UIScreen mainScreen].bounds.size.height - 49 )];
                    
                 }
             }
         }
     }
     [UIView commitAnimations];
     
 }
 
 
 -(void)makeTabBarHidden:(BOOL)hide { // Custom code to hide TabBar
    if ( [self.tabBarController.view.subviews count] < 2 )
    {
        return;
    }
    UIView *contentView; if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
    {
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    } else {
            contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    }
    if (hide) {
        contentView.frame = self.tabBarController.view.bounds;
    } else {
            contentView.frame = CGRectMake(self.tabBarController.view.bounds.origin.x, self.tabBarController.view.bounds.origin.y,
                                           self.tabBarController.view.bounds.size.width, self.tabBarController.view.bounds.size.height -
                                           self.tabBarController.tabBar.frame.size.height);
    }
    self.tabBarController.tabBar.hidden = hide;
}


```
### 关于swift的协议问题
1.声明除了语法与oc几乎一样 而且更加简单
2.在声明上的区别

```
//特殊的声明方式
@objc protocol FirstViewControllerDelegate: NSObjectProtocol{

optional func firstDelegate(returnString:String)

}

在这个代理的声明中，可以明显看出，增加了一些额外的修饰符

1》引入@objc是为了引入 optional，用 optional 修饰代理方法，那么这个方法就变成可选方法，无论在代理对象中是否实现，都不受影响。
2》引入 NSObjectProtocol 是因为我们如果想用 weak 修饰代理属性，需要继承自这个类，这里有一篇关于 weak 修饰 Delegate，防止循环引用的文章，不明白的可以看看

```

### 关于切换根视图
1.在appdelegate中
```
self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];  
   A *vc = [[A alloc] init]; // init会执行viewDidLoad viewWillAppear   
   vc.view.backgroundColor  = [UIColor redColor];  
   self.window.rootViewController = vc;  
   [self.window makeKeyAndVisible];  
```
2.在a中 b设置为根视图
>注意点出来了，如果使用的是presentViewController则在设置B为根控制器的方法就必须在viewDidLoad与viewWillAppear之后进行设置。不然如下

3.在b中设置b为根视图
（建议在控制器已经完全在window上展示再切换window的根控制器）

```
- (void)viewDidAppear:(BOOL)animated {  
    [super viewDidAppear:animated];  
      
          
    AppDelegate *app = [UIApplication sharedApplication].delegate; // 获取当前app单例  
  
    NSLog(@"appdelegate is %@",app);  
      
    UIViewController *vc = app.window.rootViewController;  
      
    app.window.rootViewController = self;  
      
    [vc removeFromParentViewController];  
    NSLog(@"当前的根控制器为：%@",self.view.window.rootViewController);  
}  


A.view = nil
```
对应上面的方法需要将A销毁减小内存的消耗

还有一种方法

方法二：（提供个基本思路，实际情况大家研究下了）

可以创建多个window，在执行完成后可以设置其window为self.window，并让其成为key window，然后只要想使用的话就只可以将self.window赋值想要展示的window可此时销毁刚才的window，然后再将[self.window makeKeyandVisible];





