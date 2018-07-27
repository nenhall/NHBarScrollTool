# 导航栏、工具栏一键跟随tableview的滚动来控制显示和隐藏

## 使用方法：

简书：[tableView上下滑动，隐藏导航栏、工具栏](https://www.jianshu.com/p/e91908e913af)

把相关类拖入工程(如下图)：
![](https://github.com/neghao/NHBarScrollTool/blob/master/filepath.png)

你也可以使用cocoapod管理：
`pod "NHBarScrollTool"`


1. 添加NHBarScrollTool的代理对象，是个数组，可以添加多个对象，被添加进去的对象都可以接收到scrollView的代理方法:
  
   `barScrollTool.delegateTargets = @[ self ];`

2. 把tableView的代理设置为：
  
   `self.tableView.delegate = self.barScrollTool;`

3. 设置barScrollToolr的代理：
   
   `_barScrollTool.delegateTargets = ...`

![scroll.gif](http://upload-images.jianshu.io/upload_images/2443108-52e124944599ee1d.gif?imageMogr2/auto-orient/strip)

```
@interface UIViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NHBarScrollTool *barScrollTool;
@end

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
}

- (void)setupTableView {
    self.tableView.dataSource = self;
    self.tableView.delegate = self.barScrollTool;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    //如果是使用autolayout、mansory布局，需要在`viewDidLayoutSubviews`函数中调用此更新约束
    [self.barScrollTool updateConstraints];
}

- (NHBarScrollTool *)barScrollTool {
    if (!_barScrollTool) {
        UINavigationBar *navB = self.navigationController.navigationBar;
        UITabBar *tabB = self.tabBarController.tabBar;
        _barScrollTool = [NHBarScrollTool barToolWithController:self
                                                     scrollView:_tableView
                                                  navigationBar:navB
                                                         tabBar:tabB];
        _barScrollTool.delegateTargets = @[ self ];
        //中间按钮凸出部份的高度(如果有)
        _barScrollTool.tabBarBulgeOffset = 20;
    }
    return _barScrollTool;
}



```


比较忙，没写太细节，关键代码里面有注释，欢迎使用。


