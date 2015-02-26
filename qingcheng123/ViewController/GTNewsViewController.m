//
//  GTNewsViewController.m
//  qingcheng123
//
//  Created by Qidalatu on 14/10/24.
//  Copyright (c) 2014年 Golden Totem. All rights reserved.
//

#import "GTNewsViewController.h"
#import "GTNewsItem.h"
#import "MJRefresh.h"
#import "ASScroll.h"
#import "GTLoginViewController.h"

#define gtNewsPadding 8.0
#define gtFontSizeBig 16.0
#define gtFontSizeSmall 12.0

static NSString *CellIdentifier1 = @"NewsAdsCell";
static NSString *CellIdentifier2 = @"NewsListCell";

@interface GTNewsViewController ()
{
    NSMutableArray *arrNews;
//    NSDateFormatter *formatter;
    
    double lastRefreshTime;
}
@end

@implementation GTNewsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initParam];
    [self setupRefresh];
    [self loadNews];
}

- (void)initParam
{
    if (arrNews) {
        [arrNews removeAllObjects];
    } else {
        arrNews = [[NSMutableArray alloc] init];
    }
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    //    [self.tableView headerBeginRefreshing];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}

- (void)loadNews
{
    for (int i = 0; i < 5; i++) {
        GTNewsItem *item = [[GTNewsItem alloc] init];
        item.newsID = [NSString stringWithFormat:@"%d", i];
        item.newsTitle = [NSString stringWithFormat:@"热点新闻 -- %d", i];
        item.newsFrom = @"参考消息";
        item.newsPic = nil;
        item.timestamp = [[NSDate date] timeIntervalSince1970] * 1000;
        item.readCount = i * 1000;
        item.commentCount = i * 1000;
        
        [arrNews addObject:item];
    }
}
#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    for (int i = 0; i < 5; i++) {
        GTNewsItem *item = [[GTNewsItem alloc] init];
        item.newsID = [NSString stringWithFormat:@"%d", i];
        item.newsTitle = [NSString stringWithFormat:@"热点新闻热点新闻热点新闻热点新闻热点新闻热点新闻热点新闻热点新闻热点新闻热点新闻热点新闻热点新闻热点新闻热点新闻热点新闻热点新闻热点新闻热点新闻热点新闻热点新闻热点新闻热点新闻热点新闻热点新闻热点新闻热点新闻热点新闻热点新闻热点新闻热点新闻热点新闻热点新闻热点新闻热点新闻热点新闻热点新闻热点新闻热点新闻 -- %d", i];
        item.newsFrom = @"腾讯新闻";
        item.newsPic = nil;
        item.timestamp = [[NSDate date] timeIntervalSince1970] * 1000;
        item.readCount = i * 1000;
        item.commentCount = i * 2000;
        
        [arrNews insertObject:item atIndex:0];
    }
    
    [self.tableView reloadData];
    [self.tableView headerEndRefreshing];
}

- (void)footerRereshing
{
    for (int i = 0; i < 5; i++) {
        GTNewsItem *item = [[GTNewsItem alloc] init];
        item.newsID = [NSString stringWithFormat:@"%d", i];
        item.newsTitle = [NSString stringWithFormat:@"热点新闻热点新闻热点新闻热点新闻热点新闻热点新闻热点新闻热点新闻热点新 -- %d", i];
        item.newsFrom = @"搜狐新闻";
        item.newsPic = nil;
        item.timestamp = [[NSDate date] timeIntervalSince1970] * 1000;
        item.readCount = i * 10;
        item.commentCount = i;
        
        [arrNews addObject:item];
    }
    
    [self.tableView reloadData];
    [self.tableView footerEndRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrNews.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    UITableViewCell *cell;
    if (row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier1];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier2];
    }
    
    
    float contentWid = self.view.frame.size.width - 3 * gtNewsPadding;
    
    //定义新的cell
    if(cell == nil)
    {
        if (row == 0) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier1];
            
            ASScroll *asScroll = [[ASScroll alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.frame.size.width, self.view.frame.size.width * 0.3)];
            asScroll.tag = news_content_ads;
            [cell.contentView addSubview:asScroll];
            
        } else {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier2];
            
            // 新闻图片
            CGRect picRect = CGRectMake(gtNewsPadding, gtNewsPadding, contentWid / 3, contentWid / 4);
            UIImageView *ivPic = [[UIImageView alloc] initWithFrame:picRect];
            ivPic.tag = news_content_pic;
            [cell.contentView addSubview:ivPic];
            
            // 新闻标题
            UILabel *lbTitle = [[UILabel alloc] init];
            lbTitle.font = [UIFont boldSystemFontOfSize:gtFontSizeBig];
            lbTitle.tag = news_content_title;
            lbTitle.textColor = [UIColor brownColor];
            [cell.contentView addSubview:lbTitle];
            
            // 新闻来源
            UILabel *lbFrom = [[UILabel alloc] init];
            lbFrom.font = [UIFont boldSystemFontOfSize:gtFontSizeSmall];
            lbFrom.tag = news_content_from;
            lbFrom.textColor = [UIColor grayColor];
            [cell.contentView addSubview:lbFrom];
            
            // 新闻阅读数量（图标）
            UIImageView *ivReadCount = [[UIImageView alloc] init];
            ivReadCount.tag = news_content_read_img;
            [cell.contentView addSubview:ivReadCount];
            
            // 新闻阅读数量
            UILabel *lbReadCount = [[UILabel alloc] init];
            lbReadCount.font = [UIFont boldSystemFontOfSize:gtFontSizeSmall];
            lbReadCount.tag = news_content_read_count;
            lbReadCount.textColor = [UIColor grayColor];
            [cell.contentView addSubview:lbReadCount];
            
            // 评论数量（图片）
            UIImageView *ivCommentCount = [[UIImageView alloc] init];
            ivCommentCount.tag = news_content_comment_img;
            [cell.contentView addSubview:ivCommentCount];
            
            // 评论数量
            UILabel *lbCommentCount = [[UILabel alloc] init];
            lbCommentCount.font = [UIFont boldSystemFontOfSize:gtFontSizeSmall];
            lbCommentCount.tag = news_content_comment_count;
            lbCommentCount.textColor = [UIColor grayColor];
            [cell.contentView addSubview:lbCommentCount];
        }
    }
    
    if (row == 0) {
        ASScroll *asScroll = (ASScroll *)[cell.contentView viewWithTag:news_content_ads];
        
        NSMutableArray * imagesArray = [[NSMutableArray alloc] init];
        int noOfImages = 3 ;
        for (int imageCount = 0; imageCount < noOfImages; imageCount++)
        {
            [imagesArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"ad_%d.jpg",imageCount+1]]];
        }
        [asScroll setArrOfImages:imagesArray];
    } else {
        GTNewsItem *obj = [arrNews objectAtIndex:(row - 1)];
        
        float fHei = gtNewsPadding;
        
        // 新闻图片
        UIImageView *ivPic = (UIImageView *)[cell.contentView viewWithTag:news_content_pic];
        ivPic.image = [UIImage imageNamed:@"placeholder_logo.png"];
        
        // 新闻标题
        UILabel *lbTitle = (UILabel *)[cell.contentView viewWithTag:news_content_title];
        CGSize ttlSize = {0, 0};
        ttlSize = [obj.newsTitle sizeWithFont:[UIFont systemFontOfSize:gtFontSizeBig]
                            constrainedToSize:CGSizeMake(2 * contentWid / 3, 5000)
                                lineBreakMode:NSLineBreakByWordWrapping];
        lbTitle.numberOfLines = 0;  //表示label可以多行显示
        lbTitle.lineBreakMode = NSLineBreakByWordWrapping;  //换行模式
        CGRect ttlRect = CGRectMake(contentWid / 3 + 2 * gtNewsPadding, fHei, 2 * contentWid / 3, ttlSize.height);
        [lbTitle setFrame:ttlRect];
        lbTitle.text = obj.newsTitle;
        
        fHei += ttlSize.height + gtNewsPadding;
        
        // 控件位置 从右算起
        float widPos = self.view.frame.size.width - gtNewsPadding - 104;
        
        // 新闻来源
        UILabel *lbFrom = (UILabel *)[cell.contentView viewWithTag:news_content_from];
        float fromWid = widPos - (contentWid / 3 + 2 * gtNewsPadding + 4);
        CGRect fromRect;
        if (fromWid > 0) {
            fromRect = CGRectMake(contentWid / 3 + 2 * gtNewsPadding, fHei, fromWid, 16);
        } else {
            fromRect = CGRectMake(contentWid / 3 + 2 * gtNewsPadding, fHei, 0, 16);
        }
        [lbFrom setFrame:fromRect];
        lbFrom.text = obj.newsFrom;
        lbFrom.textAlignment = NSTextAlignmentLeft;
        
        // 阅读数量
        UILabel *rcLabel = (UILabel *)[cell.contentView viewWithTag:news_content_read_count];
        CGRect rcLRect = CGRectMake(widPos, fHei, 30, 16);
        [rcLabel setFrame:rcLRect];
        rcLabel.text = [NSString stringWithFormat:@"%ld",obj.readCount];
        rcLabel.textAlignment = NSTextAlignmentRight;
        widPos += 30 + 4;
        
        // 阅读数量（图标）
        UIImageView *ivReadCount = (UIImageView *)[cell.contentView viewWithTag:news_content_read_img];
        CGRect rcRect = CGRectMake(widPos, fHei, 16, 16);
        [ivReadCount setFrame:rcRect];
        ivReadCount.image = [UIImage imageNamed:@"icon_read_count.png"];
        widPos += 16 + 4;
        
        // 评论数量
        UILabel *ccLabel = (UILabel *)[cell.contentView viewWithTag:news_content_comment_count];
        CGRect ccLRect = CGRectMake(widPos, fHei, 30, 16);
        ccLabel.text = [NSString stringWithFormat:@"%ld",obj.commentCount];
        ccLabel.textAlignment = NSTextAlignmentRight;
        [ccLabel setFrame:ccLRect];
        widPos += 30 + 4;
        
        // 评论数量（图标）
        UIImageView *ivCommentCount = (UIImageView *)[cell.contentView viewWithTag:news_content_comment_img];
        CGRect ccRect = CGRectMake(widPos, fHei, 16, 16);
        [ivCommentCount setFrame:ccRect];
        ivCommentCount.image = [UIImage imageNamed:@"icon_comment_count.png"];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger iRow = [indexPath row];
    if (iRow == 0) {
        return self.view.frame.size.width * 0.3;
    } else {
        GTNewsItem *obj = [arrNews objectAtIndex:(iRow - 1)];
        
        float contentWid = self.view.frame.size.width - 3 * gtNewsPadding;
        float picHei = contentWid / 4 + 2 * gtNewsPadding;
        
        CGSize labelSize = {0, 0};
        labelSize = [obj.newsTitle sizeWithFont:[UIFont systemFontOfSize:gtFontSizeBig]
                              constrainedToSize:CGSizeMake(2 * contentWid / 3, 5000)
                                  lineBreakMode:NSLineBreakByWordWrapping];
        float fContentHei = labelSize.height + 3 * gtNewsPadding + 16;
        
        if (picHei > fContentHei) {
            return picHei;
        } else {
            return fContentHei;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.pViewCtrl) {
        NSInteger iRow = [indexPath row];
        NSLog(@"item - %ld", (long)iRow);
        [self.pViewCtrl.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"] animated:YES];
    }
}

@end
