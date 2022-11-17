//
//  TableViewCellTime.m
//  DaliyNews
//
//  Created by 李育腾 on 2022/10/18.
//

#import "TableViewCellTime.h"
#import "Masonry.h"
#define Width   [UIScreen mainScreen].bounds.size.width
@implementation TableViewCellTime

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle: style reuseIdentifier:reuseIdentifier];
    _viewLine = [[UIView alloc] init];
    _viewLine.backgroundColor = [UIColor grayColor];
    [self addSubview:_viewLine];
    
    _labelTime = [[UILabel alloc] init];
    _labelTime.textColor = [UIColor grayColor];
    _labelTime.font = [UIFont systemFontOfSize:17];
    _labelTime.textAlignment = NSTextAlignmentLeft;
    _labelTime.text = @"10月19日";
    [self addSubview:_labelTime];
    return self;
    
}
- (void)layoutSubviews {
    [_labelTime mas_makeConstraints:^(MASConstraintMaker* make) {
        make.top.equalTo(@15);
        make.left.equalTo(@15);
        make.width.equalTo(@(Width * 0.2));
        make.height.equalTo(@34);
    }];
    
    [_viewLine mas_makeConstraints:^(MASConstraintMaker* make) {
        make.top.equalTo(@33);
        make.left.equalTo(@((Width / 5) + 10));
        make.width.equalTo(@((3 * self.frame.size.width / 4) + 10));
        make.height.equalTo(@1);
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
