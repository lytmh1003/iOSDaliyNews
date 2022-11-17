//
//  TableViewCellPast.m
//  DaliyNews
//
//  Created by 李育腾 on 2022/10/15.
//

#import "TableViewCellPast.h"
#import "Masonry.h"
#define Width [UIScreen mainScreen].bounds.size.width
@interface TableViewCellPast()

@property (nonatomic, strong) UIView* viewHeng;
@end
@implementation TableViewCellPast
- (instancetype)  initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle: style reuseIdentifier:reuseIdentifier];
    
    _labelTitle = [[UILabel alloc] init];
    _labelTitle.font = [UIFont systemFontOfSize:18];
    _labelTitle.numberOfLines = 0;
    [self addSubview:_labelTitle];
    
    _labelSmall = [[UILabel alloc] init];
    _labelSmall.font = [UIFont systemFontOfSize:13];
    _labelSmall.numberOfLines = 0;
    _labelSmall.textColor = [UIColor grayColor];
    [self addSubview:_labelSmall];

    _imageViewMy = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"IMG_2400.JPG"]];
    [self addSubview:_imageViewMy];
    return  self;
}
- (void) layoutSubviews {
    [_labelTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(20);
        make.left.equalTo(self).offset(12);
        make.width.equalTo(@(Width / 4 * 3));
        make.height.equalTo(@60);
    }];
    [_labelSmall mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(85);
        make.left.equalTo(self).offset(12);
        make.width.equalTo(@(Width / 4 * 3));
        make.height.equalTo(@20);
    }];
    _imageViewMy.layer.masksToBounds = YES;
    _imageViewMy.layer.cornerRadius = 4.0;
    [_imageViewMy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(30);
        make.left.equalTo(self).offset(Width / 4 * 3 + 10);
        make.width.equalTo(@85);
        make.height.equalTo(@85);
    }];
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
