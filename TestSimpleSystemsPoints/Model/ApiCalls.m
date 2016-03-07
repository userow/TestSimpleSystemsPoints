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

static NSString *serverUrl = @"http://localhost:3000/";

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
        
        //        _defaultQuotes = [NSArray array];
    }
    
    return self;
}
#pragma mark - Private
- (void) setupDescriptors {
    
    // Get quotes by symbols route. We create a class route here.
    RKObjectMapping *pointMapping = [PointModel responseMapping];
    
    
    
    RKResponseDescriptor *addPointResponseDescriptor =
    [RKResponseDescriptor responseDescriptorWithMapping:pointMapping
                                                 method:RKRequestMethodPOST
                                            pathPattern:@"points"
                                                keyPath:@""
                                            statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    [self.objectManager addResponseDescriptor:addPointResponseDescriptor];
    
    
    
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

- (void) addPointWithPoint:(PointModel *)idd withSuccess:(ApiCallsSuccessBlock)success andFailure:(ApiCallsFailureBlock)failure;
{
    
}

- (void) getAllPointsWithSuccess:(ApiCallsSuccessBlock)success andFailure:(ApiCallsFailureBlock)failure;
{
    
}

- (void) getPointWithId:(NSString *)idd withSuccess:(ApiCallsSuccessBlock)success andFailure:(ApiCallsFailureBlock)failure;
{
    //// Using usual request, no operation
    //    [self.objectManager getObjectsAtPath:requestPathString
    //                              parameters:requestParametersDic
    //                                 success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
    //                                     RKLogInfo(@"Load collection of quotes: %@", mappingResult.array);
    //                                 } failure:^(RKObjectRequestOperation *operation, NSError *error) {
    //                                     RKLogError(@"Operation failed with error: %@", error);
    //                                 }];
    
    // Get a user by user name.
//    [[ApiCalls sharedCalls].objectManager getObject:[PointModel pointWithId:] path: parameters:
//                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
//                                                  // Do something with mappingResult.array
//                                                  RKLogInfo(@"Loaded collection of quotes: %@", mappingResult.array);
//                                                  
//                                                  if (success) {
//                                                      success(mappingResult.array);
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
}

- (void) deletePointWithId:(NSString *)idd withSuccess:(ApiCallsSuccessBlock)success andFailure:(ApiCallsFailureBlock)failure;
{
    
}

- (void) editPointWithPoint:(PointModel *)point withSuccess:(ApiCallsSuccessBlock)success andFailure:(ApiCallsFailureBlock)failure;
{
    
}
- (void)cancelRequests;
{
//    [self.objectManager cancelAllObjectRequestOperationsWithMethod:RKRequestMethodGET matchingPathPattern:@"point"];
}



@end
