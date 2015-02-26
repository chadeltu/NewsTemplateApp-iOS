//
//  GTMainViewController.m
//  qingcheng123
//
//  Created by Qidalatu on 14/10/24.
//  Copyright (c) 2014年 Golden Totem. All rights reserved.
//

#import "GTMainViewController.h"
#import "GTNewsViewController.h"
#import "GTAppDelegate.h"
#import "GTCategoryItem.h"
#import "SlideNavigationController.h"
#import "GTMenuViewController.h"

@interface GTMainViewController () <ViewPagerDataSource, ViewPagerDelegate>
{
    GTAppDelegate *delegate;
    NSMutableArray *categoryList;
}
@end

@implementation GTMainViewController

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
    delegate = (GTAppDelegate *)[[UIApplication sharedApplication] delegate];
    categoryList = [delegate arrCategories];
    
    GTMenuViewController *lMenu = (GTMenuViewController *)[SlideNavigationController sharedInstance].leftMenu;
    [lMenu setPViewCtrl:self];
    
    self.title = NSLocalizedString(@"LOC_APP_NAME", nil);
    
    self.dataSource = self;
    self.delegate = self;
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - ViewPagerDataSource
- (NSUInteger)numberOfTabsForViewPager:(ViewPagerController *)viewPager {
    return categoryList.count;
}
- (UIView *)viewPager:(ViewPagerController *)viewPager viewForTabAtIndex:(NSUInteger)index {
    
    GTCategoryItem *item = [categoryList objectAtIndex:index];
    
    UILabel *label = [UILabel new];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:13.0];
    if (item) {
        label.text = item.categoryName;
    }
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    [label sizeToFit];
    
    return label;
}

- (UIViewController *)viewPager:(ViewPagerController *)viewPager contentViewControllerForTabAtIndex:(NSUInteger)index {
    
    GTNewsViewController *vCtrl = [self.storyboard instantiateViewControllerWithIdentifier:@"NewsViewController"];
    [vCtrl setPViewCtrl:self];
    return vCtrl;
}

#pragma mark - ViewPagerDelegate
- (CGFloat)viewPager:(ViewPagerController *)viewPager valueForOption:(ViewPagerOption)option withDefault:(CGFloat)value {
    CGFloat result = 0.0;
    switch (option) {
        case ViewPagerOptionStartFromSecondTab:
            result = 1.0;
            break;
        case ViewPagerOptionCenterCurrentTab:
            result = 0.0;
            break;
        case ViewPagerOptionTabLocation:
            result = 1.0;
            break;
        case ViewPagerOptionTabWidth:
            result = self.view.frame.size.width / 5;
            break;
        default:
            result = value;
            break;
    }
    
    return result;
}
- (UIColor *)viewPager:(ViewPagerController *)viewPager colorForComponent:(ViewPagerComponent)component withDefault:(UIColor *)color {
    
    switch (component) {
        case ViewPagerIndicator:
            return [[UIColor redColor] colorWithAlphaComponent:0.64];
            break;
        default:
            break;
    }
    
    return color;
}

#pragma mark - SlideNavigationController Methods

- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
	return YES;
}

- (BOOL)slideNavigationControllerShouldDisplayRightMenu
{
	return NO;
}

@end
