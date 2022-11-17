//
//  CommentViewController.h
//  DaliyNews
//
//  Created by 李育腾 on 2022/10/27.
//

#import <UIKit/UIKit.h>
#import "CommentView.h"
NS_ASSUME_NONNULL_BEGIN

@interface CommentViewController : UIViewController<commentDelegate>
- (void)returnToWebView:(UIButton *)button;
@property (nonatomic, strong)CommentView* commentView;
//@property (nonatomic, strong) NSDictionary* webShortCommentDict;
@property (nonatomic, strong) id extraID;
@end

NS_ASSUME_NONNULL_END
