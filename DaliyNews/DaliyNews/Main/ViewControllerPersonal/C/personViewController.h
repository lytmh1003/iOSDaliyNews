//
//  personViewController.h
//  DaliyNews
//
//  Created by 李育腾 on 2022/10/12.
//

#import <UIKit/UIKit.h>
#import "personView.h"
NS_ASSUME_NONNULL_BEGIN

@interface personViewController : UIViewController<buttonDelegate1>
- (void)returnButton:(UIButton *)button;

@end

NS_ASSUME_NONNULL_END
