//
//  collectionView.h
//  DaliyNews
//
//  Created by 李育腾 on 2022/10/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol buttonCollectionDelegate <NSObject>

- (void) returnButton:(UIButton*) button;

@end
@protocol deleteDelegate <NSObject>

- (void)getDeleteRow:(NSInteger)row;

@end
@protocol PushDelegate <NSObject>

- (void)getPushRow:(NSInteger)row;

@end
@interface collectionView : UIView<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UILabel* labelTitle;
@property (nonatomic, strong) UIButton* buttonReturn;
@property (nonatomic, strong) id<buttonCollectionDelegate> delegate;
@property (nonatomic, assign) id<deleteDelegate> getDelete;
@property (nonatomic, assign) id<PushDelegate> pushDelegate;
@property (nonatomic, strong) UITableView* collectionTableView;
@property (nonatomic, strong) NSMutableArray* arrayTitle;
@property (nonatomic, strong) NSMutableArray *collectArray;

@property (nonatomic, strong) UILabel* lastLabel;
@property (nonatomic, strong) UILabel* blankLabel;
- (void) initView;
@end

NS_ASSUME_NONNULL_END
