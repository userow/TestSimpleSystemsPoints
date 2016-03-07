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
    [pointMaping addAttributeMappingsFromArray:
    @[@"id",
    @"title",
    @"desc",
    @"lat",
    @"lng"
    ]];

    return pointMaping;
}

+ (RKObjectMapping *)requestMapping;
{
    RKObjectMapping *pointMaping = [RKObjectMapping requestMapping];
    
    [pointMaping addAttributeMappingsFromArray:
     @[@"title",
     @"desc",
     @"lat",
     @"lng"]];
    
    return pointMaping;
}

- (NSString *)description {
    NSString *des = [NSString stringWithFormat:@"\r"
                     "id   = %@\r"
                     "title = %@\r"
                     "desc  = %@\r"
                     "lat   = %f\r"
                     "lng   = %f\r",
                     self.id,
                     self.title,
                     self.desc,
                     [self.lat floatValue],
                     [self.lng floatValue]
                     ];
    
    return des;
}

+ (instancetype)pointWithId:(NSString*)id;
{
    PointModel *point = [PointModel new];
    point.id = id;
    
    return point;
}

@end
