//
//  collectionView.m
//  DaliyNews
//
//  Created by 李育腾 on 2022/10/13.
//
#define returnMax 30
#import "collectionView.h"
#import "Masonry.h"
#import "collectionTableViewCell.h"
#import "UIImageView+WebCache.h"
#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height
@implementation collectionView
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
    _labelTitle.text = @"My Collection";
    _labelTitle.font = [UIFont systemFontOfSize:21];
    [self addSubview:_labelTitle];
    [_labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(63);
        make.left.equalTo(self).offset(147);
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
    _lastLabel = [[UILabel alloc] init];
    _lastLabel.text = @"没有更多内容";
    _lastLabel.textColor = [UIColor grayColor];
    _lastLabel.font = [UIFont systemFontOfSize:18];
    _lastLabel.textAlignment = NSTextAlignmentCenter;
    
    _blankLabel = [[UILabel alloc] init];
//    _blankLabel.text = @"你还没有收藏喔 ～";
    _blankLabel.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1];
    _blankLabel.textColor = [UIColor grayColor];
    _blankLabel.font = [UIFont systemFontOfSize:22];
    _blankLabel.textAlignment = NSTextAlignmentCenter;
    
    self.collectionTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, Width, Height) style:UITableViewStylePlain];
    self.collectionTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.collectionTableView.dataSource = self;
    self.collectionTableView.delegate = self;
    [self.collectionTableView registerClass:[collectionTableViewCell class] forCellReuseIdentifier:@"collection"];
    [self.collectionTableView registerClass:[UITableViewCell class]
    forCellReuseIdentifier:@"normalCell"];
    [self.collectionTableView registerClass:[UITableViewCell class]
    forCellReuseIdentifier:@"blankCell"];
    [self addSubview:_collectionTableView];
    
}
- (void)pressButton:(UIButton*) button {
    [_delegate returnButton:button];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.collectArray.count == 0) {
        return 1;
    } else {
        if (section == 0) {
            return self.collectArray.count;
        } else {
            return 1;
        }
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.collectArray.count == 0) {
        return 1;
    } else {
        return  2;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.collectArray.count == 0) {
        return Height - 100;
    } else {
        if (indexPath.section == 0) {
            return 120;
        } else {
            return 60;
        }
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.collectArray.count == 0) {
        UITableViewCell* blankCell = [_collectionTableView dequeueReusableCellWithIdentifier:@"blankCell" forIndexPath:indexPath];
        [blankCell.contentView addSubview:_blankLabel];
        [_blankLabel mas_makeConstraints:^(MASConstraintMaker* make) {
            make.top.equalTo(@(0));
            make.left.equalTo(@0);
            make.width.equalTo(@(Width));
            make.bottom.equalTo(@0);
        }];
        return blankCell;
    } else {
        if (indexPath.section == 0) {
            collectionTableViewCell* cell = [self.collectionTableView dequeueReusableCellWithIdentifier:@"collection" forIndexPath:indexPath];
            cell.labelTitle.text = self.collectArray[indexPath.row][@"mainLabel"];
            // 获取图片
            NSString* imageName = [NSString stringWithFormat:@"%@", self.collectArray[indexPath.row][@"imageUrl"]];
            NSURL* urlImage = [NSURL URLWithString:imageName];
            [cell.imageViewMy sd_setImageWithURL:urlImage];
            return cell;
        } else {
            UITableViewCell* normalCell = [_collectionTableView dequeueReusableCellWithIdentifier:@"normalCell" forIndexPath:indexPath];
            normalCell.selectionStyle = UITableViewCellSelectionStyleNone;
            normalCell.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];;
            [normalCell addSubview:_lastLabel];
            [_lastLabel mas_makeConstraints:^(MASConstraintMaker* make) {
                make.top.equalTo(@0);
                make.left.equalTo(@0);
                make.width.equalTo(@(Width));
                make.bottom.equalTo(@0);
            }];
            return normalCell;
        }
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_collectArray.count != 0) {
        if (indexPath.section == 0) {
            [_pushDelegate getPushRow:indexPath.row];
            NSLog(@"%ld", indexPath.row);
        }
    }
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    //1 .删除数据源对应的数据
    [_getDelete getDeleteRow:indexPath.row];
    //2. 数据源更新
    [self.collectionTableView reloadData];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
