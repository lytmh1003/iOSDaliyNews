//
//  MainViewController.h
//  DaliyNews
//
//  Created by 李育腾 on 2022/10/12.
//

#import "ViewController.h"
#import "MainView.h"
NS_ASSUME_NONNULL_BEGIN

@interface MainViewController : ViewController<buttonDelegate, dataDelegate, cellDelegate>
- (void)returnButton:(UIButton *)button;

- (void)returnDatabefore:(int)dataBefore;
- (void)retutnImageTag:(NSInteger)nowTag;
//- (void)returnRow:(NSInteger)nowRow;
@property (nonatomic, strong)NSMutableArray* allArray;
@property (nonatomic, strong)NSMutableArray* allBeforeArray;
@end

NS_ASSUME_NONNULL_END
