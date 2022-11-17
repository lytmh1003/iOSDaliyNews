//
//  collectionViewController.h
//  DaliyNews
//
//  Created by 李育腾 on 2022/10/13.
//

#import <UIKit/UIKit.h>
#import "collectionView.h"
#import <FMDB.h>
NS_ASSUME_NONNULL_BEGIN

@interface collectionViewController : UIViewController<buttonCollectionDelegate, PushDelegate, deleteDelegate>
- (void)getPushRow:(NSInteger)row;
- (void)getDeleteRow:(NSInteger)row;
- (void)returnButton:(UIButton *)button;
@property (nonatomic, strong)FMDatabase* dataBase;
@property (nonatomic, strong)collectionView* collection;
@end

NS_ASSUME_NONNULL_END
