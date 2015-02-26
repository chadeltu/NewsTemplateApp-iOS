//
//  ASScroll.m
//  ScrollView Source control
//
//  Created by Ahmed Salah on 12/14/13.
//  Copyright (c) 2013 Ahmed Salah. All rights reserved.
//

#import "ASScroll.h"

@interface ASScroll()
{
    float m_screen_wid;
    float m_screen_hei;
}
@end

@implementation ASScroll
@synthesize arrOfImages;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        // Initialization code
        m_screen_wid = frame.size.width;
        m_screen_hei = frame.size.height;
    }
    return self;
}

-(void)setArrOfImages:(NSMutableArray *)arr{
    for (UIView *view in [self subviews])
    {
        [view removeFromSuperview];
    }
    didEndAnimate = NO;
    
    arrOfImages = arr;
    pageControl = [[UIPageControl alloc] init];
//    pageControl.frame = CGRectMake(self.frame.origin.x + self.frame.size.width / 2 - arrOfImages.count * 10, self.frame.origin.y + self.frame.size.height - 20, arrOfImages.count * 20, 20);
    pageControl.frame = CGRectMake(self.frame.origin.x + self.frame.size.width / 2 - arrOfImages.count * 10, self.frame.size.height - 20, arrOfImages.count * 20, 20);
    pageControl.numberOfPages = arrOfImages.count;
    pageControl.currentPage = 0;
    pageControl.alpha = 1.0;
    
    scrollview = [[UIScrollView alloc] initWithFrame:self.frame];
    m_screen_wid = self.frame.size.width;
    m_screen_hei = self.frame.size.height;
    scrollview.contentSize = CGSizeMake(scrollview.frame.size.width * arrOfImages.count,scrollview.frame.size.height);
    [scrollview setDelegate:self];
    scrollview.showsVerticalScrollIndicator = NO;
    scrollview.showsHorizontalScrollIndicator = NO;
    scrollview.pagingEnabled = YES;
    scrollview.scrollEnabled = YES;
    for (int i =0; i<arrOfImages.count ; i++) {
        UIImageView * imageview = [[UIImageView alloc]initWithImage:[arrOfImages objectAtIndex:i]];
        [imageview setContentMode:UIViewContentModeScaleToFill];
        imageview.frame = CGRectMake(0.0, 0.0,scrollview.frame.size.width , scrollview.frame.size.height);
        [imageview setTag:i+1];
        if (i !=0) {
            imageview.alpha = 0;
        }
        [self addSubview:imageview];
    }
    [pageControl addTarget:self
                    action:@selector(pgCntlChanged:)forControlEvents:UIControlEventValueChanged];
//    [self performSelector:@selector(startAnimatingScrl) withObject:nil afterDelay:3.0];

    [self addSubview:scrollview];
    [self addSubview:pageControl];
}
- (void)startAnimatingScrl
{
    if (!didEndAnimate) {
        if (arrOfImages.count) {
            [scrollview scrollRectToVisible:CGRectMake(((pageControl.currentPage + 1) % arrOfImages.count)*scrollview.frame.size.width, 0, scrollview.frame.size.width, scrollview.frame.size.height) animated:YES];
            [pageControl setCurrentPage:((pageControl.currentPage +1)%arrOfImages.count)];
            [self performSelector:@selector(startAnimatingScrl) withObject:nil  afterDelay:3.0];
        }
    }
}
- (void)cancelScrollAnimation{
    didEndAnimate = YES;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startAnimatingScrl) object:nil];
}

- (void)pgCntlChanged:(UIPageControl *)sender {
    [scrollview scrollRectToVisible:CGRectMake(sender.currentPage*scrollview.frame.size.width, 0, scrollview.frame.size.width, scrollview.frame.size.height) animated:YES];
    [self cancelScrollAnimation];
}

-(void)dealloc{
    [self cancelScrollAnimation];
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self cancelScrollAnimation];
    previousTouchPoint = scrollView.contentOffset.x;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [pageControl setCurrentPage:scrollview.bounds.origin.x/scrollview.frame.size.width];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [scrollView setContentOffset: CGPointMake(scrollView.contentOffset.x, 0)];
    
    int page = floor((scrollView.contentOffset.x - m_screen_wid) / m_screen_wid) + 1;
    float OldMin = m_screen_wid * page;
    int Value = scrollView.contentOffset.x - OldMin;
    int widTemp = m_screen_wid;
    float alpha = (Value % widTemp) / m_screen_wid;
    
    
    if (previousTouchPoint > scrollView.contentOffset.x)
        page = page+2;
    else
        page = page+1;
    
    UIView *nextPage = [scrollView.superview viewWithTag:page+1];
    UIView *previousPage = [scrollView.superview viewWithTag:page-1];
    UIView *currentPage = [scrollView.superview viewWithTag:page];
    
    if(previousTouchPoint <= scrollView.contentOffset.x){
        if ([currentPage isKindOfClass:[UIImageView class]])
            currentPage.alpha = 1-alpha;
        if ([nextPage isKindOfClass:[UIImageView class]])
            nextPage.alpha = alpha;
        if ([previousPage isKindOfClass:[UIImageView class]])
            previousPage.alpha = 0;
    }else if(page != 0){
        if ([currentPage isKindOfClass:[UIImageView class]])
            currentPage.alpha = alpha;
        if ([nextPage isKindOfClass:[UIImageView class]])
            nextPage.alpha = 0;
        if ([previousPage isKindOfClass:[UIImageView class]])
            previousPage.alpha = 1-alpha;
    }
    if (!didEndAnimate && pageControl.currentPage == 0) {
        for (UIView * imageView in self.subviews){
            if (imageView.tag !=1 && [imageView isKindOfClass:[UIImageView class]])
                imageView.alpha = 0;
            else if([imageView isKindOfClass:[UIImageView class]])
                imageView.alpha = 1 ;
        }
    }
    
}

@end
