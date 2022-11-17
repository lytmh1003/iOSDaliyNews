//
//  personView.h
//  DaliyNews
//
//  Created by 李育腾 on 2022/10/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol buttonDelegate1 <NSObject>

- (void)returnButton:(UIButton*) button;

@end
@interface personView : UIView
@property (nonatomic, strong) UIButton* buttonMyself;
@property (nonatomic, strong) UILabel* labelName;
@property (nonatomic, strong) UIButton* buttonReturn;
// 收藏和消息按钮
@property (nonatomic, strong) UIButton* buttonCollection;
@property (nonatomic, strong) UIButton* buttonNext;
// 数组
@property (nonatomic, copy) NSArray* array;
// 横线
@property (nonatomic, strong) UIView* viewHeng;
- (void) initView;
@property (nonatomic, strong) id<buttonDelegate1> delegate;
@end

NS_ASSUME_NONNULL_END
