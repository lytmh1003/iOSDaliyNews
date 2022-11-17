//
//  MainViewController.m
//  DaliyNews
//
//  Created by 李育腾 on 2022/10/12.
//

#import "MainViewController.h"
#import "MainModel.h"
#import "MainView.h"
#import "personViewController.h"
#import "Manager.h"
#import "webViewController.h"

@interface MainViewController ()
- (void) testData;
- (void) getBeforeData;
@property (nonatomic, strong) NSDictionary* dictionaryData;
@property (nonatomic, strong) MainView* mainView;
@property (nonatomic, strong) NSString* beforeString;
@property (nonatomic, assign) int mainDataBefore;
@property (nonatomic, strong) webViewController* webViewC;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    // 字典存到数组li1
    _allArray = [[NSMutableArray alloc] init];
    _allBeforeArray = [[NSMutableArray alloc]init];
    _dictionaryData = [[NSDictionary alloc] init];
    _mainView = [[MainView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _mainDataBefore = 0;
    self.mainView.arrayBefore = [[NSMutableArray alloc] init];
    [self testData];
    _mainView.delegate = self;
    _mainView.delegateBefore = self;
    _mainView.delegateCell = self;
    [self.mainView initView];
    [self.view addSubview:_mainView];
    
}
- (void)returnButton:(UIButton *)button {
//- (void)returnButton {
    NSLog(@"FUCK");
    personViewController* personVIewC = [[personViewController alloc] init];
    personVIewC.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:personVIewC animated:YES];
}
- (void)retutnImageTag:(NSInteger)nowTag {
    _webViewC = [[webViewController alloc] init];
    _webViewC.nowPage = nowTag;
    // top
    _webViewC.allArray = _allArray;
    // section = 1 and section = 2
    _webViewC.allBeforeArray = _allBeforeArray;
    // 获取当前ID
    if (nowTag < 5) {
        _webViewC.extraID = _allArray[0][@"top_stories"][nowTag][@"id"];
    }
    // 过去的新闻id nowTag / 7 和 nowTag % 7分别代表组数和具体的下标
    else {
        _webViewC.extraID = _allBeforeArray[(nowTag - 5) / 6][@"stories"][(nowTag - 5) % 6][@"id"];
    }
    [self.navigationController pushViewController:_webViewC animated:YES];
}
- (void)testData {
    [[Manager shareManager]makeData:^(TestModel * _Nonnull ViewModel) {
        self.mainView.data = [ViewModel toDictionary];
        [self->_allArray addObject:[ViewModel toDictionary]];
        [self->_allBeforeArray addObject:[ViewModel toDictionary]];
        dispatch_async(dispatch_get_main_queue(), ^{
//            [self.mainView initView];
            [self.mainView.tableView reloadData];
        });
    } error:^(NSError * _Nonnull error) {
        NSLog(@"请求失败");
    }];
}

- (void)getBeforeData {
    NSDate *senddate = [NSDate dateWithTimeIntervalSinceNow: - 24 * 3600 * (self->_mainDataBefore - 1)];
    NSCalendar* cal = [NSCalendar  currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear;
    NSDateComponents * conponent= [cal components:unitFlags fromDate:senddate];
    NSInteger year = [conponent year];
    NSInteger month = [conponent month];
    NSInteger day = [conponent day];
    self->_beforeString = [NSString stringWithFormat:@"%ld%02ld%02ld", year, month, day];
    if ([self.beforeString isEqualToString:@"20221027"]) {
        self.beforeString = [NSString stringWithFormat:@"20220824"];
    }
    [[Manager shareManager] makeBeforeData:^(TestModel * _Nonnull ViewModel) {
        NSLog(@"BeforeSucceed");
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.mainView.arrayBefore addObject:[ViewModel toDictionary]];
            [self.allBeforeArray addObject:[ViewModel toDictionary]];
            if (self.mainView.arrayBefore.count >= self->_mainDataBefore) {
                self.mainView.dataBefore++;
                [self.mainView.tableView reloadData];
            } else {
                self.mainView.dataBefore = self->_mainDataBefore;
            }
            NSLog(@"qqqq%ld", self.mainView.arrayBefore.count);
        });
    } error:^(NSError * _Nonnull error) {
        NSLog(@"Before请求失败!");
    } Url:_beforeString];
}
- (void)returnDatabefore:(int)dataBefore {
    _mainDataBefore++;
    [self getBeforeData];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */



@end
