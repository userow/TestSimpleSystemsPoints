//
//  PointModel.m
//  TestSimpleSystemsPoints
//
//  Created by Pavel Wasilenko on 160307.
//  Copyright © 2016 SimpleSystems. All rights reserved.
//

@import UIKit;
#import <RestKit/RestKit.h>

#import "PointModel.h"

@implementation PointModel

+ (RKObjectMapping *)responseMapping;
{
    RKObjectMapping *pointMaping = [RKObjectMapping mappingForClass:[PointModel class]];
    [pointMaping addAttributeMappingsFromDictionary:@{
                                                      @"id"    : @"idd",
                                                      @"title" : @"title",
                                                      @"desc"  : @"desc",
                                                      @"lat"   : @"lat",
                                                      @"lon"   : @"lon"
                                                      }];
    
    return pointMaping;
}

+ (RKObjectMapping *)requestMapping;
{
    return [[PointModel requestMapping] inverseMapping];
}

- (NSString *)description {
    NSString *des = [NSString stringWithFormat:@""
                     "idd   = %@\r"
                     "title = %@\r"
                     "desc  = %@\r"
                     "lat   = %f\r"
                     "lng   = %f\r",
                     self.idd,
                     self.title,
                     self.desc,
                     [self.lat floatValue],
                     [self.lng floatValue]
                     ];
    
    return des;
}

+ (instancetype)pointWithId:(NSString*)idd;
{
    PointModel *point = [PointModel new];
    point.idd = idd;
    
    return point;
}

@end
