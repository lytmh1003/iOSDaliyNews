//
//  personView.m
//  DaliyNews
//
//  Created by 李育腾 on 2022/10/12.
//
#define MaxSize 85
#define returnMax 30
#import "personView.h"
#import "Masonry.h"
#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height
@implementation personView
- (void) initView {
    UIColor* newGray = [UIColor colorWithRed:202.0f/255.0f green:203.0f/255.0f blue:206.0f/255.0f alpha:1.0f];
    
    _labelName = [[UILabel alloc] init];
    _labelName.font = [UIFont systemFontOfSize:20];
    _labelName.text = @"关于小司(先安慰版)";
    [self addSubview:_labelName];
    [_labelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(220);
        make.left.equalTo(self).offset(120);
        make.width.equalTo(@300);
        make.height.equalTo(@30);
    }];
    
    // 头像
    _buttonMyself = [[UIButton alloc] init];
    [_buttonMyself setImage:[UIImage imageNamed:@"IMG_2400.JPG"] forState:UIControlStateNormal];
    _buttonMyself.layer.borderWidth = 2.0;
    _buttonMyself.layer.cornerRadius = MaxSize / 2;
    _buttonMyself.layer.masksToBounds = YES;
    [self addSubview:_buttonMyself];
    [_buttonMyself mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(120);
        make.left.equalTo(self).offset(170);
        make.width.equalTo(@MaxSize);
        make.height.equalTo(@MaxSize);
    }];
    // 返回
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
    
    // 收藏和消息按钮
    _array = [NSArray arrayWithObjects:@"我的收藏", @"消息中心", nil];
    for (int i = 0; i < 2; i++) {
        UILabel* label  = [[UILabel alloc] init];
        label.text = _array[i];
        label.font = [UIFont systemFontOfSize:18];
        [self addSubview:label];
        label.tintColor = [UIColor blackColor];
//        NSString* buttonString = _array[i];
//        _buttonCollection = [UIButton buttonWithType:UIButtonTypeRoundedRect];
////        [_buttonCollection setTitle:buttonString forState:UIControlStateNormal];
//        _buttonCollection.titleLabel.font = [UIFont systemFontOfSize:18];
//        _buttonCollection.tintColor = [UIColor blackColor];
//        _buttonCollection.tag = i;
//        [_buttonCollection addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
//        [self addSubview:_buttonCollection];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(240 + 60 * (i + 1));
            make.left.equalTo(self).offset(15);
            make.width.equalTo(@(100));
            make.height.equalTo(@40);
        }];
    }
    
    for (int i = 0; i < 2; i++) {
        NSString* buttonString = _array[i];
        _buttonCollection = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        [_buttonCollection setTitle:buttonString forState:UIControlStateNormal];
        _buttonCollection.titleLabel.font = [UIFont systemFontOfSize:18];
        _buttonCollection.tintColor = [UIColor blackColor];
        _buttonCollection.tag = i;
        [_buttonCollection addTarget:self action:@selector(pressButton:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_buttonCollection];
        [_buttonCollection mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(240 + 60 * (i + 1));
            make.left.equalTo(self).offset(10);
            make.width.equalTo(@(Width));
            make.height.equalTo(@40);
        }];
    }
    // 箭头
    for (int i = 0; i < 2; i++) {
        _buttonNext = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _buttonNext.tag = i;
        _buttonNext.titleLabel.font = [UIFont systemFontOfSize:18];
        _buttonNext.tintColor = [UIColor blackColor];
        _buttonNext = [[UIButton alloc] init];
        [_buttonNext setImage:[UIImage imageNamed:@"next-2.png"] forState:UIControlStateNormal];
        _buttonNext.tag = i;
        [_buttonNext addTarget:self action:@selector(pressButton:)
              forControlEvents:UIControlEventTouchUpInside];
//        _buttonNext.tintColor = newGray;
        [self addSubview: _buttonNext];
        [_buttonNext mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(240 + 65 * (i + 1));
            make.right.equalTo(self).offset(-10);
            make.width.equalTo(@20);
            make.height.equalTo(@20);
        }];
    }
    
    // 横线
    for (int i = 0; i < 2; i++) {
        _viewHeng = [[UIView alloc] init];
        _viewHeng.backgroundColor = newGray;
        [self addSubview:_viewHeng];
        
        [_viewHeng mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(230 + 60 * (i + 1));
            make.left.equalTo(self).offset(0);
            make.width.equalTo(@([UIScreen mainScreen].bounds.size.width));
            make.height.equalTo(@1);
        }];
    }
    
}
- (void) pressButton:(UIButton*) button {
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
