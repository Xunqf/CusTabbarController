//
//  MyTabBarViewController.m
//  CusTabbarController
//
//  Created by MacBook on 14-7-8.
//  Copyright (c) 2014年 zhiyou. All rights reserved.
//

#import "MyTabBarViewController.h"

@interface MyTabBarViewController (){
    UIView *_contentView;
    UIView *_tabBar;
    UIButton *_selectedButton;

}
@property(nonatomic,strong)NSArray *viewControllers;
@end

@implementation MyTabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    
    UIViewController* vc1 = [[UIViewController alloc] init];
    vc1.view.backgroundColor = [UIColor redColor];
    UIViewController* vc2 = [[UIViewController alloc] init];
    vc2.view.backgroundColor = [UIColor purpleColor];
    UIViewController* vc3 = [[UIViewController alloc] init];
    vc3.view.backgroundColor = [UIColor cyanColor];
    _viewControllers = @[vc1, vc2, vc3];
    
    //用来显示ViewContoller
    _contentView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_contentView];
    
    //第二步，创建tabbar
    //注意y坐标，思考一下
    _tabBar = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 49, 320, 49)];
    _tabBar.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_tabBar];
    
    //有几个viewController就需要有几个按钮
    NSInteger count = [_viewControllers count];
    //按钮的宽度
    CGFloat width = 320 / count;
    
    
    NSArray* normalImages = @[@"home_tab_icon_1.png", @"home_tab_icon_2.png", @"home_tab_icon_3.png", @"home_tab_icon_4.png"];
    
    NSArray* selectedImages = @[@"home_tab_icon_1_selected.png", @"home_tab_icon_2_selected.png", @"home_tab_icon_3_selected.png", @"home_tab_icon_4_selected.png"];
    
    for (int i = 0; i < count; i++) {
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;//为了和ViewControllers的索引想对应
        button.frame = CGRectMake(width * i, 0, width, 49);
        [button setImage:[UIImage imageNamed:normalImages[i]] forState:UIControlStateNormal];
        //为选中状态添加一张图片
        [button setImage:[UIImage imageNamed:selectedImages[i]] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [_tabBar addSubview:button];
        
        //设置默认的状态
        if (i == 0) {
            [self clickButton:button];
        }
    }


}
- (void)clickButton:(UIButton* )button {
    //button.selected = YES，触发UIControlStateSelected状态
    //button.enabled = NO，触发UIControlStateDisabled状态。
    //    button.selected = YES;//选中一个按钮。
    
    //取消旧的选中
    _selectedButton.selected = NO;
    //把选中的button设为当前的button
    _selectedButton = button;
    //选中但当前的button
    _selectedButton.selected = YES;
    
    //从_viewControllers取出button对应的VC
    UIViewController* vc = _viewControllers[button.tag];
    
    //如果没有添加到_contentView上，就添加，否则就拿到最上层。
    //subviews-->当前视图的所有子视图
    //containsObject-->用来判断数组是否包含参数元素
    if ([_contentView.subviews containsObject:vc.view]) {
        [_contentView bringSubviewToFront:vc.view];
    }else {
        [_contentView addSubview:vc.view];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
