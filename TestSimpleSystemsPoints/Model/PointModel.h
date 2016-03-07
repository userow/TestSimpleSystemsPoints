//
//  PointModel.h
//  TestSimpleSystemsPoints
//
//  Created by Pavel Wasilenko on 160307.
//  Copyright © 2016 SimpleSystems. All rights reserved.
//

/*
 Не обходимо разработать приложение для работы с набором точек. У кажой точки есть:
 
 название (title);
 необязательно описание (desc);
 широта (lat);
 долгота (lng).
 */

@import Foundation;

@class RKObjectMapping;

@interface PointModel : NSObject

@property (nonatomic, strong) NSString *idd;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSNumber *lat;
@property (nonatomic, strong) NSNumber *lng;

+ (RKObjectMapping *)requestMapping;
+ (RKObjectMapping *)responseMapping;

+ (instancetype)pointWithId:(NSString*)iid;

@end
