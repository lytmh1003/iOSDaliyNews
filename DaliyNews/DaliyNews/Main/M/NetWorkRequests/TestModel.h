//
//  TestModel.h
//  DaliyNews
//
//  Created by 李育腾 on 2022/10/14.
//

#import <JSONModel/JSONModel.h>

NS_ASSUME_NONNULL_BEGIN
@protocol storiesModel

@end

@protocol top_StoriesModel

@end
// 第一个数组
@interface storiesModel : JSONModel
@property (nonatomic, copy) NSString* image_hue;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* url;
@property (nonatomic, copy) NSString* hint;
@property (nonatomic, copy) NSString* ga_prefix;
@property (nonatomic, copy) NSArray* images;
@property (nonatomic, assign) NSInteger id;
@end

// 第二个数组
@interface top_StoriesModel : JSONModel
@property (nonatomic, copy) NSString* image_hue;
@property (nonatomic, copy) NSString* hint;
@property (nonatomic, copy) NSString* url;
@property (nonatomic, copy) NSString* image;
@property (nonatomic, copy) NSString* title;

@property (nonatomic, copy) NSString* ga_prefix;
@property (nonatomic, assign) NSInteger id;

//@property (nonatomic, copy) NSString* type;
@end


@interface TestModel : JSONModel
@property (nonatomic, copy) NSString* date; // 三个同类型的
@property (nonatomic, copy) NSArray<storiesModel>* stories;
@property (nonatomic, copy) NSArray<top_StoriesModel>* top_stories;
@end

NS_ASSUME_NONNULL_END
