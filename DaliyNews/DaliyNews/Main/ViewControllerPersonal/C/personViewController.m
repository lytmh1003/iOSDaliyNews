//
//  personViewController.m
//  DaliyNews
//
//  Created by 李育腾 on 2022/10/12.
//

#import "personViewController.h"
#import "personView.h"
#import "collectionViewController.h"
#import "messageCenterViewController.h"
@interface personViewController ()

@end

@implementation personViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    personView* pView = [[personView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    // 代理
    pView.delegate = self;
    [self.view addSubview:pView];
    [pView initView];
}
- (void) returnButton:(UIButton *)button {
    if (button.tag == 3) {
        [self.navigationController popViewControllerAnimated:YES];
    } else if (button.tag == 0) {
        NSLog(@"Fail to GO collection");
        collectionViewController* collect = [[collectionViewController alloc] init];
        [self.navigationController pushViewController:collect animated:YES];
    } else {
        messageCenterViewController* megCenter = [[messageCenterViewController alloc] init];
        [self.navigationController pushViewController:megCenter animated:YES];
        NSLog(@"Fail to Go message!");
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
