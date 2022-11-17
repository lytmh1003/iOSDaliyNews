//
//  CommentViewController.m
//  DaliyNews
//
//  Created by 李育腾 on 2022/10/27.
//

#import "CommentViewController.h"
#import "CommentView.h"
#import "Manager.h"
#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height
@implementation CommentViewController
- (void)viewDidLoad {
    _commentView = [[CommentView alloc] initWithFrame:CGRectMake(0, 0, Width, Height)];
    _commentView.backgroundColor = [UIColor whiteColor];
    
    [self getShortComment];
//    [self.commentView initView];
    _commentView.delegate = self;
    [self.view addSubview:_commentView];
}
- (void)returnToWebView:(UIButton *)button {
    if (button.tag == 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)getShortComment {
    [[Manager shareManager] getShortComments:^(CommentModel * _Nonnull CommentModel) {
        NSDictionary* shortCommentDict = [CommentModel toDictionary];
        self->_commentView.webShortCommentDict = shortCommentDict;
        NSLog(@"ShortcommentSucceed");
        dispatch_async(dispatch_get_main_queue(), ^{
            [self getLongComment];
//            [self.commentView.tableView reloadData];
           
        });
    } error:^(NSError * _Nonnull error) {
        ;
    } Id:_extraID];
}
- (void)getLongComment {
    [[Manager shareManager] getLongComments:^(CommentModel * _Nonnull CommentModel) {
        NSDictionary* LongCommentDict = [CommentModel toDictionary];
        self->_commentView.webLongCommentDict = LongCommentDict;
        NSLog(@"LongcommentSucceed");
        dispatch_async(dispatch_get_main_queue(), ^{
            [self->_commentView initView];
//            [self getShortComment];
        });
    } error:^(NSError * _Nonnull error) {
        ;
    } Id:_extraID];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
