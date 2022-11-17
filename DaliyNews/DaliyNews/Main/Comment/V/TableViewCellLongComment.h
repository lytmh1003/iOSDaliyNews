//
//  TableViewCellLongComment.h
//  DaliyNews
//
//  Created by 李育腾 on 2022/10/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableViewCellLongComment : UITableViewCell
// 七个label
@property (nonatomic, strong) UILabel* labelCommentSum;
@property (nonatomic, strong) UILabel* labelUserName;

@property (nonatomic, strong) UILabel* labelUserComment;

@property (nonatomic, strong) UILabel* labelUserReplayComment;

@property (nonatomic, strong) UILabel* labelReplayTime;

@property (nonatomic, strong) UILabel* labelGood;
@property (nonatomic, strong) UILabel* labelReply;
//
@property (nonatomic, strong) UIImageView* buttonMyself;
@property (nonatomic, strong) UIButton* buttonGood;
@property (nonatomic, strong) UIButton* buttonCollection;
@property (nonatomic, strong) UIButton* buttonMore;
@property (nonatomic, strong) UIButton* buttonOpen;
@end

NS_ASSUME_NONNULL_END
