//
//  messageCenterViewController.m
//  DaliyNews
//
//  Created by 李育腾 on 2022/10/13.
//

#import "messageCenterViewController.h"
#import "messageCenterView.h"
@interface messageCenterViewController ()

@end

@implementation messageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    messageCenterView* collection = [[messageCenterView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview:collection];
    collection.delegate = self;
    [collection initView];
}
- (void) returnButton:(UIButton *)button {
//    personViewController* pViewC = [[personViewController alloc] init];
    [self.navigationController popViewControllerAnimated:YES];
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
