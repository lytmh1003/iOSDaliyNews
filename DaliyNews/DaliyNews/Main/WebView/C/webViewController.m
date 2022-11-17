//
//  webViewController.m
//  DaliyNews
//
//  Created by 李育腾 on 2022/10/24.
//

#import "webViewController.h"
#import "Masonry.h"
#import "webView.h"
#import "Manager.h"
#import "CommentViewController.h"
#import <FMDB.h>
#define Width [UIScreen mainScreen].bounds.size.width
#define Height [UIScreen mainScreen].bounds.size.height
@interface webViewController ()
- (void)getExtraData;
//
@property (nonatomic, strong) FMDatabase *collectionDatabase;
@property (nonatomic, strong) FMDatabase *goodDatabase;
@property (nonatomic, strong) NSString *nowID;
@property (nonatomic, strong) NSString *nowMainLabel;
@property (nonatomic, strong) NSString *nowImageUrl;
@property (nonatomic, strong)CommentViewController *commentVC;
@end

@implementation webViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _commentVC = [[CommentViewController alloc] init];
    // Do any additional setup after loading the view.
    _web = [[webView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _web.delegate = self;
    _web.extraDelegate = self;
//    _nowID = [NSString stringWithFormat:@"%ld", _nowPage];
    
    [self.web initView];
    _web.secondDelegate = self;
        
    [self databaseInit];
    self.web.nowPage = self->_nowPage;
    _web.allArray = _allArray;
    _web.allBeforeArray = _allBeforeArray;
    _web.collectViewFlag = _collectViewFlag;
    [self getExtraData];
  
    [self.view addSubview:_web];
    
}
- (void)returnButton:(UIButton *)button {
    if (button.tag == 1) {
        [self.navigationController popViewControllerAnimated:YES];;
    } else if (button.tag == 2) {
        CommentViewController* CoVC = [[CommentViewController alloc] init];
        CoVC.extraID = _extraID;
        [self.navigationController pushViewController:CoVC animated:YES];
    } else if (button.tag % 3 == 0) {
        if (button.tag == 3) {
            int goodNum =[_web.labelGood.text intValue];
            goodNum++;
            _web.labelGood.text = [NSString stringWithFormat:@"%d", goodNum];
            [self insertGoodData:self.nowID];
            [button setImage:[UIImage imageNamed:@"dianzan-2.png"] forState:UIControlStateNormal];
            button.tag = 6;
        } else {
            int goodNum =[_web.labelGood.text intValue];
            goodNum--;
            _web.labelGood.text = [NSString stringWithFormat:@"%d", goodNum];
            [button setImage:[UIImage imageNamed:@"dianzan.png"] forState:UIControlStateNormal];
            button.tag = 3;
            [self deleteGoodData:self.nowID];
        }
    } else if (button.tag % 4 == 0) {
        if (button.tag == 4) {
            [button setImage:[UIImage imageNamed:@"shoucang-2.png"] forState:UIControlStateNormal];
            [self insertCollectionData:self.nowMainLabel and:self.nowImageUrl and:self.nowID];
            button.tag = 8;
        } else {
            [button setImage:[UIImage imageNamed:@"shoucang.png"] forState:UIControlStateNormal];
            [self deleteCollectionData:_nowID];
            button.tag = 4;
        }
    }
}
- (void)getId:(id)extraId and:(NSString *)mainLabel and:(NSString *)imageUrl{
    self.nowID = extraId;
    NSLog(@"nowIDDDDDDDDDD%@", self.nowID);
    self.nowMainLabel = mainLabel;
    self.nowImageUrl = imageUrl;
    _extraID = extraId;
}
// 获取评论
- (void)getExtraData {
    [[Manager shareManager] getExtraData:^(ExtraModel * _Nonnull ExtraModel) {
        NSDictionary* extraDict = [ExtraModel toDictionary];
        self->_web.extraDict = extraDict;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.web.labelGood.text = [NSString stringWithFormat:@"%@",self.web.extraDict[@"popularity"]];
            self.web.labelCollection.text = [NSString stringWithFormat:@"%@",self.web.extraDict[@"comments"]];
            [self queryData];
        });
    } error:^(NSError * _Nonnull error) {
        ;
    } Id:_extraID];
}
- (void)returnExtraPage:(id)nowID {
    _extraID = nowID;
    [self getExtraData];
}
- (void)returnAllBeforeCount:(NSInteger)nowCount {
    NSDate *senddate = [NSDate dateWithTimeIntervalSinceNow: - 24 * 3600 * ((double)_allBeforeArray.count - 1)];
    /// 仔细查阅发现NSDate dateWithTimeIntervalSinceNow的参数为double而不是long 所以刚开始定义的NSIntger类型的变量才会出现大幅度的报错 改成Double或者int均可完成
        NSCalendar* cal = [NSCalendar  currentCalendar];
        NSUInteger unitFlags = NSCalendarUnitDay|NSCalendarUnitMonth|NSCalendarUnitYear;
        NSDateComponents * conponent= [cal components:unitFlags fromDate:senddate];
        NSInteger year = [conponent year];
        NSInteger month = [conponent month];
        NSInteger day = [conponent day];
        self->_beforeString = [NSString stringWithFormat:@"%ld%02ld%02ld", year, month, day];
        [[Manager shareManager] makeBeforeData:^(TestModel * _Nonnull ViewModel) {
        dispatch_async(dispatch_get_main_queue(), ^{
             [self->_allBeforeArray addObject:[ViewModel toDictionary]];
            self.web.allBeforeArray = self.allBeforeArray;
            [self.web scrollViewReload];
        });
        } error:^(NSError * _Nonnull error) {
            ;
        } Url:_beforeString];
}

- (void)databaseInit {
    NSString *collectionDoc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *collectionFileName = [collectionDoc stringByAppendingPathComponent:@"collectionData.sqlite"];
    NSLog(@"%@", collectionFileName);
    self.collectionDatabase = [FMDatabase databaseWithPath:collectionFileName];
    if ([self.collectionDatabase open]) {
        BOOL result = [self.collectionDatabase executeUpdate:@"CREATE TABLE IF NOT EXISTS collectionData (mainLabel text NOT NULL, imageURL text NOT NULL, id text NOT NULL);"];
        if (result) {
            NSLog(@"创表成功");
        } else {
            NSLog(@"创表失败");
        }
    }
    
    NSString *goodDoc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *goodFileName = [goodDoc stringByAppendingPathComponent:@"goodData.sqlite"];
    NSLog(@"%@", goodFileName);
    self.goodDatabase = [FMDatabase databaseWithPath:goodFileName];
    if ([self.goodDatabase open]) {
        BOOL result = [self.goodDatabase executeUpdate:@"CREATE TABLE IF NOT EXISTS goodData (id text NOT NULL);"];
        if (result) {
            NSLog(@"创表成功");
        } else {
            NSLog(@"创表失败");
        }
    }
}

// 查询数据
- (void)queryData {
    int good = 0, collect = 0;
    if ([self.collectionDatabase open]) {
        // 1.执行查询语句
        FMResultSet *collectionResultSet = [self.collectionDatabase executeQuery:@"SELECT * FROM collectionData"];
        // 2.遍历结果
        while ([collectionResultSet next]) {
            NSString *id = [collectionResultSet stringForColumn:@"id"];
            int idInt = [id intValue];
            int nowInt = [_nowID intValue];
            NSLog(@"XXXXXXXXXXXXXX%d == %d",idInt, nowInt);
            if (nowInt == idInt) {
                [self.web.buttonCollection setImage:[UIImage imageNamed:@"shoucang-2.png"] forState:UIControlStateNormal];
                collect = 1;
                self.web.buttonCollection.tag = 8;
            }
        }
        [self.collectionDatabase close];
    }
    
    if ([self.goodDatabase open]) {
        // 1.执行查询语句
        FMResultSet *goodResultSet = [self.goodDatabase executeQuery:@"SELECT * FROM goodData"];
        // 2.遍历结果
        while ([goodResultSet next]) {
            NSString *nowId = [NSString stringWithFormat:@"%@", [goodResultSet objectForColumn:@"id"]];
            int idInt = [nowId intValue];
            int nowInt = [_nowID intValue];
            if (idInt == nowInt) {
                [self.web.buttonGood setImage:[UIImage imageNamed:@"dianzan-2.png"] forState:UIControlStateNormal];
                int goodNum = [self.web.labelGood.text intValue];
                goodNum++;
                self.web.labelGood.text = [NSString stringWithFormat:@"%d", goodNum];
                //break;
                good = 1;
                self.web.buttonGood.tag = 6;
            }
        }
        [self.goodDatabase close];
    }
    NSLog(@"======%d %d",good,collect);
    
    if (good == 0) {
        self.web.buttonGood.tag = 3;
        [self.web.buttonGood setImage:[UIImage imageNamed:@"dianzan.png"] forState:UIControlStateNormal];
        int goodNum = [self.web.labelGood.text intValue];
        self.web.labelGood.text = [NSString stringWithFormat:@"%d", goodNum];
    }
    if (collect == 0) {
        self.web.buttonCollection.tag = 4;
        [self.web.buttonCollection setImage:[UIImage imageNamed:@"shoucang.png"] forState:UIControlStateNormal];
    }
}

//插入数据
- (void)insertGoodData:(NSString *)string {
    if ([self.goodDatabase open]) {
        NSLog(@"%@",string);
        BOOL result = [self.goodDatabase executeUpdate:@"INSERT INTO goodData (id) VALUES (?);", string];
        if (!result) {
            NSLog(@"增加数据失败");
        } else {
            NSLog(@"增加数据成功");
        }
        [self.goodDatabase close];
    }
}

//插入数据
- (void)insertCollectionData:(NSString *)mainLabel and:(NSString *)imageURL and:(NSString *)nowId{
    if ([self.collectionDatabase open]) {
       
        BOOL result = [self.collectionDatabase executeUpdate:@"INSERT INTO collectionData (mainLabel, imageURL, id) VALUES (?, ?, ?);", mainLabel, imageURL, nowId];
        if (!result) {
            NSLog(@"增加数据失败");
        } else {
            NSLog(@"增加数据成功");
        }
        [self.collectionDatabase close];
    }
}

// 删除数据
- (void)deleteGoodData:(NSString *)nowId {
    if ([self.goodDatabase open]) {
        NSString *sql = @"delete from goodData WHERE id = ?";
        BOOL result = [self.goodDatabase executeUpdate:sql, nowId];
        if (!result) {
            NSLog(@"数据删除失败");
        } else {
            NSLog(@"数据删除成功");
        }
        [self.goodDatabase close];
    }
}

// 删除数据
- (void)deleteCollectionData:(NSString *)nowId {
    if ([self.collectionDatabase open]) {
        NSString *sql = @"delete from collectionData WHERE id = ?";
        BOOL result = [self.collectionDatabase executeUpdate:sql, nowId];
        if (!result) {
            NSLog(@"数据删除失败");
        } else {
            NSLog(@"数据删除成功");
        }
        [self.collectionDatabase close];
    }
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
