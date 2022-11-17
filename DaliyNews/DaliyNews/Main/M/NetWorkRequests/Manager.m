//
//  Manager.m
//  DaliyNews
//
//  Created by 李育腾 on 2022/10/14.
//

#import "Manager.h"
#import "TestModel.h"
#import "ExtraModel.h"
#import "webViewModel.h"
#import "CommentModel.h"
static Manager* manager;
@implementation Manager
+ (instancetype) shareManager {
    if (!manager) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            manager = [[Manager alloc] init];
        });
    }
    return manager;
}
- (void) makeData:(TestSuccedBlock)succeedBlock error:(ErrorBlock)erroeBlock {
    NSString *json = @"https://news-at.zhihu.com/api/4/news/latest";
        json = [json stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSURL *testUrl = [NSURL URLWithString:json];
        NSURLRequest *testRequest = [NSURLRequest requestWithURL:testUrl];
        NSURLSession *testSession = [NSURLSession sharedSession];
        NSURLSessionDataTask *testDataTask = [testSession dataTaskWithRequest:testRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error == nil) {
                TestModel* DataModel = [[TestModel alloc] initWithData:data error:nil];
                succeedBlock(DataModel);
            } else {
                erroeBlock(error);
            }
        }];
    // 任务启动
    [testDataTask resume];
}
- (void)makeBeforeData:(TestSuccedBlock)succeedBlock error:(ErrorBlock)errorBlock Url:(NSString *)url {
    NSString *json = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/news/before/%@", url];
        json = [json stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSURL *testUrl = [NSURL URLWithString:json];
        NSURLRequest *testRequest = [NSURLRequest requestWithURL:testUrl];
        NSURLSession *testSession = [NSURLSession sharedSession];
        NSURLSessionDataTask *testDataTask = [testSession dataTaskWithRequest:testRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error == nil) {
                TestModel* DataModel = [[TestModel alloc] initWithData:data error:nil];
                succeedBlock(DataModel);
            } else {
                errorBlock(error);
            }
        }];
    // 任务启动
    [testDataTask resume];
}
// 评论
- (void)getExtraData:(TestExtraSuccedBlock)succeedBlock error:(ErrorBlock)errorBlock Id:(NSString *)idExtra {
    NSString *json = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/story-extra/%@", idExtra];
        json = [json stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSURL *testUrl = [NSURL URLWithString:json];
        NSURLRequest *testRequest = [NSURLRequest requestWithURL:testUrl];
        NSURLSession *testSession = [NSURLSession sharedSession];
        NSURLSessionDataTask *testDataTask = [testSession dataTaskWithRequest:testRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error == nil) {
                ExtraModel* DataModel = [[ExtraModel alloc] initWithData:data error:nil];
                succeedBlock(DataModel);
            } else {
                errorBlock(error);
            }
        }];
    // 任务启动
    [testDataTask resume];
}
- (void)getShortComments:(TestCommentBlock) succeedBlock error: (ErrorBlock)errorBlock Id:(NSString*) dataString {
    NSString *json = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/story/%@/short-comments", dataString];
        json = [json stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSURL *testUrl = [NSURL URLWithString:json];
        NSURLRequest *testRequest = [NSURLRequest requestWithURL:testUrl];
        NSURLSession *testSession = [NSURLSession sharedSession];
        NSURLSessionDataTask *testDataTask = [testSession dataTaskWithRequest:testRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error == nil) {
                CommentModel* commentModel  = [[CommentModel alloc] initWithData:data error:nil];
    
                succeedBlock(commentModel);
            } else {
                errorBlock(error);
            }
        }];
    // 任务启动
    [testDataTask resume];
}
- (void)getLongComments:(TestCommentBlock)succeedBlock error:(ErrorBlock)errorBlock Id:(NSString *)dataString {
    NSString *json = [NSString stringWithFormat:@"https://news-at.zhihu.com/api/4/story/%@/long-comments", dataString];
        json = [json stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSURL *testUrl = [NSURL URLWithString:json];
        NSURLRequest *testRequest = [NSURLRequest requestWithURL:testUrl];
        NSURLSession *testSession = [NSURLSession sharedSession];
        NSURLSessionDataTask *testDataTask = [testSession dataTaskWithRequest:testRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error == nil) {
                CommentModel* commentModel  = [[CommentModel alloc] initWithData:data error:nil];
                succeedBlock(commentModel);
            } else {
                errorBlock(error);
            }
        }];
    // 任务启动
    [testDataTask resume];
}
@end
