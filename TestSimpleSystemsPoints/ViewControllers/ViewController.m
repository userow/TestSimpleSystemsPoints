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
    [self testApi];
}

- (void)setupUI {
    self.title = @"test view";
    self.view.backgroundColor = [UIColor greenColor];
}

- (void)testApi {
    
    PointModel * newPoint = [PointModel new];
    
    newPoint.title = @"Test Point 1";
    newPoint.lat = @0.0;
    newPoint.lng = @0.0;
    
    
    [[ApiCalls sharedCalls] addPointWithPoint:newPoint withSuccess:^(id object) {
        ;
    } andFailure:^(NSError *error) {
        ;
    }];
    
    [[ApiCalls sharedCalls] getAllPointsWithSuccess:^(id object) {
        ;
    } andFailure:^(NSError *error) {
        ;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

@end
