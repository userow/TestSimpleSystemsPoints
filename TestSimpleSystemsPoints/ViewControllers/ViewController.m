//
//  ViewController.m
//  TestSimpleSystemsPoints
//
//  Created by Pavel Wasilenko on 160306.
//  Copyright © 2016 SimpleSystems. All rights reserved.
//

#import "ViewController.h"

#import "ApiCalls.h"
#import "PointModel.h"

#import <RestKit/RestKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupUI];
}

- (void)viewDidAppear:(BOOL)animated;
{
    [self testApi];
}

- (void)setupUI {
    self.title = @"test view";
    self.view.backgroundColor = [UIColor greenColor];
}

- (void)testApi {
    
    PointModel * newPoint = [PointModel new];
    
    newPoint.title = @"Test Point Zulu";
    newPoint.lat = @0.1;
    newPoint.lng = @0.1;
    
    
    [[ApiCalls sharedCalls] addPointWithPoint:newPoint withSuccess:^(id object) {
        ;
    } andFailure:^(NSError *error) {
        ;
    }];
    
    [[ApiCalls sharedCalls] listAllPointsWithSuccess:^(id object) {
        PointModel * point = [object lastObject];
        [[ApiCalls sharedCalls] getPointWithId:point.idd withSuccess:^(id object) {
            ;
        } andFailure:^(NSError *error) {
            ;
        }];
    } andFailure:^(NSError *error) {
        ;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

@end
