//
//  messageCenterView.h
//  DaliyNews
//
//  Created by 李育腾 on 2022/10/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol buttonMessageDelegate <NSObject>

- (void) returnButton:(UIButton*) button;

@end
@interface messageCenterView : UIView
@property (nonatomic, strong) UILabel* labelTitle;
@property (nonatomic, strong) UIButton* buttonReturn;
@property (nonatomic, strong) id<buttonMessageDelegate> delegate;
- (void) initView;
@end

NS_ASSUME_NONNULL_END
