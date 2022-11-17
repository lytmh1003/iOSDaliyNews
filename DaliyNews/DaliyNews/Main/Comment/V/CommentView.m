//
//  CommentView.m
//  DaliyNews
//
//  Created by 李育腾 on 2022/10/27.
//

#import "CommentView.h"
#define returnMax 30
#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height
#import <Masonry.h>
#import "TableViewCellLongComment.h"
#import "TableViewCellLongLongComment.h"
#import <UIImageView+WebCache.h>
@implementation CommentView
- (void)initView {
    self.backgroundColor = [UIColor whiteColor];
    _buttonReturn = [[UIButton alloc] init];
    [_buttonReturn setImage:[UIImage imageNamed:@"fanhui.png"] forState:UIControlStateNormal];
    [_buttonReturn addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_buttonReturn];
    _buttonReturn.tag = 1;
    [_buttonReturn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(63);
        make.left.equalTo(self).offset(15);
        make.width.equalTo(@returnMax);
        make.height.equalTo(@returnMax);
    }];
    
    _labelCommentSum = [[UILabel alloc] init];
    NSString* sumComment = [NSString stringWithFormat:@"%ld条评论", [_webLongCommentDict[@"comments"]count] + [_webShortCommentDict[@"comments"]count]];
    _labelCommentSum.text = sumComment;
    _labelCommentSum.font = [UIFont systemFontOfSize:21];
    [self addSubview:_labelCommentSum];
    [_labelCommentSum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(63);
        make.left.equalTo(self).offset(161);
        make.width.equalTo(@150);
        make.height.equalTo(@returnMax);
    }];
    _tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
    [self addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(120);
        make.left.equalTo(self).offset(0);
        make.width.equalTo(@(Width));
        make.height.equalTo(@(Height - 120));
    }];
    [self initHeight];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tag = 777;
    // 自适应
    [_tableView registerClass:[TableViewCellLongComment class] forCellReuseIdentifier:@"Comment"];
    [_tableView registerClass:[TableViewCellLongLongComment class] forCellReuseIdentifier:@"LongComment"];
    
    // 返回的cell不是整数就会出现边界线
    // 设置去除所有的边界线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // buttonFlag
    // 点击评论是否展开
    _longFlagArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [_webLongCommentDict[@"comments"] count]; i++) {
        [_longFlagArray addObject:@"0"];
    }
    _shortFlagArray= [[NSMutableArray alloc] init];
    for (int i = 0; i < [_webShortCommentDict[@"comments"] count]; i++) {
        [_shortFlagArray addObject:@"0"];
    }
}
- (void)initHeight {
    _LongHeightArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [_webLongCommentDict[@"comments"] count]; i++) {
        UILabel* longLabel = [[UILabel alloc] init];
        longLabel.text = _webLongCommentDict[@"comments"][i][@"content"];
        CGSize lblSize = [longLabel.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 80, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
//        NSLog(@"Size.Height = %f", lblSize.height + 120);
        NSString* height = [NSString stringWithFormat:@"%f", lblSize.height + 120];
        [_LongHeightArray addObject:height];
    }
    _shortHeightArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [_webShortCommentDict[@"comments"] count]; i++) {
        UILabel* longLabel = [[UILabel alloc] init];
        longLabel.text = _webShortCommentDict[@"comments"][i][@"content"];
        CGSize lblSize = [longLabel.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 80, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
//        NSLog(@"Size.Height = %f", lblSize.height + 120);
        NSString* height = [NSString stringWithFormat:@"%f", lblSize.height + 120];
        [_shortHeightArray addObject:height];
    }
}
- (void)pressButton:(UIButton*)button {
    [_delegate returnToWebView:button];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        if (_shortHeightArray.count != 0) {
            return 1;
        }
    }else if (section == 2) {
        if (_LongHeightArray.count != 0) {
            return 1;
        }
    } else if (section == 1){
//        NSLog(@"Short = %ld", [_webShortCommentDict[@"comments"] count]);
        return [_webShortCommentDict[@"comments"] count];
    } else {
//        NSLog(@"Long = %ld", [_webLongCommentDict[@"comments"] count]);
        return [_webLongCommentDict[@"comments"] count];
    }
    return 0 ;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 || indexPath.section == 2) {
        return 30;
    } else if (indexPath.section == 1) {
        if (_webShortCommentDict[@"comments"][indexPath.row][@"reply_to"] != nil) {
            if ([_shortFlagArray[indexPath.row] isEqual:@"0"]) {
                return ([_shortHeightArray[indexPath.row] doubleValue] + 80);
            } else {
                NSString* longReply = _webShortCommentDict[@"comments"][indexPath.row][@"reply_to"][@"content"];
                CGSize lblSize = [longReply boundingRectWithSize:CGSizeMake(Width * 0.61, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
                return ([_shortHeightArray[indexPath.row] doubleValue] + lblSize.height + 80);
            }
        } else {
            return ([_shortHeightArray[indexPath.row] doubleValue]);
        }
    } else {
        if (_webLongCommentDict[@"comments"][indexPath.row][@"reply_to"] != nil) {
            if ([_longFlagArray[indexPath.row] isEqual:@"0"]) {
                return ([_LongHeightArray[indexPath.row] doubleValue] + 80);
            } else {
                NSString* longReply =  _webLongCommentDict[@"comments"][indexPath.row][@"reply_to"][@"content"];
                CGSize lblSize = [longReply boundingRectWithSize:CGSizeMake(Width * 0.61, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
                return ([_LongHeightArray[indexPath.row] doubleValue] + lblSize.height + 80);
            }
        } else {
            return ([_LongHeightArray[indexPath.row] doubleValue]);
        }
    }
    return 0;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NSString* str = @"cellNum";
        UITableViewCell* cell = [_tableView dequeueReusableCellWithIdentifier:str];
        if(cell == nil) {
            cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
            cell.textLabel.text = [NSString stringWithFormat:@"%ld条短评", [_webShortCommentDict[@"comments"] count]];
        }
        return cell;
    } else if (indexPath.section == 1) {
        TableViewCellLongComment* commentCell = [self.tableView dequeueReusableCellWithIdentifier:@"Comment"];
        commentCell.labelUserName.text = _webShortCommentDict[@"comments"][indexPath.row][@"author"];
        commentCell.labelUserComment.text =  _webShortCommentDict[@"comments"][indexPath.row][@"content"];
        commentCell.labelGood.text = [NSString stringWithFormat:@"%@" ,_webShortCommentDict[@"comments"][indexPath.row][@"likes"]];
        NSString* imageName = [NSString stringWithFormat:@"%@", _webShortCommentDict[@"comments"][indexPath.row][@"avatar"]];
        NSURL* urlImage = [NSURL URLWithString:imageName];
        [commentCell.buttonMyself sd_setImageWithURL:urlImage placeholderImage:[UIImage imageNamed:@"IMG_2400.JPG"] options:SDWebImageRefreshCached];
        // 回复的回复
        commentCell.buttonOpen.tag = indexPath.row;
        if (_webShortCommentDict[@"comments"][indexPath.row][@"reply_to"] != nil) {
            NSString *replyTo = [NSString stringWithFormat:@"//%@:%@", _webShortCommentDict[@"comments"][indexPath.row][@"reply_to"][@"author"],_webShortCommentDict[@"comments"][indexPath.row][@"reply_to"][@"content"]];
            commentCell.labelReply.text = replyTo;
            // 回复的回复长度大于一定高度，展示Button
            commentCell.buttonOpen.selected = [_shortFlagArray[indexPath.row] intValue];
            CGSize lblSize = [commentCell.labelReply.text boundingRectWithSize:CGSizeMake(Width * 0.61, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
            if (lblSize.height > 30) {
                [commentCell.buttonOpen addTarget:self action:@selector(pressShortOpen:) forControlEvents:UIControlEventTouchUpInside];
                commentCell.buttonOpen.tintColor = [UIColor grayColor];
                if ([_shortFlagArray[indexPath.row] isEqualToString:@"1"]) {
                    commentCell.labelReply.numberOfLines = 0;
                } else {
                    commentCell.labelReply.numberOfLines = 2;
                }
            } else {
                commentCell.buttonOpen.tintColor = [UIColor clearColor];
                [commentCell.buttonOpen setTitle:@"" forState:UIControlStateNormal];
            }
        } else {
            commentCell.labelReply.text = @"";
            commentCell.buttonOpen.tintColor = [UIColor clearColor];
        }
        //如何将数字时间转化为正常时间
        NSString* time = [NSString stringWithFormat:@"%@", _webShortCommentDict[@"comments"][indexPath.row][@"time"]];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"MM-dd HH:mm"];
        NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[time intValue]];
        NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
        commentCell.labelReplayTime.text = confromTimespStr;
        
        return commentCell;
    } else if (indexPath.section == 2) {
        NSString* str = @"cellLongNum";
        UITableViewCell* cell = [_tableView dequeueReusableCellWithIdentifier:str];
        if(cell == nil) {
            cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
            cell.textLabel.text = [NSString stringWithFormat:@"%ld条长评", [_webLongCommentDict[@"comments"] count]];
        }
        return cell;
    } else {
        // 长评论
        TableViewCellLongLongComment* commentCell = [self.tableView dequeueReusableCellWithIdentifier:@"LongComment"];
        commentCell.labelUserName.text = _webLongCommentDict[@"comments"][indexPath.row][@"author"];
        commentCell.labelUserComment.text =  _webLongCommentDict[@"comments"][indexPath.row][@"content"];
        // 回复的回复
        if (_webLongCommentDict[@"comments"][indexPath.row][@"reply_to"] != nil) {
            NSString *replyTo = [NSString stringWithFormat:@"//%@:%@", _webLongCommentDict[@"comments"][indexPath.row][@"reply_to"][@"author"], _webLongCommentDict[@"comments"][indexPath.row][@"reply_to"][@"content"]];
            commentCell.labelReply.text = replyTo;
            // 回复的回复长度大于一定高度，展示Button
            CGSize lblSize = [commentCell.labelReply.text boundingRectWithSize:CGSizeMake(Width * 0.61, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
            if (lblSize.height > 30) {
                commentCell.buttonOpen.tintColor = [UIColor grayColor];
                [commentCell.buttonOpen addTarget:self action:@selector(pressLongOpen:) forControlEvents:UIControlEventTouchUpInside];
                if ([_longFlagArray[indexPath.row] isEqual:@"1"]) {
                    commentCell.labelReply.numberOfLines = 0;
                }
            } else {
                [commentCell.buttonOpen setTitle:@"" forState:UIControlStateNormal];
            }
//            NSLog(@"LongReplySizeHeight = %f", lblSize.height);
        }  else {
            commentCell.labelReply.text = @"";
            commentCell.buttonOpen.tintColor = [UIColor clearColor];
        }
        commentCell.labelGood.text = [NSString stringWithFormat:@"%@" ,_webLongCommentDict[@"comments"][indexPath.row][@"likes"]];
        NSString* imageName = [NSString stringWithFormat:@"%@", _webLongCommentDict[@"comments"][indexPath.row][@"avatar"]];
        NSURL* urlImage = [NSURL URLWithString:imageName];
        [commentCell.buttonMyself sd_setImageWithURL:urlImage placeholderImage:[UIImage imageNamed:@"IMG_2400.JPG"] options:SDWebImageRefreshCached];
        
        //如何将数字时间转化为正常时间
        NSString* time = [NSString stringWithFormat:@"%@", _webLongCommentDict[@"comments"][indexPath.row][@"time"]];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"MM-dd HH:mm"];
        NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:(NSTimeInterval)[time intValue]];
        NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
        commentCell.labelReplayTime.text = confromTimespStr;
        return commentCell;
    }
    return 0;
}
- (void)pressLongOpen:(UIButton *) button {
    NSLog(@"Long.tag = %ld", button.tag);
    if ([_longFlagArray[button.tag] isEqualToString: @"0"]) {
        _longFlagArray[button.tag] = [NSString stringWithFormat:@"1"];
        //button.backgroundColor = [UIColor whiteColor];
        //button.tintColor = [UIColor grayColor];
        [button setTitle:@"展开评论" forState:UIControlStateNormal];
    } else  {
        _longFlagArray[button.tag] = [NSString stringWithFormat:@"0"];
        [button setTitle:@"点击收起" forState:UIControlStateNormal];
        //button.backgroundColor = [UIColor whiteColor];
        //button.tintColor = [UIColor grayColor];
    }
    [_tableView reloadData];
}
//- (void)pressShortOpen:(UIButton *) button {
//    if (button.tintColor != [UIColor clearColor]) {
//        if ([_shortFlagArray[button.tag] isEqualToString: @"0"]) {
////            button.selected = YES;
//            NSLog(@"%@", _shortFlagArray[button.tag]);
//            _shortFlagArray[button.tag] = @"1";
//            [button setTitle:@"点击收起" forState:UIControlStateNormal];
//        } else {
////            button.selected = NO;
//            NSLog(@"%@", _shortFlagArray[button.tag]);
//            _shortFlagArray[button.tag] = @"0";
//            [button setTitle:@"展开评论" forState:UIControlStateNormal];
//        }
//    }
////else {
////        [button setTitle:@"" forState:UIControlStateNormal];
////    }
//    [_tableView reloadData];
//}
- (void)pressShortOpen:(UIButton *) button {
    if (button.selected == NO) {
        button.selected = YES;
        _shortFlagArray[button.tag] = @"1";
    } else {
        button.selected = NO;
        _shortFlagArray[button.tag] = @"0";
    }
    [_tableView reloadData];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
