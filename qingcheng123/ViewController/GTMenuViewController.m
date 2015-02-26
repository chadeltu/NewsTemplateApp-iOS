//
//  GTMenuViewController.m
//  qingcheng123
//
//  Created by Qidalatu on 14/10/29.
//  Copyright (c) 2014年 Golden Totem. All rights reserved.
//

#import "GTMenuViewController.h"
#import "GTLoginViewController.h"
#import "GTMenuItem.h"
#import "GTLoginViewController.h"

@interface GTMenuViewController ()
{
    UITapGestureRecognizer *ivTapReq, *lbTapReq;
    
    NSMutableArray *arrMenuItems;
}
@end

@implementation GTMenuViewController

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
    
    self._tableView.dataSource = self;
    self._tableView.delegate = self;

    [self initParam];
    [self initMenuItems];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self setUserInfo];
}

- (void)setUserInfo
{
    [self.lb_nickName setText:NSLocalizedString(@"LOC_NOT_LOGGEDIN", nil)];
}

- (void)initParam
{
    ivTapReq = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doSingleFingerTap:)];
    ivTapReq.numberOfTouchesRequired = 1; //手指
    ivTapReq.numberOfTapsRequired = 1;    //tap次数
    [self.iv_Head addGestureRecognizer:ivTapReq];
    
    lbTapReq = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doSingleFingerTap:)];
    lbTapReq.numberOfTouchesRequired = 1; //手指
    lbTapReq.numberOfTapsRequired = 1;    //tap次数
    [self.lb_nickName addGestureRecognizer:lbTapReq];
}

// 单指敲击
- (void)doSingleFingerTap:(UITapGestureRecognizer *)tap {
    if(tap.numberOfTapsRequired == 1) {  // 单指单击
        [self.pViewCtrl.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"] animated:YES];
    }
}

- (void)initMenuItems
{
    arrMenuItems = [[NSMutableArray alloc] init];
    
    GTMenuItem *item1 = [[GTMenuItem alloc] init];
    item1.pic = @"icon_menu_item.png";
    item1.title = @"菜单项1";
    item1.viewCtrl = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [arrMenuItems addObject:item1];
    
    GTMenuItem *item2 = [[GTMenuItem alloc] init];
    item2.pic = @"icon_menu_item.png";
    item2.title = @"菜单项2";
    item2.viewCtrl = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [arrMenuItems addObject:item2];
    
    GTMenuItem *item3 = [[GTMenuItem alloc] init];
    item3.pic = @"icon_menu_item.png";
    item3.title = @"菜单项3";
    item3.viewCtrl = [self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [arrMenuItems addObject:item3];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrMenuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MenuCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
        
        // 图片
        CGRect picRect = CGRectMake(24, 4, 32, 32);
        UIImageView *ivPic = [[UIImageView alloc] initWithFrame:picRect];
        ivPic.tag = menu_item_picTag;
        [cell.contentView addSubview:ivPic];
        
        // 标题
        CGRect titleRect = CGRectMake(80, 0, 200 - 80, 40);
        UILabel *lbTitle = [[UILabel alloc]initWithFrame:titleRect];
        lbTitle.font = [UIFont boldSystemFontOfSize:20];
        lbTitle.tag = menu_item_titleTag;
        lbTitle.textColor = [UIColor blueColor];
        lbTitle.lineBreakMode = NSLineBreakByWordWrapping;
        lbTitle.numberOfLines = 1;
        [cell.contentView addSubview:lbTitle];
    }
    
    NSInteger iRow = [indexPath row];
    GTMenuItem *obj = [arrMenuItems objectAtIndex:iRow];
    
    // 设置图片
    UIImageView *ivPic = (UIImageView *)[cell.contentView viewWithTag:menu_item_picTag];
    ivPic.image = [UIImage imageNamed:obj.pic];
    
    // 设置标题
    UILabel *lbTitle = (UILabel *)[cell.contentView viewWithTag:menu_item_titleTag];
    lbTitle.text = obj.title;
    
    return cell;
}

#pragma mark UITableViewDelegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.5;
}
    
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.pViewCtrl) {
        NSUInteger iRow = [indexPath row];
        GTMenuItem *obj = [arrMenuItems objectAtIndex:iRow];
        
        [self.pViewCtrl.navigationController pushViewController:obj.viewCtrl animated:YES];
    }
}

@end
