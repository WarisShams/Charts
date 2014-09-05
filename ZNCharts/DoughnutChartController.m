//
//  DoughnutChartController.m
//  MTBCCharts
//
//  Created by waris on 3/26/14.
//  Copyright (c) 2014 MTBC. All rights reserved.
//

#import "DoughnutChartController.h"
#import "DoughnutChart.h"

@interface DoughnutChartController ()

@end

@implementation DoughnutChartController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    DoughnutChart *p = [[DoughnutChart alloc]initWithFrame:CGRectMake(10, 10, 250, 250) withValues:@[@[@"60",@"30",@"10",@"10",@"20",@"10"],@[@"30",@"50",@"20",@"80",@"10",@"10"]]];
    p.backgroundColor = [UIColor clearColor];
    [self.view addSubview:p];
}

@end
