//
//  Manager.h
//  DaliyNews
//
//  Created by 李育腾 on 2022/10/14.
//

#import <Foundation/Foundation.h>
#import "TestModel.h"
#import "ExtraModel.h"
#import "CommentModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef  void (^TestSuccedBlock) (TestModel* ViewModel);
typedef  void (^TestExtraSuccedBlock) (ExtraModel* ExtraModel);
typedef void (^ErrorBlock) (NSError* error);
typedef void (^TestCommentBlock) (CommentModel* CommentModel);
@interface Manager : NSObject
+ (instancetype) shareManager;
// topdata
- (void) makeData:(TestSuccedBlock) succeedBlock error:(ErrorBlock) errorBlock;
// 之前的新闻

- (void) makeBeforeData:(TestSuccedBlock) succeedBlock error:(ErrorBlock) errorBlock Url:(NSString*) url;
// 评论和点赞
- (void)getExtraData:(TestExtraSuccedBlock) succeedBlock error :(ErrorBlock)errorBlock Id:(NSString*) dataString;
// 长评论
- (void)getLongComments:(TestCommentBlock) succeedBlock error: (ErrorBlock)errorBlock Id:(NSString*) dataString;
// 短评论
- (void)getShortComments:(TestCommentBlock) succeedBlock error: (ErrorBlock)errorBlock Id:(NSString*) dataString;
@end

NS_ASSUME_NONNULL_END

