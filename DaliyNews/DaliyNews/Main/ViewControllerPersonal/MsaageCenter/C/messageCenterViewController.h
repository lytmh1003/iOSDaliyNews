//
//  messageCenterViewController.h
//  DaliyNews
//
//  Created by 李育腾 on 2022/10/13.
//

#import <UIKit/UIKit.h>
#import "messageCenterView.h"
NS_ASSUME_NONNULL_BEGIN

@interface messageCenterViewController : UIViewController<buttonMessageDelegate>
- (void) returnButton:(UIButton *)button;
@end

NS_ASSUME_NONNULL_END
