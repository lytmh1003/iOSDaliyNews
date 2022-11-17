//
//  TableViewCellTop.m
//  DaliyNews
//
//  Created by 李育腾 on 2022/10/14.
//

#import "TableViewCellTop.h"
#import "Manager.h"
#import "Masonry.h"
#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height
@implementation TableViewCellTop

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.scrollview = [[UIScrollView alloc] init];
    [self.contentView addSubview:_scrollview];
    _scrollview.tag = 0;
    
    self.pageControl = [[UIPageControl alloc] init];
    _pageControl.numberOfPages = 5;
    _pageControl.currentPage = 0;
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
    [self.contentView addSubview:_pageControl];

    
    _myTimer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(timeOut:) userInfo:nil repeats:YES];
    NSRunLoop* runloop = [NSRunLoop currentRunLoop];
    [runloop addTimer:_myTimer forMode:NSRunLoopCommonModes];
    return self;
    
}

- (void)layoutSubviews {
    _pageControl.frame = CGRectMake(200, 360, 300, 50);
    self.scrollview.frame = CGRectMake(0, 0, Width, Width);
    self.scrollview.pagingEnabled = YES;
    self.scrollview.scrollEnabled = YES;
    self.scrollview.contentSize = CGSizeMake(Width * 7, 80);
    self.scrollview.bounces = YES;
    self.scrollview.alwaysBounceHorizontal = NO;
    self.scrollview.alwaysBounceVertical = NO;
    self.scrollview.showsHorizontalScrollIndicator = NO;
    self.scrollview.delegate = self;

    
    
if (_scrollview.tag == 0)
    [_scrollview setContentOffset:CGPointMake(Width, 0) animated:NO];
    _scrollview.tag = 1;
}


//当scrollView停止滚动之后调用此方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView.tag == 1) {
        //计算偏移量所对应的页数
        int page = _scrollview.contentOffset.x / Width;
        if (page == 6) {
            _scrollview.contentOffset = CGPointMake(Width * 1, 0);
            _pageControl.currentPage = 0;
        } else if (page == 0) {
            _scrollview.contentOffset = CGPointMake(Width * 5, 0);
            _pageControl.currentPage = 5;
        } else {
            _pageControl.currentPage = page - 1;
        }
    }
}

- (void)timeOut:(NSTimer*)timer {
        [_scrollview setContentOffset:CGPointMake(_scrollview.contentOffset.x + Width, 0) animated:YES];
//    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView.tag == 1) {
        [_myTimer invalidate];
        _myTimer = nil;
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView.tag == 1) {
        _myTimer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(timeOut:) userInfo:nil repeats:YES];
    }
}
/*- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (scrollView.tag == 111) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(timeOut:) userInfo:self repeats:YES];
    }
}*/

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.tag == 1) {
        if (_scrollview.contentOffset.x >= Width * 6) {
            [_scrollview setContentOffset:CGPointMake(Width, 0) animated:NO];
        } else if (_scrollview.contentOffset.x == 0) {
            [_scrollview setContentOffset:CGPointMake(Width * 5, 0)];
        }
        _pageControl.currentPage = (_scrollview.contentOffset.x) / Width - 1;

    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    NSLog(@"Cell dealloc");
}

@end
