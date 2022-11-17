//
//  ExtraModel.h
//  DaliyNews
//
//  Created by 李育腾 on 2022/10/25.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExtraModel : JSONModel
@property (nonatomic, assign) int long_comments;
@property (nonatomic, assign) int popularity;
@property (nonatomic, assign) int short_comments;
@property (nonatomic, assign) int comments;
@end

NS_ASSUME_NONNULL_END
