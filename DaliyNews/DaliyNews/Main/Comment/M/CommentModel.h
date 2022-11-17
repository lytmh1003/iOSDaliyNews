//
//  CommentModel.h
//  DaliyNews
//
//  Created by 李育腾 on 2022/10/27.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN
@protocol commentsModel

@end
@protocol replayModel


@end
// 评论的评论
@interface replayModel: JSONModel
@property (nonatomic, strong) NSString* author;
@property (nonatomic, strong) NSString* content;
@end
@interface commentsModel : JSONModel
@property (nonatomic, strong) NSString* author;
@property (nonatomic, strong) NSString* content;
@property (nonatomic, strong) NSString* avatar;
@property (nonatomic, strong) NSString* time;
@property (nonatomic, strong) NSString* id;
@property (nonatomic, assign) NSInteger likes;
@property (nonatomic, strong) NSDictionary<replayModel>* reply_to;
@end
@interface CommentModel : JSONModel
@property (nonatomic, copy) NSArray<commentsModel>* comments;
@end

NS_ASSUME_NONNULL_END
