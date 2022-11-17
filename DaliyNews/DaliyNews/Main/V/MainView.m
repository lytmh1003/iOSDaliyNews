//
//  MainView.m
//  DaliyNews
//
//  Created by 李育腾 on 2022/10/12.
//

#import "MainView.h"
#define MaxSize 42
#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height
#import "Masonry.h"
#import "TableViewCellTop.h"
#import "TableViewCellToday.h"
#import "TableViewCellPast.h"
#import "UIImageView+WebCache.h"
#import "TableViewCellTime.h"

@interface MainView () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (nonatomic, strong) UILabel* labelMonth;
@property (nonatomic, strong) UILabel* labelDay;
@property (nonatomic, strong) UILabel* labelTitle;
@property (nonatomic, strong) UIView* viewShu;
@property (nonatomic, strong) UIButton* buttonMyself;
@property (nonatomic, strong) NSArray* arrayMonth;
@property (nonatomic, strong) NSMutableArray* arrayTitle;
@property (nonatomic, strong) NSMutableArray* arraySmall;
@end


@implementation MainView
- (void) initView {
    _dataBefore = 0;
    self.backgroundColor = [UIColor whiteColor];
    _arrayMonth = [NSArray arrayWithObjects:@"一月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月", @"九月", @"十月", @"十一月", @"十二月", nil];
    
    // 日期-day
    _labelDay = [[UILabel alloc] init];
    _labelDay.font = [UIFont systemFontOfSize:25];
    [self addSubview:_labelDay];
    [_labelDay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(60);
        make.left.equalTo(self).offset(25);
        make.width.equalTo(@50);
        make.height.equalTo(@30);
    }];
    
    // 日期-Month
    _labelMonth = [[UILabel alloc] init];
    _labelMonth.font = [UIFont systemFontOfSize:15];
    [self addSubview:_labelMonth];
    [_labelMonth mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(67);
        make.left.equalTo(self).offset(25);
        make.width.equalTo(@80);
        make.height.equalTo(@70);
    }];
    
    // title
    _labelTitle = [[UILabel alloc] init];
    _labelTitle.text = @"知乎日报";
    _labelTitle.font = [UIFont systemFontOfSize:25];
    [self addSubview:_labelTitle];
    [_labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(50);
        make.left.equalTo(self).offset(90);
        make.width.equalTo(@140);
        make.height.equalTo(@70);
    }];
    
    // 竖直杠
    _viewShu = [[UIView alloc] init];
    _viewShu.backgroundColor = [UIColor grayColor];
    [self addSubview:_viewShu];
    [_viewShu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(62);
        make.left.equalTo(self).offset(74);
        make.width.equalTo(@1);
        make.height.equalTo(@48);
    }];
    
    // 头像
    _buttonMyself = [[UIButton alloc] init];
    [_buttonMyself setImage:[UIImage imageNamed:@"IMG_2400.JPG"] forState:UIControlStateNormal];
    _buttonMyself.layer.borderWidth = 2.0;
    _buttonMyself.layer.cornerRadius = MaxSize / 2;
    _buttonMyself.layer.masksToBounds = YES;
    [_buttonMyself addTarget: self action:@selector(PressButton:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_buttonMyself];
    [_buttonMyself mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(63);
        make.right.equalTo(self).offset(-15);
        make.width.equalTo(@MaxSize);
        make.height.equalTo(@MaxSize);
    }];
    [self Data];
    _tableView = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStylePlain];
    [self addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(120);
        make.left.equalTo(self).offset(0);
        make.width.equalTo(@(Width));
        make.height.equalTo(@(Height - 100));
    }];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tag = 777;
    [_tableView registerClass:[TableViewCellTop class] forCellReuseIdentifier:@"top"];
    [_tableView registerClass:[TableViewCellToday class] forCellReuseIdentifier:@"today"];
    [_tableView registerClass:[TableViewCellPast class] forCellReuseIdentifier:@"past"];
    [_tableView registerClass:[TableViewCellTime class] forCellReuseIdentifier:@"time"];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"load"];
    [_tableView reloadData];
//    self.tableView.separatorInset = UITableViewCellSeparatorStyleNone;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleLarge)];
    //设置小菊花的frame
    self.activityIndicator.frame = CGRectMake(Width / 2, 20, 15, 15);
    //设置小菊花颜色
    self.activityIndicator.color = [UIColor blackColor];
    //设置背景颜色
    self.activityIndicator.backgroundColor = [UIColor clearColor];
    //刚进入这个界面会显示控件，并且停止旋转也会显示，只是没有在转动而已，没有设置或者设置为YES的时候，刚进入页面不会显示
    self.activityIndicator.hidesWhenStopped = YES;
}
/**
 更新时间
 */
- (void) Data {
    //获得系统时间
    NSDate *  senddate=[NSDate date];
    //获得系统日期
    NSCalendar  * cal=[NSCalendar  currentCalendar];
    NSUInteger  unitFlags= NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear;
    NSDateComponents * conponent= [cal components:unitFlags fromDate:senddate];
//    NSInteger year=[conponent year];
    NSInteger month = [conponent month];
    NSInteger day = [conponent day];
    NSString* day1 = [NSString stringWithFormat:@"%ld", (NSInteger)day];
    _labelDay.text = day1;
    NSString* month1 = _arrayMonth[month - 1];
    _labelMonth.text = month1;
}
- (void)PressButton:(UIButton*) button {
    NSLog(@"main");
    [_delegate returnButton:button];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return  1;
    } else if (section == 1){
        return 6;
    } else if (section == 2){
        return (7 * _dataBefore);
    } else {
        return 1;
    }
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIColor* newGray = [UIColor colorWithRed:222.0f/255.0f green:230.0f/255.0f blue:238.0f/255.0f alpha:1.0f];
    if (indexPath.section == 0) {
        TableViewCellTop* topCell = [self.tableView dequeueReusableCellWithIdentifier:@"top"];
        for (int i = 0; i < 7; i++) {
            UIImageView* _imageViewCurrent = [[UIImageView alloc] init];
            _imageViewCurrent.frame = CGRectMake(Width * i, 0, Width, Width);
            [topCell.scrollview addSubview:_imageViewCurrent];
            _imageViewCurrent.tag = i;
            // image点击事件
            // 设置tag 值
            [_imageViewCurrent setUserInteractionEnabled: YES];
            [_imageViewCurrent addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pressImage:)]];
            _imageViewCurrent.tag = i;
            
            UILabel* _labelTitle = [[UILabel alloc] init];
            _labelTitle = [[UILabel alloc] init];
            _labelTitle.font = [UIFont systemFontOfSize:24];
            _labelTitle.numberOfLines = 0;
            _labelTitle.textColor = [UIColor whiteColor];
            _labelTitle.frame = CGRectMake(12 + Width * i, 300, Width * 3 / 4, 60);
            [topCell.scrollview addSubview:_labelTitle];
            
            UILabel* _labelSmall = [[UILabel alloc] init];
            _labelSmall = [[UILabel alloc] init];
            _labelSmall.font = [UIFont systemFontOfSize:17];
            _labelSmall.numberOfLines = 0;
            _labelSmall.textColor = [UIColor grayColor];
            _labelSmall.frame = CGRectMake(12 + Width * i, 370, Width / 4 * 3, 20);
            _labelSmall.textColor = newGray;
            [topCell.scrollview addSubview:_labelSmall];
            
            if (i > 0 && i < 6) {
                NSString* imageName = [NSString stringWithFormat:@"%@", _data[@"top_stories"][i - 1][@"image"]];
                NSURL* urlImage = [NSURL URLWithString:imageName];
                _labelTitle.text = _data[@"top_stories"][i - 1][@"title"];
//                _labelTitle.text = @"写的轮播图是个锤子";
                _labelSmall.text = _data[@"top_stories"][i - 1][@"hint"];
                [_imageViewCurrent sd_setImageWithURL:urlImage];
            } else if (i == 0) {
                _labelTitle.text = _data[@"top_stories"][4][@"title"];
//                _labelTitle.text = @"写的轮播图是个锤子";
                _labelSmall.text = _data[@"top_stories"][4][@"hint"];
                NSString* imageName = [NSString stringWithFormat:@"%@", _data[@"top_stories"][4][@"image"]];
                NSURL* urlImage = [NSURL URLWithString:imageName];
                [_imageViewCurrent sd_setImageWithURL:urlImage];
            } else if (i == 6) {
                _labelTitle.text = _data[@"top_stories"][0][@"title"];
//                _labelTitle.text = @"写的轮播图是个锤子";
                _labelSmall.text = _data[@"top_stories"][0][@"hint"];
                NSString* imageName = [NSString stringWithFormat:@"%@", _data[@"top_stories"][0][@"image"]];
                NSURL* urlImage = [NSURL URLWithString:imageName];
                [_imageViewCurrent sd_setImageWithURL:urlImage];
            }
        }
        return topCell;
    } else if (indexPath.section == 1) {
        TableViewCellToday* cellToday = [self.tableView dequeueReusableCellWithIdentifier:@"today"];
        cellToday.labelTitle.text = _data[@"stories"][indexPath.row][@"title"];
        cellToday.labelSmall.text = _data[@"stories"][indexPath.row][@"hint"];
        // 获取图片
        NSString* imageName = [NSString stringWithFormat:@"%@", _data[@"stories"][indexPath.row][@"images"][0]];
        NSURL* urlImage = [NSURL URLWithString:imageName];
        [cellToday.imageViewMy sd_setImageWithURL:urlImage];
        return cellToday;
    } else if (indexPath.section == 2){
        if (indexPath.row % 7 == 0) {
            // 获取当天日期的时间
            NSDate *senddate = [NSDate dateWithTimeIntervalSinceNow: - 24 * 3600 * (indexPath.row / 7 + 1)];
            NSCalendar  *cal = [NSCalendar  currentCalendar];
            NSUInteger  unitFlags = NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear;
            
            NSDateComponents *conponent = [cal components:unitFlags fromDate:senddate];
            NSInteger month = [conponent month];
            NSInteger day = [conponent day];
            NSString* time = [NSString stringWithFormat:@"%02ld月%02ld日", month, day];
            TableViewCellTime* timeCell = [self.tableView dequeueReusableCellWithIdentifier:@"time"];
            timeCell.labelTime.text = time;
            return timeCell;
        } else {
            TableViewCellPast* cellPast = [self.tableView dequeueReusableCellWithIdentifier:@"past"];
            cellPast.labelTitle.text = _arrayBefore[indexPath.row / 7 ][@"stories"][indexPath.row % 7 - 1][@"title"];
            cellPast.labelSmall.text = _arrayBefore[indexPath.row / 7 ][@"stories"][indexPath.row % 7 - 1][@"hint"];
//             获取图片
            NSString* imageName = [NSString stringWithFormat:@"%@", _arrayBefore[indexPath.row / 7][@"stories"][indexPath.row % 7 - 1][@"images"][0]];
            NSURL* urlImage = [NSURL URLWithString:imageName];
            [cellPast.imageViewMy sd_setImageWithURL:urlImage placeholderImage:[UIImage imageNamed:@"IMG_2400.JPG"] options:SDWebImageRefreshCached];
            
            return cellPast;
        }
    } else {
        // 加载View
        UITableViewCell* loadCell = [_tableView dequeueReusableCellWithIdentifier:@"load"];
        [self.activityIndicator startAnimating];
        [loadCell addSubview:_activityIndicator];
        return loadCell;
    }
    return  0;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return Width;
    } else if (indexPath.section == 1) {
        return 120;
    } else if (indexPath.section == 2) {
        if (indexPath.row % 7 == 0) {
            return 30;
        } else {
            return 120;
        }
    } else {
        return 100;
    }
}

// DidEndDragging Dragging 拖动

//DidEndDecelerating  Decelerating 减速
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
//    if (scrollView.tag == 777) {
//        CGFloat height = scrollView.bounds.size.height;
//        CGFloat contentOffsetY = scrollView.contentOffset.y;
//        CGFloat bottomOffset = scrollView.contentSize.height - contentOffsetY;
//        if (bottomOffset <= 1 * height) {
//            [_delegateBefore returnDatabefore:_dataBefore];//
//        }
//    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.tag == 777) {
        CGFloat height = scrollView.bounds.size.height;
        CGFloat contentOffsetY = scrollView.contentOffset.y;
        CGFloat bottomOffset = scrollView.contentSize.height - contentOffsetY;
        if (bottomOffset <= 1 * height) {
            [_delegateBefore returnDatabefore:_dataBefore];//
        }
    }
}
//添加点击事件
// 上方的imageVIew
- (void)pressImage:(UITapGestureRecognizer*)gesTrueRecognizer {
    NSInteger nowTag = gesTrueRecognizer.view.tag;
    if (nowTag == 0) {
        [_delegateCell retutnImageTag:4];
    } else if (nowTag == 6) {
        [_delegateCell retutnImageTag:0];
    } else {
        [_delegateCell retutnImageTag:nowTag - 1];
    }
}
// 下方的tableViewcell

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1 || (indexPath.section == 2 && (indexPath.row % 7 != 0))) {
        if (indexPath.section == 1) {
            NSInteger nowCell = indexPath.row + 5;
            [_delegateCell retutnImageTag:nowCell];
            NSLog(@"sectionOne nowCell = %ld", nowCell);
        } else {
            NSInteger nowCell = (indexPath.row / 7 + 1) * 6 + indexPath.row % 7 + 4;
            [_delegateCell retutnImageTag:nowCell];
            NSLog(@"sectionTwo nowCell = %ld", nowCell);
        }
    }
}


@end
