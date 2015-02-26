//
//  GTNewsViewController.h
//  qingcheng123
//
//  Created by Qidalatu on 14/10/24.
//  Copyright (c) 2014年 Golden Totem. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GTCategoryItem.h"

#define news_content_pic            1
#define news_content_title          2
#define news_content_read_count     3
#define news_content_read_img       4
#define news_content_comment_count  5
#define news_content_comment_img    6
#define news_content_timestamp      7
#define news_content_from           8

#define news_content_ads            10

@interface GTNewsViewController : UITableViewController

@property (nonatomic, retain) UIViewController *pViewCtrl;

@property (nonatomic, retain) GTCategoryItem *category;

@end
