//
//  GTMenuItem.h
//  qingcheng123
//
//  Created by Qidalatu on 14/11/4.
//  Copyright (c) 2014年 Golden Totem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GTMenuItem : NSObject

@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, retain) UIViewController *viewCtrl;

@end
