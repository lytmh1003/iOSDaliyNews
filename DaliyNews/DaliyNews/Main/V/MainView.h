//
//  MainView.h
//  DaliyNews
//
//  Created by 李育腾 on 2022/10/12.
//

#import <UIKit/UIKit.h>
#import "TableViewCellTop.h"
NS_ASSUME_NONNULL_BEGIN
@protocol buttonDelegate <NSObject>
/// 返回
- (void)returnButton:(UIButton*) button;

@end
@protocol dataDelegate <NSObject>

- (void)returnDatabefore: (int) dataBefore;

@end
@protocol cellDelegate <NSObject>

- (void)retutnImageTag: (NSInteger) nowTag;
@end
@interface MainView : UIView <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
@property (nonatomic, weak) id<buttonDelegate> delegate;
- (void) initView;
@property (nonatomic, strong) NSDictionary* data;
@property (nonatomic, strong) NSDictionary* beforeData;
// 加载
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, assign) int dataBefore;
@property (nonatomic, weak) id<dataDelegate> delegateBefore;
@property (nonatomic, strong) NSMutableArray* arrayBefore;
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, weak) id<cellDelegate> delegateCell;
@property (nonatomic, strong) TableViewCellTop* cellTop;
@end

NS_ASSUME_NONNULL_END
