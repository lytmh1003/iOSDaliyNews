//
//  webViewController.h
//  DaliyNews
//
//  Created by 李育腾 on 2022/10/21.
//

#import "ViewController.h"
#import "webView.h"
#import <FMDB.h>
NS_ASSUME_NONNULL_BEGIN

@interface webViewController : ViewController<webButtonDelegate, webExtraDataDelegate, UIScrollViewDelegate, extraDelegate>
- (void)returnButton:(UIButton *)button;
- (void)returnExtraPage:(id)nowID;
// 在Scrollview里面更新数据
- (void)returnAllBeforeCount:(NSInteger)nowCount;
@property (nonatomic, strong)NSString* beforeString;
@property (nonatomic, strong) webView* web;
@property (nonatomic, assign) NSInteger nowPage;
@property (nonatomic, strong) NSDictionary* webPageDict;
@property (nonatomic, strong) NSMutableArray* allArray;
@property (nonatomic, strong) NSMutableArray* allBeforeArray;
@property (nonatomic, strong) NSString* extraID;
@property (nonatomic, strong) FMDatabase* dataBase;
- (void)getId:(id)extraId and:(NSString *)mainLabel and:(NSString *)imageUrl;
// 判断是否是从收藏界面进来
@property (nonatomic, assign) NSInteger collectViewFlag;
// 当前cell
//@property (nonatomic, assign) NSInteger nowRow;
@end

NS_ASSUME_NONNULL_END
