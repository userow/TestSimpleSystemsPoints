//
//  ApiCalls.h
//  TestSimpleSystemsPoints
//
//  Created by Pavel Wasilenko on 160307.
//  Copyright © 2016 SimpleSystems. All rights reserved.
//

typedef void (^ApiCallsSuccessBlock)(id object);
typedef void (^ApiCallsFailureBlock)(NSError *error);


#import <Foundation/Foundation.h>

@interface ApiCalls : NSObject

/// Singltone enter point
+ (ApiCalls *)sharedCalls;

/// assuring nobody can over-initialize singleton
- (instancetype)init NS_UNAVAILABLE;

/// assuring nobody can over-initialize singleton
+ (instancetype)new NS_UNAVAILABLE;



@end
