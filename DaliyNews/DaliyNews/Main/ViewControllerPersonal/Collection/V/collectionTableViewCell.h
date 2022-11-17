//
//  collectionTableViewCell.h
//  DaliyNews
//
//  Created by 李育腾 on 2022/11/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface collectionTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel* labelTitle;
@property (nonatomic, strong) UILabel* labelSmall;
@property (nonatomic, strong) NSString* extraID;
@property (nonatomic, strong) UIImageView* imageViewMy;
@end

NS_ASSUME_NONNULL_END
