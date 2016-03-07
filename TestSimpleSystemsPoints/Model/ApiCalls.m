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

NSString *const serverUrl = @"http://localhost.charlesproxy.com:3000/";

// Define constants.
NSString *const kListPointsRouteName = @"LIST_POINTS_ROUTE";

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
        [self setupObjectManager];
    }
    
    return self;
}
#pragma mark - Private
- (void) setupObjectManager {
    self.objectManager.requestSerializationMIMEType = RKMIMETypeJSON;
    [RKObjectManager setSharedManager:self.objectManager];
    
    //////////////////////////////////////////////////////////////////
    //Logging on
    RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);

    //////////////////////////////////////////////////////////////////
    //List all points route (named route)
    RKObjectMapping *pointMapping = [PointModel responseMapping];
    RKResponseDescriptor *listPointsResponseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:pointMapping
                                                 method:RKRequestMethodGET
                                            pathPattern:@"points"
                                                keyPath:@""
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [self.objectManager addResponseDescriptor:listPointsResponseDescriptor];
    [self.objectManager.router.routeSet addRoute:[RKRoute routeWithName:kListPointsRouteName pathPattern:@"points" method:RKRequestMethodGET]];

    
    //////////////////////////////////////////////////////////////////
    // Get point by Id route. (class route)
    RKResponseDescriptor *singlePointResponseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:pointMapping
                                                 method:RKRequestMethodGET
                                            pathPattern:@"points/:idd"
                                                keyPath:@""
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [self.objectManager addResponseDescriptor:singlePointResponseDescriptor];
    [self.objectManager.router.routeSet
     addRoute:[RKRoute routeWithClass:[PointModel class]
                          pathPattern:@"points/:idd"
                               method:RKRequestMethodGET]];
    
    //////////////////////////////////////////////////////////////////
    //Create Point route (POST)
    RKObjectMapping *pointRequestMapping = [PointModel requestMapping];
    
    RKRequestDescriptor *addPointRequestDescriptor =
    [RKRequestDescriptor requestDescriptorWithMapping:pointRequestMapping
                                          objectClass:[PointModel class]
                                          rootKeyPath:nil
                                               method:RKRequestMethodPOST];
    [self.objectManager addRequestDescriptor:addPointRequestDescriptor];
    
    RKResponseDescriptor *createPointResponseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:pointMapping
                                                 method:RKRequestMethodPOST
                                            pathPattern:@"points"
                                                keyPath:@""
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [self.objectManager addResponseDescriptor:createPointResponseDescriptor];
    [self.objectManager.router.routeSet addRoute:[RKRoute routeWithClass:[PointModel class] pathPattern:@"points" method:RKRequestMethodPOST]];

    
    
    //////////////////////////////////////////////////////////////////
    //EDIT Point route (PUT)
    RKRequestDescriptor *editPointRequestDescriptor =
    [RKRequestDescriptor requestDescriptorWithMapping:pointRequestMapping
                                          objectClass:[PointModel class]
                                          rootKeyPath:@""
                                               method:RKRequestMethodPUT];
    [self.objectManager addRequestDescriptor:editPointRequestDescriptor];
    
    RKResponseDescriptor *editPointResponseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:pointMapping
                                                 method:RKRequestMethodPUT
                                            pathPattern:@"points/:idd"
                                                keyPath:@""
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [self.objectManager addResponseDescriptor:editPointResponseDescriptor];
    [self.objectManager.router.routeSet addRoute:[RKRoute routeWithClass:[PointModel class] pathPattern:@"points/:idd" method:RKRequestMethodPUT]];
    
    //////////////////////////////////////////////////////////////////
    //DELETE Point route (DELETE)
    RKObjectMapping *delRequestMapping = [PointModel requestIdMapping];
    
    RKRequestDescriptor *delPointRequestDescriptor =
    [RKRequestDescriptor requestDescriptorWithMapping:delRequestMapping
                                          objectClass:[PointModel class]
                                          rootKeyPath:@""
                                               method:RKRequestMethodDELETE];
    [self.objectManager addRequestDescriptor:delPointRequestDescriptor];
    
    RKResponseDescriptor *delPointResponseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:pointMapping
                                                 method:RKRequestMethodDELETE
                                            pathPattern:@"points/:id"
                                                keyPath:@""
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    [self.objectManager addResponseDescriptor:delPointResponseDescriptor];
    [self.objectManager.router.routeSet addRoute:[RKRoute routeWithClass:[PointModel class] pathPattern:@"points/:id" method:RKRequestMethodDELETE]];
}

#pragma mark - Public

- (void) listAllPointsWithSuccess:(ApiCallsSuccessBlock)success andFailure:(ApiCallsFailureBlock)failure;
{
//    [[ApiCalls sharedCalls].objectManager getObject:nil path:@"points" parameters:nil
//                                             success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
//                                                 // Do something with mappingResult.array
//                                                 RKLogInfo(@"Loaded collection of points: %@", mappingResult.array);
//                                                 
//                                                 if (success) {
//                                                     success(mappingResult.array);
//                                                 }
//                                             }
//                                             failure:^(RKObjectRequestOperation *operation, NSError *error) {
//                                                 // Do something
//                                                 RKLogError(@"Operation failed with points: %@", error);
//                                                 
//                                                 if (failure) {
//                                                     failure(error);
//                                                 }
//                                             }];
    
    [[RKObjectManager sharedManager] getObjectsAtPathForRouteNamed:kListPointsRouteName
                                                            object:nil
                                                        parameters:nil
                                                           success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                               // Do something with mappingResult.array.
                                                               RKLogInfo(@"Loaded collection of points: %@", mappingResult.array);

                                                               if (success) {
                                                                   success(mappingResult.array);
                                                               }
                                                           }
                                                           failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                               // Do something.
                                                               RKLogError(@"Operation failed with points: %@", error);
                                                               
                                                               if (failure) {
                                                                   failure(error);
                                                               }

                                                           }];
}

- (void) getPointWithId:(NSString *)idd withSuccess:(ApiCallsSuccessBlock)success andFailure:(ApiCallsFailureBlock)failure;
{
    //    // Get point by ID.
    //    [[ApiCalls sharedCalls].objectManager getObject:[PointModel pointWithId:idd]
    //                                               path:@"points/:idd"
    //                                         parameters:nil
    //                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
    //                                                  // Do something with mappingResult.array
    //                                                  RKLogInfo(@"Loaded point: %@", mappingResult.firstObject);
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
    
    [[RKObjectManager sharedManager] getObject:[PointModel pointWithId:idd] path:nil parameters:nil
                                       success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                           // Do something with [mappingResult firstObject]
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

- (void) addPointWithPoint:(PointModel *)point withSuccess:(ApiCallsSuccessBlock)success andFailure:(ApiCallsFailureBlock)failure;
{
    
    // try 1 - fail
    //    [self.objectManager postObject:point path:@"points" parameters:nil
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
    //    [self.objectManager appropriateObjectRequestOperationWithObject:point
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
    
    
    //// try 3 OK !!!
    //    RKObjectMapping *requestMapping = [PointModel requestMapping];
    //    requestMapping.assignsDefaultValueForMissingAttributes = NO;
    //
    //    RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:requestMapping objectClass:[PointModel class] rootKeyPath:nil method:RKRequestMethodPOST];
    //
    //    RKObjectMapping *responseMapping = [PointModel responseMapping];
    //    NSIndexSet *statusCodes = RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful);
    //    RKResponseDescriptor *pointResponceDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:responseMapping method:RKRequestMethodPOST pathPattern:@"points" keyPath:@"" statusCodes:statusCodes];
    //
    //
    //    RKObjectManager *manager = [ApiCalls sharedCalls].objectManager;
    //    manager.requestSerializationMIMEType = RKMIMETypeJSON;
    //    [manager addRequestDescriptor:requestDescriptor];
    //    [manager addResponseDescriptor:pointResponceDescriptor];
    //
    //    [manager postObject:point path:@"points"
    //             parameters:nil
    //                success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
    //                    RKLogInfo(@"Added point: %@", mappingResult.firstObject);
    //
    //                    if (success) {
    //                        success(mappingResult.firstObject);
    //                    }
    //                } failure:^(RKObjectRequestOperation *operation, NSError *error) {
    //                    // Do something
    //                    RKLogError(@"Operation failed with points: %@", error);
    //
    //                    if (failure) {
    //                        failure(error);
    //                    }
    //    }];
    
    [[RKObjectManager sharedManager] postObject:point
                                           path:@"points"
                                     parameters:nil
                                        success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                            RKLogInfo(@"Added point: %@", mappingResult.firstObject);
                                            
                                            if (success) {
                                                success(mappingResult.firstObject);
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

- (void) deletePointWithId:(NSString *)id withSuccess:(ApiCallsSuccessBlock)success andFailure:(ApiCallsFailureBlock)failure;
{
    // Delete point by ID.
    [[RKObjectManager sharedManager] deleteObject:[PointModel pointWithId:id]
                                             path:@"points/:idd"
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
    [[RKObjectManager sharedManager] putObject:point
                                          path:@"points/:idd"
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
    [[RKObjectManager sharedManager] cancelAllObjectRequestOperationsWithMethod:RKRequestMethodGET matchingPathPattern:@"points"];
    [[RKObjectManager sharedManager] cancelAllObjectRequestOperationsWithMethod:RKRequestMethodAny matchingPathPattern:@"point/:idd"];
    [[RKObjectManager sharedManager] cancelAllObjectRequestOperationsWithMethod:RKRequestMethodAny matchingPathPattern:@""];
}



@end
