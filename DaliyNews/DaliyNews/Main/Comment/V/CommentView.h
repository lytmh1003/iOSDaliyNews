//
//  CommentView.h
//  DaliyNews
//
//  Created by 李育腾 on 2022/10/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol commentDelegate <NSObject>

- (void)returnToWebView:(UIButton*)button;

@end
@interface CommentView : UIView<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UILabel* labelCommentSum;
@property (nonatomic, strong) UIButton* buttonReturn;
@property (nonatomic, strong) id<commentDelegate> delegate;
@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSDictionary* webShortCommentDict;
@property (nonatomic, strong) NSDictionary* webLongCommentDict;
@property (nonatomic, strong) NSMutableArray* LongHeightArray;
@property (nonatomic, strong) NSMutableArray* shortHeightArray;
@property (nonatomic, strong) NSMutableArray* shortFlagArray;
@property (nonatomic, strong) NSMutableArray* longFlagArray;
- (void)initView;
@end

NS_ASSUME_NONNULL_END
