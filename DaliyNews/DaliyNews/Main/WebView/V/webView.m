//
//  webView.m
//  DaliyNews
//
//  Created by 李育腾 on 2022/10/21.
//

#import "webView.h"
#import "Masonry.h"
#import "Manager.h"
#import <FMDB.h>
#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height
@implementation webView
- (void)initView {
    _isRequest = 0;
    UIColor* newGray = [UIColor colorWithRed:246 / 255.f green:246 /255.f blue:246 / 255.f alpha:1.0];
    _viewBackgroud = [[UIView alloc] init];
    _viewBackgroud.backgroundColor = newGray;
    [self addSubview:_viewBackgroud];
    [_viewBackgroud mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(Height - Height * 0.08);
        make.left.equalTo(self).offset(0);
        make.width.equalTo(@(Width));
        make.height.equalTo(@(Height * 1));
    }];
    _viewLine = [[UIView alloc] init];
    _viewLine.frame = CGRectMake(Width * 0.16, Height - Height * 0.063, 1, Height * 0.038);
    [self addSubview:_viewLine];
    _viewLine.backgroundColor = [UIColor grayColor];
    // Do any additional setup after loading the view.
    _buttonReturn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_buttonReturn setImage:[UIImage imageNamed:@"fanhui.png"] forState:UIControlStateNormal];
    _buttonReturn.tintColor = [UIColor blackColor];
    _buttonReturn.tag = 1;
    [self addSubview:_buttonReturn];
    _buttonReturn.frame = CGRectMake(Width * 0.05, Height - Height * 0.065, 36, 36);
    [_buttonReturn addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];

    _buttonComment = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_buttonComment setImage:[UIImage imageNamed:@"pinglun.png"] forState:UIControlStateNormal];
    _buttonComment.tintColor = [UIColor blackColor];
    [self addSubview:_buttonComment];
    _buttonComment.frame = CGRectMake(Width * 0.22, Height - Height * 0.0602, 25, 31);
    _buttonComment.tag = 2;
    [_buttonComment addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];

    _buttonGood = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_buttonGood setImage:[UIImage imageNamed:@"dianzan.png"] forState:UIControlStateNormal];
    _buttonGood.tintColor = [UIColor blackColor];
    [self addSubview:_buttonGood];
    _buttonGood.frame = CGRectMake(Width * 0.42, Height - Height * 0.063, 32, 32);
    _buttonGood.tag = 3;
    [_buttonGood addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];

    _buttonCollection = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_buttonCollection setImage:[UIImage imageNamed:@"shoucang.png"] forState:UIControlStateNormal];
    _buttonCollection.tintColor = [UIColor blackColor];
    [self addSubview:_buttonCollection];
    _buttonCollection.frame = CGRectMake(Width * 0.628, Height - Height * 0.063, 31, 31);
    _buttonCollection.tag = 4;
    [_buttonCollection addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];

    _buttonShare = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_buttonShare setImage:[UIImage imageNamed:@"31zhuanfa.png"] forState:UIControlStateNormal];
    _buttonShare.tintColor = [UIColor blackColor];
    [self addSubview:_buttonShare];
    _buttonShare.frame = CGRectMake(Width * 0.86, Height - Height * 0.065, 33, 33);
    _buttonShare.tag = 5;
    [_buttonShare addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
// 轮播图
    // top的显示
    _scrollView = [[UIScrollView alloc] init];
    _scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.scrollEnabled = YES;
    self.scrollView.bounces = YES;
    self.scrollView.alwaysBounceHorizontal = NO;
    self.scrollView.alwaysBounceVertical = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    [self addSubview:_scrollView];
    // scrollView初始位置
    
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.left.equalTo(self).offset(0);
        make.height.equalTo(@(Height * 0.92));
        make.width.equalTo(@(Width));
    }];
    
    // 点赞和评论数据
    _labelGood = [[UILabel alloc] init];
    _labelGood.font = [UIFont systemFontOfSize:13];
    [self addSubview:_labelGood];
    _labelGood.frame = CGRectMake(Width * 0.49, Height - Height * 0.071, 32, 32);
    
    _labelCollection = [[UILabel alloc] init];
    _labelCollection.font = [UIFont systemFontOfSize:13];
    [self addSubview:_labelCollection];
    _labelCollection.frame = CGRectMake(Width * 0.29, Height - Height * 0.071, 32, 32);
    
}
- (void)layoutSubviews {
    NSLog(@"%ld", _collectViewFlag);
    [super layoutSubviews];
    if (_collectViewFlag == 777) {
        [self isCollectioWebnView];
    } else {
        [self isCurrentWebView];
    }
}
// 普通的wenVIew
- (void)isCurrentWebView {
    if (_nowPage < 5) {
        _scrollView.contentOffset = CGPointMake(Width * _nowPage, 0);
        _scrollView.tag = 66;
        self.scrollView.contentSize = CGSizeMake(Width * 5, 0);
        [_secondDelegate getId:_allArray[0][@"top_stories"][_nowPage][@"id"] and:_allArray[0][@"top_stories"][_nowPage][@"title"] and:_allArray[0][@"top_stories"][_nowPage][@"image"]];
        for (int i = 0; i < 5; i++) {
            _webView = [[WKWebView alloc] init];
            NSURL* urlWeb = [NSURL URLWithString:_allArray[0][@"top_stories"][i][@"url"]];
            NSURLRequest* webRequest = [[NSURLRequest alloc] initWithURL:urlWeb];
            [_webView loadRequest:webRequest];
            _webView.frame = CGRectMake(Width * i, Height * 0.05, Width, Height * 0.9);
            [self.scrollView addSubview:_webView];
        }
    } else {
        self.scrollView.contentSize = CGSizeMake(Width * _allBeforeArray.count * 6, 0);
        _scrollView.contentOffset = CGPointMake(Width * (_nowPage - 5), 0);
        _scrollView.tag = 77;
        [_secondDelegate getId:_allArray[0][@"stories"][(_nowPage - 5) / 6][@"id"] and:_allArray[0][@"stories"][(_nowPage - 5) / 6][@"title"] and:_allArray[0][@"stories"][(_nowPage - 5) / 6][@"images"][0]];
        for (int i = 0; i < _allBeforeArray.count; i++) {
            for (int j = 0; j < 6; j++) {
                _webView = [[WKWebView alloc] init];
//
                NSURL* urlWeb = [NSURL URLWithString:_allBeforeArray[i][@"stories"][j][@"url"]];
                NSURLRequest* webRequest = [[NSURLRequest alloc] initWithURL:urlWeb];
                [_webView loadRequest:webRequest];
                _webView.frame = CGRectMake(Width * (6 * i + j), Height * 0.05, Width, Height * 0.9);
                [self.scrollView addSubview:_webView];
            }
        }
    }
}
// 收藏的webView
- (void)isCollectioWebnView {
//    _scrollView.tag = 77;
    _scrollView.contentSize = CGSizeMake(self.allArray.count * Width, 0);
    [_secondDelegate getId:_allArray[0][@"id"] and:_allArray[0][@"title"] and:_allArray[0][@"image"]];
    [self.scrollView setContentOffset:CGPointMake(Width * _nowPage, 0)];
    [_extraDelegate returnExtraPage:_allArray[0][@"id"]];
    for (int i = 0; i < self.allArray.count; i++) {
        _webView = [[WKWebView alloc] init];
        NSString *string = [NSString stringWithFormat:@"https://daily.zhihu.com/story/%@", _allArray[i][@"id"]];
        NSURL *url = [NSURL URLWithString:string];
//        _webView.tag = 1011;
        
        _webView.frame = CGRectMake(Width * i, Height * 0.05, Width, Height * 0.9);
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [_webView loadRequest:request];
        [self.scrollView addSubview: _webView];
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    NSLog(@"allBeforeArray.count =  %ld", _allBeforeArray.count);
    if (_scrollView.tag == 77) {
        if (_scrollView.contentOffset.x >= _allBeforeArray.count * 6 * Width - Width)
            if (_isRequest == 0) {
                [_extraDelegate returnAllBeforeCount:_allBeforeArray.count];
                _isRequest = 1;
                NSLog(@"allBeforeArray.count =  %ld", _allBeforeArray.count);
            }
    }
}
- (void)scrollViewReload {
        self.scrollView.contentSize = CGSizeMake(Width * _allBeforeArray.count * 6, 0);
        _scrollView.tag = 77;
            for (int j = 0; j < [_allBeforeArray[_allBeforeArray.count - 1][@"stories"] count]; j++) {
                _webView = [[WKWebView alloc] init];
                NSURL* urlWeb = [NSURL URLWithString:_allBeforeArray[_allBeforeArray.count - 1][@"stories"][j][@"url"]];
                NSURLRequest* webRequest = [[NSURLRequest alloc] initWithURL:urlWeb];
                [_webView loadRequest:webRequest];
                NSLog(@" [self searchCollectionButtonSelected];");
                // 2022-10.28 在这里改了BUg 就是从第一天翻到下一题天的时候会造成有12个Scrolview但是前6个不显示url的内容，因为_webView的frame设置的问题，应该是_allBeforeArray.count - 1 不是_allBeforeArray.count
                _webView.frame = CGRectMake(Width * (6 * (_allBeforeArray.count - 1) + j), Height * 0.05, Width, Height * 0.9);
                [self.scrollView addSubview:_webView];
                _isRequest = 0;
            }
}
// 即使获取新闻信息
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int page = scrollView.contentOffset.x / Width;
    if (_collectViewFlag == 777) {
        [_secondDelegate getId:_allArray[page][@"id"] and:_allArray[page][@"title"] and:_allArray[page][@"image"]];
        [_extraDelegate returnExtraPage:_allArray[page][@"id"]];
    } else if (_nowPage < 5) {
        [_extraDelegate returnExtraPage:_allArray[0][@"top_stories"][page][@"id"]];
        [_secondDelegate getId:_allArray[0][@"top_stories"][page][@"id"] and:_allArray[0][@"top_stories"][page][@"title"] and:_allArray[0][@"top_stories"][page][@"image"]];
    } else {
        [_extraDelegate returnExtraPage:_allBeforeArray[page / 6][@"stories"][page % 6][@"id"]];
        [_secondDelegate getId:_allBeforeArray[page / 6][@"stories"][page % 6][@"id"] and:_allBeforeArray[page / 6][@"stories"][page % 6][@"title"] and:_allBeforeArray[page / 6][@"stories"][page % 6][@"images"][0]];
    }
}
// 更新数据

// 返回按钮
- (void)pressButton:(UIButton*) button {
    [_delegate returnButton:button];
    
}

@end
