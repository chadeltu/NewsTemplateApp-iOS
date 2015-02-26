//
//  GTMenuViewController.h
//  qingcheng123
//
//  Created by Qidalatu on 14/10/29.
//  Copyright (c) 2014年 Golden Totem. All rights reserved.
//

#import <UIKit/UIKit.h>

#define menu_item_picTag    1
#define menu_item_titleTag  2

@interface GTMenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (retain, nonatomic) IBOutlet UITableView *_tableView;
@property (retain, nonatomic) IBOutlet UILabel *lb_nickName;
@property (retain, nonatomic) IBOutlet UIImageView *iv_Head;

@property (nonatomic, retain) UIViewController *pViewCtrl;

@end
