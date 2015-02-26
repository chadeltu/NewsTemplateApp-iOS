//
//  GTNewsItem.h
//  qingcheng123
//
//  Created by Qidalatu on 14/10/24.
//  Copyright (c) 2014年 Golden Totem. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GTNewsItem : NSObject

@property (nonatomic, copy) NSString *newsID;
@property (nonatomic, copy) NSString *newsKind;
@property (nonatomic, copy) NSString *newsTitle;
@property (nonatomic, copy) NSString *newsFrom;
@property (nonatomic, copy) NSString *newsPic;
@property (nonatomic) long long timestamp;
@property (nonatomic) long readCount;
@property (nonatomic) long commentCount;

@end
