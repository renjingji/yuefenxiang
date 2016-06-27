//
//  BS_TopicView.m
//  BestNotSister
//
//  Created by huhang on 16/5/11.
//  Copyright © 2016年 huhang. All rights reserved.
//

#import "HHSegmentView.h"
#import "UIView+BSExtension.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface HHSegmentView ()<UIScrollViewDelegate>

//标题数组
@property (nonatomic,strong)NSArray *titles;
//子控制器数组
@property (nonatomic,strong)NSArray *viewcontrols;
//按钮数组
@property (nonatomic,strong)NSMutableArray *buttonArrs;
//选择按钮
@property (nonatomic,strong)UIButton *selectBtn;
//滑动视图
@property (nonatomic,strong)UIScrollView *scrollView;
//滑动视图
@property (nonatomic,strong)UIScrollView *btnScrollView;
//指示视图
@property (nonatomic,strong)UIView *indicatorView;

@end

@implementation HHSegmentView

+ (instancetype)segmentViewWithTitles:(NSArray *)titles viewControls:(NSArray *)viewControls{

    HHSegmentView *segmentView = [[HHSegmentView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) titles:titles viewcontrols:viewControls];
    return segmentView;
}

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles viewcontrols:(NSArray *)viewcontrols{
    
    if (self = [super initWithFrame:frame]) {
        
        self.titles = titles;
        self.viewcontrols = viewcontrols;
        [self setupAllTopicView];
    }
    return self;
}

- (void)setupAllTopicView{
    
    [self setupButtonView];
    
    [self setupScrollView];
}

- (void)setupButtonView{
    
    CGFloat itemBtnW = 80;
    CGFloat buttonH = 44;
    
    //滑动按钮
    UIScrollView *btnScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, buttonH)];
    btnScrollView.showsHorizontalScrollIndicator = NO;
    btnScrollView.backgroundColor = [UIColor whiteColor];
    btnScrollView.contentSize = CGSizeMake(itemBtnW * _titles.count, 0);
    [self addSubview:btnScrollView];
    self.btnScrollView = btnScrollView;

    //底部红色指示条
    UIView *indicatorView = [[UIView alloc]initWithFrame:CGRectMake(0, buttonH - 2, self.width, 2)];
    indicatorView.backgroundColor = [UIColor blueColor];
    [btnScrollView addSubview:indicatorView];
    self.indicatorView = indicatorView;
    
    //内部子标签
    if (_titles.count <= 4) {
        itemBtnW = self.width / _titles.count;
    }
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < _titles.count; i ++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * itemBtnW, 0, itemBtnW, buttonH);
        button.tag = i;
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:_titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateDisabled];
        [button addTarget:self action:@selector(titleTagsAction:) forControlEvents:UIControlEventTouchUpInside];
        [btnScrollView addSubview:button];
        [array addObject:button];
        
        if (i == 0) {
            button.enabled = NO;
            self.selectBtn = button;
            //调整按钮尺寸
            [button.titleLabel sizeToFit];
            //修改指示条宽度
            _indicatorView.width = button.titleLabel.width;
            _indicatorView.centerX = button.centerX;
        }
    }
    
    self.buttonArrs = array;

}

/**
 *创建控制器的scrollView
 */
- (void)setupScrollView{
   
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    scrollView.backgroundColor = [UIColor colorWithRed:233/255.0 green:233/255.0 blue:233/255.0 alpha:1.0];
    scrollView.contentSize = CGSizeMake(_viewcontrols.count * scrollView.width, 0);
    scrollView.delegate = self;
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    [self addSubview:scrollView];
    //将滑动视图放入最底部
    [self insertSubview:scrollView atIndex:0];
    self.scrollView = scrollView;
    //把控制器视图给显示上去
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

//设置子控制器的属性
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
 
    //添加控制器
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    UIViewController *childVC = self.viewcontrols[index];
    childVC.view.x = scrollView.contentOffset.x;
    
    [scrollView addSubview:childVC.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    //滑动时改变标签栏
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleTagsAction:self.buttonArrs[index]];
}

- (void)titleTagsAction:(UIButton *)sender{
    
    self.selectBtn.enabled = YES;
    sender.enabled = NO;
    self.selectBtn = sender;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = sender.titleLabel.width;
        self.indicatorView.centerX = sender.centerX;
    }];
    
    //控制器滑动
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = sender.tag * self.scrollView.width;
    [self.scrollView setContentOffset:offset animated:YES];
    
//    //按钮滑动
//    CGFloat center = 0;
//    for (UIButton *button in _buttonArrs) {
//        
//        if (button.tag == sender.tag) {
//            
//            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//            
//            if (self.center.x < 187.5 || self.center.x > 187.5) {
//                center = self.center.x;
//            }else if (self.center.x == 187.5){//4.7寸屏
//                center = self.center.x + 20;
//            }
//        
//            if (CGRectGetMaxX(button.frame) > center) {
//                if (CGRectGetMidX(button.frame) > center && _btnScrollView.contentSize.width - CGRectGetMidX(button.frame) > center) {
//                    [_btnScrollView setContentOffset:CGPointMake(CGRectGetMidX(button.frame) - center, 0) animated:YES];
//                }else {
//                    if (CGRectGetMidX(button.frame) < center) {
//                        [_btnScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
//                    }else{
//                        [_btnScrollView setContentOffset:CGPointMake(_btnScrollView.contentSize.width - self.frame.size.width, 0) animated:YES];
//                    }
//                }
//            }
//            
//        }else{
//            //改变字体颜色
//            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        }
//    }
}

@end
