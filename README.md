# 导航栏、工具栏一键跟随tableview的滚动来控制显示和隐藏

## 使用方法：
把相关类拖入工程(如下图)：
![](https://github.com/neghao/NHBarScrollTool/blob/master/filepath.png)

你也可以使用cocoapod管理：
`pod "NHBarScrollTool"`


> 1，添加NHBarScrollTool的代理对象，是个数组，可以添加多个对象，被添加进去的对象都可以接收到scrollView的代理方法
>  barScrollTool.delegateTargets = @[ self ];
> 2，把tableView的代理设置为：NHBarScrollTool/Users/neghao/Library/Containers/com.tencent.qq/Data/Library/Application Support/QQ/Users/403700907/QQ/Temp.db/BEE309A4-32B0-49BD-B7F9-F7AB8D9EDEF9.png

>  self.tableView.delegate = self.barScrollTool;
> 3，一定要先设置`_barScrollTool.delegateTargets = ...`再设置self.tableView.delegate = barScrollTool



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

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self.barScrollTool;
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 0, 0);
}

- (NHBarScrollTool *)barScrollTool {
    if (!_barScrollTool) {
        _barScrollTool = [NHBarScrollTool BarScrollToolWithController:self
                                                           scrollView:_tableView
                                                        navigationBar:nil
                                                               tabBar:nil];
        _barScrollTool.delegateTargets = @[ self ];
    }
    return _barScrollTool;
}

```


比较忙，没写太细节，代码里面的注释也不是很全，欢迎使用吐槽。


