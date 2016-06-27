//
//  RJJFriendViewController.m
//  阅分享
//
//  Created by  任京记 on 16/6/14.
//  Copyright © 2016年  任京记. All rights reserved.
//

#import "RJJFriendViewController.h"
#import "RJJMemageViewController.h"
#import "RJJSouSuoViewController.h"
#import "RJJableViewController.h"
#import "RJJTableViewController.h"
#import "HHSegmentView.h"


#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height



@interface RJJFriendViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UISegmentedControl *segmentControl;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation RJJFriendViewController
-(NSArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSArray array];
    }
    return _dataArray;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.placeholder = @"请输入要搜索的数据";
    searchBar.delegate = self;
    searchBar.tintColor = [UIColor grayColor];
    
    self.navigationItem.titleView = searchBar;
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"信息"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(memageClick) forControlEvents:UIControlEventTouchDown];
    button.frame = CGRectMake(0, 0, 30, 20);
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = item;
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setImage:[UIImage imageNamed:@"购物车"] forState:UIControlStateNormal];
    button1.bounds = CGRectMake(0, 0, 30, 20);
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithCustomView:button1];
    self.navigationItem.rightBarButtonItem = item1;
    
    
//    NSArray *array = [[NSArray alloc] initWithObjects:@"动态",@"书友" ,nil];
//    UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:array];
//    segmentControl.tintColor = [UIColor grayColor];
//    segmentControl.selectedSegmentIndex = 0;
//    [segmentControl setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[UIColor blueColor]} forState:UIControlStateSelected];
//    [segmentControl setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18],NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
//    [self.view addSubview:segmentControl];
//    self.segmentControl = segmentControl;
//    [segmentControl addTarget:self action:@selector(switchView:) forControlEvents:UIControlEventValueChanged];
//    segmentControl.translatesAutoresizingMaskIntoConstraints = NO;
//    NSArray *segmentH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[segmentControl]-0-|" options:0 metrics:nil views:@{@"segmentControl":segmentControl}];
//    [self.view addConstraints:segmentH];
//    NSArray *segmentV = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-64-[segmentControl(40)]" options:0 metrics:nil views:@{@"segmentControl":segmentControl}];
//    [self.view addConstraints:segmentV];
//
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSArray *titles = @[@"动态",@"书友"];
    RJJableViewController *Vc = [[RJJableViewController alloc] init];
    RJJTableViewController *BBBV = [[RJJTableViewController alloc] init];

    for (int i=0; i<titles.count; i++) {
        switch (i) {
            case 0:
                [self addChildViewController:Vc];
                break;
            case 1:
                [self addChildViewController:BBBV];
                break;
                 }
    }
    
    HHSegmentView *segmentView = [HHSegmentView segmentViewWithTitles:titles viewControls:self.childViewControllers];
    [self.view addSubview:segmentView];
    

    
}
//- (void)switchView:(UISegmentedControl *)segmentControl{
//    NSInteger index = segmentControl.selectedSegmentIndex;
//    CGSize screenSize = [UIScreen mainScreen].bounds.size;
//    switch (index) {
//        case 0:
//            self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 104, screenSize.width, screenSize.height) style:UITableViewStylePlain];
//            self.tableView.dataSource = self;
//            self.tableView.delegate = self;
//            [self.view addSubview:self.tableView];
//                  break;
//         case 1:
//                  break;
//        default:
//            break;
//    }
//    
//   }

#pragma mark searchBar的代理
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    RJJSouSuoViewController *vc = [[RJJSouSuoViewController alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];

    return NO;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark 信息按钮的方法
- (void)memageClick{

    RJJMemageViewController *memageVc = [[RJJMemageViewController alloc] init];
    memageVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:memageVc animated:YES];


}
- (void)setUpForDismissKeyBoard{
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard)];
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillShowNotification object:nil queue:mainQueue usingBlock:^(NSNotification * _Nonnull note) {
        [self.view addGestureRecognizer:tap];
    }];
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardWillHideNotification object:nil queue:mainQueue usingBlock:^(NSNotification * _Nonnull note) {
        [self.view removeGestureRecognizer:tap];
    }];
}
#pragma mark 手势识别器的方法 收起键盘
- (void)hideKeyBoard{
    
    [self.view endEditing:YES];
    
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 1;
//}
//
//
// - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//     static NSString *ID = @"person";
//     UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//     if (!cell) {
//         cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
//     }
//     cell.textLabel.text = @"任京记";
//     cell.detailTextLabel.text = @"你到底爱着谁";
//     cell.imageView.image = [UIImage imageNamed:@""];
// 
//     
//     return cell;
// }



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
