//
//  TestModel.m
//  DaliyNews
//
//  Created by 李育腾 on 2022/10/14.
//

#import "TestModel.h"

@implementation TestModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end

@implementation storiesModel
+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end

@implementation top_StoriesModel

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}
@end
