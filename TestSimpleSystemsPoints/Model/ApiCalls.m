//
//  ApiCalls.m
//  TestSimpleSystemsPoints
//
//  Created by Pavel Wasilenko on 160307.
//  Copyright © 2016 SimpleSystems. All rights reserved.
//


#import <RestKit/RestKit.h>
#import "ApiCalls.h"
#import "PointModel.h"

static NSString *serverUrl = @"http://localhost.charlesproxy.com:3000/";

@interface ApiCalls ()

@property (nonatomic, strong) RKObjectManager *objectManager;

@end

@implementation ApiCalls

+ (ApiCalls *)sharedCalls;
{
    
    static ApiCalls *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ApiCalls alloc] initSingle];
    });
    
    return sharedInstance;
}

#pragma mark - Initialization


- (instancetype)initSingle
{
    self = [super init];
    if (self)
    {
        NSURL *baseUrl = [NSURL URLWithString:serverUrl];
        self.objectManager = [RKObjectManager managerWithBaseURL:baseUrl];
        [self setupDescriptors];
    }
    
    return self;
}
#pragma mark - Private
- (void) setupDescriptors {
    
    // Get quotes by symbols route. We create a class route here.
    RKObjectMapping *pointMapping = [PointModel responseMapping];
    
    
    
//    RKResponseDescriptor *addPointResponseDescriptor =
//    [RKResponseDescriptor responseDescriptorWithMapping:pointMapping
//                                                 method:RKRequestMethodPOST
//                                            pathPattern:@"points"
//                                                keyPath:@""
//                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
//    
//    [self.objectManager addResponseDescriptor:addPointResponseDescriptor];
    
    
    
    RKResponseDescriptor *getPointsResponseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:pointMapping
                                                 method:RKRequestMethodGET
                                            pathPattern:@"points"
                                                keyPath:@""
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [self.objectManager addResponseDescriptor:getPointsResponseDescriptor];
    
    
    
    RKResponseDescriptor *getPointResponseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:pointMapping
                                                 method:RKRequestMethodGET
                                            pathPattern:@"points/:id"
                                                keyPath:@""
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [self.objectManager addResponseDescriptor:getPointResponseDescriptor];
    
    
    
    RKResponseDescriptor *deletePointResponseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:pointMapping
                                                 method:RKRequestMethodDELETE
                                            pathPattern:@"points/:id"
                                                keyPath:@""
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [self.objectManager addResponseDescriptor:deletePointResponseDescriptor];
    
    
    
    
    RKResponseDescriptor *putPointsResponseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:pointMapping
                                                 method:RKRequestMethodPUT
                                            pathPattern:@"points/:id"
                                                keyPath:@""
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [self.objectManager addResponseDescriptor:putPointsResponseDescriptor];
    
    
    [self.objectManager.router.routeSet
     addRoute:[RKRoute routeWithClass:[PointModel class]
                          pathPattern:@"points"
                               method:RKRequestMethodPOST]];
    
    [self.objectManager.router.routeSet
     addRoute:[RKRoute routeWithClass:[PointModel class]
                          pathPattern:@"points/:id"
                               method:RKRequestMethodGET]];

    [self.objectManager.router.routeSet
     addRoute:[RKRoute routeWithClass:[PointModel class]
                          pathPattern:@"points/:id"
                               method:RKRequestMethodDELETE]];
    
    [self.objectManager.router.routeSet
     addRoute:[RKRoute routeWithClass:[PointModel class]
                          pathPattern:@"points/:id"
                               method:RKRequestMethodPUT]];
}

#pragma mark - Public

- (void) addPointWithPoint:(PointModel *)point withSuccess:(ApiCallsSuccessBlock)success andFailure:(ApiCallsFailureBlock)failure;
{
 
// try 1 - fail
//    [[ApiCalls sharedCalls].objectManager postObject:point path:@"points" parameters:nil
//                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
//                                                  // Do something with mappingResult.array
//                                                  RKLogInfo(@"Loaded collection of poits: %@", mappingResult.array);
//
//                                                  if (success) {
//                                                      success(mappingResult.firstObject);
//                                                  }
//                                              }
//                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
//                                                  // Do something
//                                                  RKLogError(@"Operation failed with error: %@", error);
//
//                                                  if (failure) {
//                                                      failure(error);
//                                                  }
//                                              }];
    
//// try 2 - fail
//    RKObjectRequestOperation * operation =
//    [[ApiCalls sharedCalls].objectManager appropriateObjectRequestOperationWithObject:point
//                                                                               method:RKRequestMethodPOST
//                                                                                 path:@"points"
//                                                                           parameters:nil];
//    __weak typeof(operation) weakOp = operation;
//    operation.targetObject = nil;
//    operation.completionBlock = ^void() {
//        NSLog(@"%@", weakOp);
//    };
//    
//    [[ApiCalls sharedCalls].objectManager enqueueObjectRequestOperation:operation];


//// try 3
    RKObjectMapping *requestMapping = [PointModel requestMapping];
    requestMapping.assignsDefaultValueForMissingAttributes = NO;
    
    RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:requestMapping objectClass:[PointModel class] rootKeyPath:nil method:RKRequestMethodPOST];
    
    RKObjectMapping *responseMapping = [PointModel responseMapping];
    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful);
    RKResponseDescriptor *pointResponceDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:responseMapping method:RKRequestMethodPOST pathPattern:@"points" keyPath:@"" statusCodes:statusCodes];
    
    
    RKObjectManager *manager = [ApiCalls sharedCalls].objectManager;
    manager.requestSerializationMIMEType = RKMIMETypeJSON;
    [manager addRequestDescriptor:requestDescriptor];
    [manager addResponseDescriptor:pointResponceDescriptor];
    
    [manager postObject:point path:@"points"
             parameters:nil
                success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                    RKLogInfo(@"Added point: %@", mappingResult.firstObject);
                    
                    if (success) {
                        success(mappingResult.firstObject);
                    }
                } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                    // Do something
                    RKLogError(@"Operation failed with points: %@", error);
                    
                    if (failure) {
                        failure(error);
                    }
    }];
}

- (void) getAllPointsWithSuccess:(ApiCallsSuccessBlock)success andFailure:(ApiCallsFailureBlock)failure;
{
    [[ApiCalls sharedCalls].objectManager getObject:nil path:@"points" parameters:nil
                                             success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                 // Do something with mappingResult.array
                                                 RKLogInfo(@"Loaded collection of points: %@", mappingResult.array);
                                                 
                                                 if (success) {
                                                     success(mappingResult.array);
                                                 }
                                             }
                                             failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                 // Do something
                                                 RKLogError(@"Operation failed with points: %@", error);
                                                 
                                                 if (failure) {
                                                     failure(error);
                                                 }
                                             }];
}

- (void) getPointWithId:(NSString *)id withSuccess:(ApiCallsSuccessBlock)success andFailure:(ApiCallsFailureBlock)failure;
{
    // Get point by ID.
    [[ApiCalls sharedCalls].objectManager getObject:[PointModel pointWithId:id]
                                               path:@"points/:id"
                                         parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  // Do something with mappingResult.array
                                                  RKLogInfo(@"Loaded point: %@", mappingResult.firstObject);
                                                  
                                                  if (success) {
                                                      success(mappingResult.firstObject);
                                                  }
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  // Do something
                                                  RKLogError(@"Operation failed with error: %@", error);
                                                  
                                                  if (failure) {
                                                      failure(error);
                                                  }
                                              }];
}

- (void) deletePointWithId:(NSString *)id withSuccess:(ApiCallsSuccessBlock)success andFailure:(ApiCallsFailureBlock)failure;
{
    // Delete point by ID.
    [[ApiCalls sharedCalls].objectManager deleteObject:[PointModel pointWithId:id]
                                                  path:@"points/:id"
                                            parameters:nil
                                               success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                    // Do something with mappingResult.array
                                                    RKLogInfo(@"Deleted point: %@", mappingResult.firstObject);
                                                
                                                    if (success) {
                                                        success(mappingResult.firstObject);
                                                    }
                                            }
                                            failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                // Do something
                                                RKLogError(@"Operation failed with error: %@", error);
                                                
                                                if (failure) {
                                                    failure(error);
                                                }
                                            }];
}

- (void) editPointWithPoint:(PointModel *)point withSuccess:(ApiCallsSuccessBlock)success andFailure:(ApiCallsFailureBlock)failure;
{
    [[ApiCalls sharedCalls].objectManager putObject:point
                                                  path:@"points/:id"
                                            parameters:nil
                                               success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                   // Do something with mappingResult.array
                                                   RKLogInfo(@"Loaded point: %@", mappingResult.firstObject);
                                                   
                                                   if (success) {
                                                       success(mappingResult.firstObject);
                                                   }
                                               }
                                               failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                   // Do something
                                                   RKLogError(@"Operation failed with error: %@", error);
                                                   
                                                   if (failure) {
                                                       failure(error);
                                                   }
                                               }];
}

- (void) cancelRequests;
{
    [self.objectManager cancelAllObjectRequestOperationsWithMethod:RKRequestMethodGET matchingPathPattern:@"points"];
    [self.objectManager cancelAllObjectRequestOperationsWithMethod:RKRequestMethodGET matchingPathPattern:@"point/:id"];
}



@end
