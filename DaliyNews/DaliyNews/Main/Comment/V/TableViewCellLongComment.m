//
//  TableViewCellLongComment.m
//  DaliyNews
//
//  Created by 李育腾 on 2022/10/27.
//
#define MaxSize 38
#import "TableViewCellLongComment.h"
#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height
#import <Masonry.h>
@implementation TableViewCellLongComment
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle: style reuseIdentifier:reuseIdentifier];
    // 头像
    _buttonMyself = [[UIImageView alloc] init];
    _buttonMyself.layer.cornerRadius = MaxSize / 2;
    _buttonMyself.layer.masksToBounds = YES;
    [self.contentView addSubview:_buttonMyself];
    
    _labelUserName = [[UILabel alloc] init];
    _labelUserName.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:_labelUserName];
    
    _labelUserComment = [[UILabel alloc] init];
    _labelUserComment.font = [UIFont systemFontOfSize:15];
    _labelUserComment.numberOfLines = 0;
    [self.contentView addSubview:_labelUserComment];
    
    _labelUserReplayComment = [[UILabel alloc] init];
    _labelUserReplayComment.font = [UIFont systemFontOfSize:13];
    _labelUserReplayComment.textColor = [UIColor grayColor];
    [self.contentView addSubview:_labelUserReplayComment];
    
    _labelReply = [[UILabel alloc] init];
    _labelReply.font = [UIFont systemFontOfSize:12];
    _labelReply.textColor = [UIColor grayColor];
    _labelReply.numberOfLines = 2;
    [self.contentView addSubview:_labelReply];
    
    _buttonOpen = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    _buttonOpen.tintColor = [UIColor clearColor];
    
    [_buttonOpen setTitle:@"展开评论" forState:UIControlStateNormal];
    [_buttonOpen setTitle:@"收起评论" forState:UIControlStateSelected];
    [self.contentView addSubview:_buttonOpen];
    
    _labelReplayTime = [[UILabel alloc] init];
    _labelReplayTime.font = [UIFont systemFontOfSize:15];
    _labelReplayTime.textColor = [UIColor grayColor];
    [self.contentView addSubview:_labelReplayTime];
    
    // 点赞数
    _labelGood= [[UILabel alloc] init];
    _labelGood.font = [UIFont systemFontOfSize:15];
    _labelGood.textColor = [UIColor grayColor];
    [self.contentView addSubview:_labelGood];
    
    
    // 点赞和评论按钮
    _buttonGood = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_buttonGood setImage:[UIImage imageNamed:@"dianzan.png"] forState:UIControlStateNormal];
    _buttonGood.tintColor = [UIColor blackColor];
    [self addSubview:_buttonGood];
    _buttonGood.tintColor = [UIColor grayColor];
    _buttonGood.tag = 3;

    _buttonCollection = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_buttonCollection setImage:[UIImage imageNamed:@"pinglun.png"] forState:UIControlStateNormal];
    _buttonCollection.tintColor = [UIColor blackColor];
    _buttonCollection.tintColor = [UIColor grayColor];
    [self addSubview:_buttonCollection];
    _buttonCollection.tag = 4;
    
    _buttonMore = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_buttonMore setImage:[UIImage imageNamed:@"24gf-ellipsis.png"] forState:UIControlStateNormal];
    _buttonMore.tintColor = [UIColor blackColor];
    _buttonMore.tintColor = [UIColor grayColor];
    [self addSubview:_buttonMore];
    _buttonMore.tag = 5;
//
    [_labelUserComment mas_makeConstraints:^(MASConstraintMaker* make) {
        make.top.equalTo([self.contentView mas_top]).offset(65);
        make.left.equalTo(self).offset(30 + (Width * 0.1));
        make.right.equalTo(self).offset(-20);
    }];
    return self;
}
- (void)layoutSubviews {
    [_buttonOpen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo([self.contentView mas_bottom]).offset(-10);
        make.left.equalTo(self).offset(Width * 0.310);
        make.width.equalTo(@120);
        make.height.equalTo(@30);
    }];
    
    [_labelReply mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo([self.contentView mas_bottom]).offset(-80);
        make.left.equalTo(self).offset(30 + (Width * 0.1));
//        make.height.equalTo(@30);
        make.width.equalTo(@(Width * 0.61));
    }];
    [_labelUserName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(30);
        make.left.equalTo(self).offset(Width * 0.163);
        make.width.equalTo(@100);
        make.height.equalTo(@30);
    }];
    [_buttonMyself mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(30);
        make.left.equalTo(self).offset(Width * 0.05);
        make.width.equalTo(@(MaxSize));
        make.height.equalTo(@(MaxSize));
    }];
    
    [_buttonMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(30);
        make.right.equalTo(self).offset( - Width * 0.04);
        make.width.equalTo(@20);
        make.height.equalTo(@20);
    }];
    [_labelReplayTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo([self.contentView mas_bottom]).offset(-10);
        make.left.equalTo(self).offset(Width * 0.163);
        make.width.equalTo(@120);
        make.height.equalTo(@30);
    }];
//    _labelReplayTime.frame = CGRectMake(Width * 0.163, 145, 120, 30);
    [_buttonGood mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo([self.contentView mas_bottom]).offset(-10);
        make.left.equalTo(self).offset(Width * 0.76);
        make.width.equalTo(@24);
        make.height.equalTo(@24);
    }];
//    _buttonGood.frame = CGRectMake(Width * 0.76, 148, 24, 24);
    [_buttonCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo([self.contentView mas_bottom]).offset(-10);
        make.left.equalTo(self).offset(Width * 0.90);
        make.width.equalTo(@21);
        make.height.equalTo(@21);
    }];
//    _buttonCollection.frame = CGRectMake(Width * 0.90, 150, 21, 21);
    [_labelGood mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo([self.contentView mas_bottom]).offset(-10);
        make.left.equalTo(self).offset(Width * 0.716);
        make.width.equalTo(@30);
        make.height.equalTo(@20);
    }];
//    _labelGood.frame = CGRectMake(Width * 0.716, 152, 30, 20);
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
