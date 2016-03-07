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
                                                      @"lng"   : @"lng"
                                                      }];
    
    return pointMaping;
}

+ (RKObjectMapping *)requestMapping;
{
    RKObjectMapping *pointMapping = [RKObjectMapping requestMapping];
    
    [pointMapping addAttributeMappingsFromDictionary:@{
                                                       @"idd"   : @"id",
                                                       @"title" : @"title",
                                                       @"desc"  : @"desc",
                                                       @"lat"   : @"lat",
                                                       @"lng"   : @"lng"
                                                       }];
    pointMapping.assignsDefaultValueForMissingAttributes = NO;
    return pointMapping;
}

+ (RKObjectMapping *)requestIdMapping;
{
    RKObjectMapping *pointMaping = [RKObjectMapping requestMapping];
    
    [pointMaping addAttributeMappingsFromDictionary:@{@"idd" : @"id"}];
    
    return pointMaping;
}

- (NSString *)description {
    NSString *des = [NSString stringWithFormat:@"\r"
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
