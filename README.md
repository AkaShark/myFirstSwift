# 第一个swift项目
最近参加比赛昨天刚刚结束休息一天泡宿舍写下总结。来总结下我的第一个swift项目，由于之前写项目都是用的oc，这是第一次写项目很多swift项目的特性都没用上（主要就会一点简单的语法） 这次项目总的来说还是很完美的毕竟是第一次用swift些项目，但是也有些许的不足比如说在做一个界面的时候想用到iOS9推出的堆栈视图但是由于时间的原因没有用上用了自己计算的布局勉强应付上了但是效果很是不好啊，还有就是之前说的swift的特性，链式 面向协议都是知道的少之又少。接下来的时间打算好好总结下项目，继续学习知识。

# 在做项目的过程中随手记录的（有些是oc的但是swift差不多）：

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

1》引入@objc是为了引入 optional(可选)，用 optional 修饰代理方法，那么这个方法就变成可选方法，无论在代理对象中是否实现，都不受影响。
2》引入 NSObjectProtocol 是因为我们如果想用 weak 修饰代理属性，需要继承自这个类。
```

### 关于切换根视图（登陆后切换根视图）
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

### 关于tableView 的cell被遮挡的问题
1.没有正确设置tableVIew的高度，高度过高

```
tableview的高度设置有错误,应该为self.view.frame.size.hight - self.tabbarController.tabbar.frame.size.height - 64,就可以避免遮挡 
```
或者

```
self.automaticallyAdjustsScrollViewInsets = NO 设置后默认tableview 的contentInset = UIEdgeInsetsZero; 否则就是会减去 导航栏 + 底部tababr 高度，如果要从头开始布局 ，可以使用self.edgesForExtendedLayout = UIRectEdgeTop; 让tableview 顶部从 0 。0 开始布局，底部自动减去 64 
```

### 关于导航栏的问题
1.  self.navigationController?.setNavigationBarHidden(false, animated: true)
2. 设置viewController的title和设置UItabbarItem的标题

```
 在写代码的时候设计的基类修改标题栏的方法采用的是self.title = navString 但是在实际的使用的中发现，我调用这个方法的时候出现了在我底部的TABbar产生了一个新的item，当时以为我自定义的tabbar出现了问题但是找了一圈没找到。。。。然后百度下找到了我想要的一切
```

>self.navigationItem.title
 = @"my title"; sets navigation bar title.

>self.tabBarItem.title
 = @"my title"; sets tab bar title.

>self.title
 = @"my title"; sets both of these.

### 关于写界面的一点提醒
1. 当写界面的的时候出现了不符合自己的意图的样子，可以进行查看分层和设置背景颜色的方法来进行调试或者可以frameDebuging（真机）


### 关于调用父类方法（调用自定义tabbar方法）

```
 let tab = self.navigationController?.tabBarController as! AnimationTabBarController
//        获取父类的方法
//        print(self.navigationController?.tabBarController?.superclass ?? AnyClass.self)
//        调用父类的方法
        tab.setSelectIndex(from: 0, to: 2)
```


### 关于hidden隐藏时的动画

```
let animation = CATransition()
animation.type = kCATransitionFade
animation.duration = 0.4
view.layer.add(animation, forKey: nil)
view.isHidden = false
```

### 关于swift数组切片
1.[原网址](https://www.crifan.com/swift_get_part_of_origin_uicolor_array_as_new_array/)
尝试了好几种办法但是最终都没有解决，与这个博客遇到的问题差不多，我遇到的问题是将数组分成几个分别出作为数据源（因为我写的蹩脚的接口弄的不会分开）
最终的实现办法
>memberIdStrListToProcess = Array(groupMemberIdStrList[0…9])
要加一个array然后再接片操作跟Python有些不同。(前面加了Array强转)

### 关于数组 
1.今天在创建数组然后从网络获取数据并添加到数组的时候出现了问题。。。
我是这样写的
>var recordData = Array<Array<Any>>()
犯了一个明显的错误。。。没有进行初始化这是单单的进行了声明。。因为swift的语法搞得我有点忘记初始化了。。总结下
>数据数组 记得创建是要进行初始化(创建类型要： 声明但是没有初始化，= （ ）这样是进行初始化并声明 ！) 括号的问题

### swift调用oc的block

1.swift调用oc的block，遇到这个问题我有点头大啊。。。oc的block还没学多好呢。。swift更是差劲现在可以好了直接开始混编了，说正题，解决方法[swift调用ocBlock](https://www.jianshu.com/p/1279224d4820)  总结如下

```
// oc的block
返回值(^名称)(类型 传值)
// swift里调用
名称 = {(传值!!(没有类型))->(返回值) in 
 
}
```

2.还有一点之前看的swift调用不了oc的可选协议。好像有办法但是时间紧迫先放过了。（）


### oc设置导航栏文字富文本显示
```
设置富文本将以字典的样子去设置
[self.navigationController.navigationBar setTitleTextAttributes:

@{NSFontAttributeName:[UIFont systemFontOfSize:19],

NSForegroundColorAttributeName:[UIColor redColor]}];
```

### 将图片转成base64字符串
```
let image = UIImage(name:"照片")
//将图片转成data
let imageData = UIImagePNGRepresentation(image!)
//将data转成base64的字符串
let imageBase64String = imageData?.base64EncodeString()
//可以使用base64的字符串类型上传到服务器了
//还要将base64进行urlencode的话
let imageString = imageBase64String.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
```
### bas64字符串转成图片
```
//将base64的图片字符串转成Data
let imageData2 = Data(base64Encoded: imageBase64String!)

//将data转成照片
let image2 =UIImage(data:imageData2!)
//将data转成uiimage 
let photo = UIImage(data:image2)

```
### ios11 保存图片闪退
[原文](http://www.0daybug.com/2017/10/09/iOS-NSPhotoLibraryAddUsageDescription/)
ios10和ios11 的这个方面的权限有些不同查看博客即可

### 设置状态栏设置 
首先放出几个网上写的不错的博客吧[ios 状态栏statusBar的背景颜色](https://www.jianshu.com/p/5c09c2700038)

```
//设置状态栏颜色
- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
  
    [self setStatusBarBackgroundColor:[UIColor redColor]];
    self.view.backgroundColor = [UIColor yellowColor];
}
```
[swift实现的](http://www.swift.gg/2017/05/18/change-color-status-bar-tutorial/)
还有好多但是不服我的情况我就直接删除了。。。说下我的情况吧 我的程序运行在ios11 上是完全ok的 但是运行在ios9上状态栏莫名的就是黑色的。。。后来发现是我自定义的导航栏的位置出现了问题 少算了20.。汗颜啊。~

### ios 截屏保存相册（swift）版 
[文章写的很好也有很多的地方可以学习](https://www.jianshu.com/p/f80e2b57f304)
### tableView显示滑动条
  self.lazyTableView.showsHorizontalScrollIndicator为显示横向的滑动条(Heng)
self.lazyTableView.showsVerticalScrollIndicator 
为显示纵向的滑动条 其实没必要去记录的自己试下就可以啦

### ios设置返回按钮的样子自定义（oc版）
[ios修改返回按钮的几种方式](https://www.jianshu.com/p/0103cd689cfa)尝试了下最后一种方式最好用了，之前的方法都是更改了图片但是标题没有发生改变，采用第三种方法
```
//创建一个UIButton
UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
//设置UIButton的图像
[backButton setImage:[UIImage imageNamed:@"left_select_img.png"] forState:UIControlStateNormal];
//给UIButton绑定一个方法，在这个方法中进行popViewControllerAnimated
[backButton addTarget:self action:@selector(backItemClick) forControlEvents:UIControlEventTouchUpInside];
//然后通过系统给的自定义BarButtonItem的方法创建BarButtonItem
UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
//覆盖返回按键
self.navigationItem.leftBarButtonItem = backItem;
```

### 等间距布局(堆栈视图)
[masonry等间距布局](https://www.jianshu.com/p/2c7a5ba73fc2)


### PHP的数组
1.首先是数组支持的类型，PHP的数组有两种类型，第一种只保存值的索引数组，另一种是保存名值对（name/key）关联数组（类似其他语言的字典）

### Linux导入数据库

之前有用过但是又忘记了。。在此记录下吧首先导出所需要的数据库，我用的是Navicat直接右键导出就OK了，然后是在服务器上导入，服务器为centos导入方法有两种。第一种方法：
>选择数据库 
mysql>use abc;
设置数据库编码 
mysql>set names utf8;
导入数据（注意sql文件的路径） 
mysql>source /home/abc/abc.sql;
第二种方法（常用方法）
>

>方法二（常用）：        
        格式：mysql -u用户名 -p密码 数据库名 < 数据库名.sql 
        举例：mysql -uabc_f -p abc < abc.sql

顺便记录下导出的方法：

```
一、导出数据和表结构：

格式： mysqldump -u用户名 -p密码 数据库名 > 数据库名.sql 
举例： /usr/local/mysql/bin/ mysqldump -uroot -p abc > abc.sql 
敲回车后会提示输入密码

二、只导出表结构

格式：mysqldump -u用户名 -p密码 -d 数据库名 > 数据库名.sql 
举例：/usr/local/mysql/bin/ mysqldump -uroot -p -d abc > abc.sql 
注：/usr/local/mysql/bin/ —> mysql的data目录
```



### 遇到的重大问题
1.自定义tabbar总是出问题 最终是修改一个属性解决的
2.方法前面加objc 
3.持续更新 继续干找问题记录下来 学习 研究 抽时间

### 总结
1.第一次用些swift些项目，第一次用PHP做了些简单的app的接口~总的来说还是很开心的

### 后记
<!--1.最近要学的ios知识包括：kvo属性监听，通知的写法，block的用法，了解runtime swift闭包知识
2.今天用了一下简单的swift版的wkwebView感觉有很多需要学习的地方啊
3.（最近忙完学习下通知事件的分发机制还有这个wkwebView有很多的知识点） addObserver方法
3.学习使用工具steach（钻石）
4.学习下ios的icon的2x3x什么的有些不了解 做项目的时候40 * 40的图片放的是 8 * 80的图片 感觉就是2x的原因 这个问题问问修昊! 修昊知道1
5.学习rxswift
6.研究下添加家属这个模块的代理没走的原因 代码就不删除了
7.swift 闭包的使用-->



1.iOS oc方面：kvo属性监听，通知的写法，block的用法，了解runtime，wkwebView有很多的知识点
  iOS swift方面： swift闭包知识，wkwebView有很多的知识点，事件的分发机制，通知，学习rxswift swift 闭包的使用
2.学习工具： sketch还有和他配好写动画的叫。。。
3.学习控件堆栈视图:UIStackView [UIStackView](https://www.jianshu.com/p/2c7a5ba73fc2)    Intrinsic Content Size
4.学习了解本地数据库 realm charts（画图）点的拟合
5.后续将这些东西的学习笔记和demon上传 


#总结下 
上面的都是在所项目的时候记录的一些东西，接下来的一个月里面有几件事情要去忙首先是参加cccc然后是小程序再有就是将这个项目继续完成升级，然后学习上面提到的东西。陆续我要记录下我学习的这些知识。 好了就这样了，最后分享下项目吧 GitHub项目地址（）





