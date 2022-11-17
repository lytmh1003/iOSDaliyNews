//
//  webView.h
//  DaliyNews
//
//  Created by 李育腾 on 2022/10/21.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import <FMDB.h>
NS_ASSUME_NONNULL_BEGIN
@protocol extraDelegate <NSObject>

- (void)getId:(id)extraId and:(NSString *)mainLabel and:(NSString *)imageUrl;

@end
@protocol webButtonDelegate <NSObject>
/// 返回
- (void)returnButton:(UIButton*) button;

@end
// 及时更新点赞和评论数据
@protocol webExtraDataDelegate <NSObject>

- (void)returnExtraPage:(id)nowID;
- (void)returnAllBeforeCount:(NSInteger)nowCount;

@end


@interface webView : UIView <UIScrollViewDelegate>
@property (nonatomic, strong) UIView* viewBackgroud;
@property (nonatomic, strong) UIView* viewLine;
@property (nonatomic, strong) UIButton* buttonReturn;
@property (nonatomic, strong) UIButton* buttonComment;
@property (nonatomic, strong) UIButton* buttonGood;
@property (nonatomic, strong) UIButton* buttonCollection;
@property (nonatomic, strong) UIButton* buttonShare;
@property (nonatomic, weak) id<webButtonDelegate> delegate;
@property (nonatomic, strong) UIScrollView* scrollView;
- (void)initView;
@property (nonatomic, strong) WKWebView* webView;
@property (nonatomic, strong) NSDictionary* topUrlDictionary;
@property (nonatomic, assign) NSInteger nowPage;
@property (nonatomic, strong) UILabel* labelGood;
@property (nonatomic, strong) UILabel* labelCollection;
// top 和 before 信息
@property (nonatomic, strong) NSMutableArray* allArray;
// top 和 before 点赞和评论信息
@property (nonatomic, strong) NSDictionary* extraDict;
@property (nonatomic, strong) id<webExtraDataDelegate> extraDelegate;

//
@property (nonatomic, strong) NSMutableArray* allBeforeArray;
@property (nonatomic, strong) NSString* beforeString;
@property (nonatomic, assign) NSInteger isRequest;

@property (assign, nonatomic) id<extraDelegate> secondDelegate;

// 判断是否是从收藏界面进来
@property (nonatomic, assign) NSInteger collectViewFlag;
- (void)scrollViewReload;

@end

NS_ASSUME_NONNULL_END
