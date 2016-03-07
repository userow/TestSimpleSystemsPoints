//
//  ApiCalls.h
//  TestSimpleSystemsPoints
//
//  Created by Pavel Wasilenko on 160307.
//  Copyright © 2016 SimpleSystems. All rights reserved.
//

typedef void (^ApiCallsSuccessBlock)(id object);
typedef void (^ApiCallsFailureBlock)(NSError *error);

@class PointModel;

// Declare constants.
extern NSString *const kApiCallsListPointsRouteName;

#import <Foundation/Foundation.h>

@interface ApiCalls : NSObject

/// Singltone enter point
+ (ApiCalls *)sharedCalls;

/// assuring nobody can over-initialize singleton
- (instancetype)init NS_UNAVAILABLE;

/// assuring nobody can over-initialize singleton
+ (instancetype)new NS_UNAVAILABLE;



- (void) addPointWithPoint:(PointModel *)point withSuccess:(ApiCallsSuccessBlock)success andFailure:(ApiCallsFailureBlock)failure;
- (void) listAllPointsWithSuccess:(ApiCallsSuccessBlock)success andFailure:(ApiCallsFailureBlock)failure;
- (void) getPointWithId:(NSString *)id withSuccess:(ApiCallsSuccessBlock)success andFailure:(ApiCallsFailureBlock)failure;
- (void) deletePointWithId:(NSString *)id withSuccess:(ApiCallsSuccessBlock)success andFailure:(ApiCallsFailureBlock)failure;
- (void) editPointWithPoint:(PointModel *)point withSuccess:(ApiCallsSuccessBlock)success andFailure:(ApiCallsFailureBlock)failure;
- (void) cancelRequests;

@end
