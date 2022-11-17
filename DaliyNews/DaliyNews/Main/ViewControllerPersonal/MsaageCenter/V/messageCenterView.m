//
//  messageCenterView.m
//  DaliyNews
//
//  Created by 李育腾 on 2022/10/13.
//
#define returnMax 30
#import "messageCenterView.h"
#import "Masonry.h"
@implementation messageCenterView
- (void) initView {
    UIColor* newGray = [UIColor colorWithRed:202.0f/255.0f green:203.0f/255.0f blue:206.0f/255.0f alpha:1.0f];
    self.backgroundColor = [UIColor whiteColor];
    _buttonReturn = [[UIButton alloc] init];
    [_buttonReturn setImage:[UIImage imageNamed:@"fanhui.png"] forState:UIControlStateNormal];
    [_buttonReturn addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_buttonReturn];
    _buttonReturn.tag = 3;
    [_buttonReturn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(63);
        make.left.equalTo(self).offset(15);
        make.width.equalTo(@returnMax);
        make.height.equalTo(@returnMax);
    }];
    
    _labelTitle = [[UILabel alloc] init];
    _labelTitle.text = @"Message Center";
    _labelTitle.font = [UIFont systemFontOfSize:21];
    [self addSubview:_labelTitle];
    [_labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(63);
        make.left.equalTo(self).offset(141);
        make.width.equalTo(@150);
        make.height.equalTo(@returnMax);
    }];
    
    UIView* view = [[UIView alloc] init];
    view.backgroundColor = newGray;
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(105);
        make.left.equalTo(self).offset(0);
        make.width.equalTo(@([UIScreen mainScreen].bounds.size.width));
        make.height.equalTo(@1);
    }];
}
- (void)pressButton:(UIButton*) button {
    [_delegate returnButton:button];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
