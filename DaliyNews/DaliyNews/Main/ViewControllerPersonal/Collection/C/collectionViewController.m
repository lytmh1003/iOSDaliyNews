//
//  collectionViewController.m
//  DaliyNews
//
//  Created by 李育腾 on 2022/10/13.
//

#import "collectionViewController.h"
#import "collectionViewController.h"
#import "collectionView.h"
#import "personViewController.h"
#import <FMDB.h>
#import "webViewController.h"
@interface collectionViewController ()
@property (nonatomic, strong) FMDatabase *collectionDatabase;
@property (nonatomic, strong) NSMutableArray *collectArray;
@end

@implementation collectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self databaseInit];
    [self queryData];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    self.collection = [[collectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.collection.delegate = self;
    self.collection.getDelete = self;
    self.collection.pushDelegate = self;
    [self.view addSubview:self.collection];
    [self.collection initView];
}
- (void) returnButton:(UIButton *)button {
//    personViewController* pViewC = [[personViewController alloc] init];
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"BACK IN CollectViewTroller");
}

- (void)databaseInit {
    NSString *collectionDoc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *collectionFileName = [collectionDoc stringByAppendingPathComponent:@"collectionData.sqlite"];
    self.collectionDatabase = [FMDatabase databaseWithPath:collectionFileName];
}

// 查询数据
- (void)queryData {
    self.collectArray = [[NSMutableArray alloc] init];
    if ([self.collectionDatabase open]) {
        // 1.执行查询语句
        FMResultSet *collectionResultSet = [self.collectionDatabase executeQuery:@"SELECT * FROM collectionData"];
        // 2.遍历结果
        while ([collectionResultSet next]) {
            NSString *id = [collectionResultSet stringForColumn:@"id"];
            NSString *mainLabel = [collectionResultSet stringForColumn:@"mainLabel"];
            NSString *imageUrl = [collectionResultSet stringForColumn:@"imageURL"];
            NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:id, @"id", mainLabel, @"mainLabel", imageUrl, @"imageUrl", nil];
            [self.collectArray addObject:dictionary];
            self.collection.collectArray = self.collectArray;
            }
        [self.collectionDatabase close];
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
- (void)viewDidAppear:(BOOL)animated {
    [self queryData];
    [self.collection.collectionTableView reloadData];
}
- (void)getPushRow:(NSInteger)row {
    webViewController *wkWebViewController = [[webViewController alloc] init];
    wkWebViewController.collectViewFlag = 777;
    wkWebViewController.nowPage = row;
    wkWebViewController.allArray = self.collectArray;
    [self.navigationController pushViewController:wkWebViewController animated:YES];
}
- (void)getDeleteRow:(NSInteger)row {
    NSLog(@"%ld", row);
    [self deleteCollectionData:self.collectArray[row][@"id"]];
    [self.collectArray removeObjectAtIndex:row];
    self.collection.collectArray = self.collectArray;
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
