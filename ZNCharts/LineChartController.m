//
//  LineChartController.m
//  MTBCCharts
//
//  Created by waris on 3/21/14.
//  Copyright (c) 2014 MTBC. All rights reserved.
//

#import "LineChartController.h"
#import "LineChart.h"
#import "LineChartExp.h"

@interface LineChartController ()

@end

@implementation LineChartController

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
    LineChartExp *line = [[LineChartExp alloc]initWithFrame:CGRectMake(10, 80, 300, 200)];
    [line setOptions:@[@[@"5",@"210",@"136",@"100",@"230",@"100",@"150",@"140"],
                       @[@"190",@"160",@"120",@"145",@"110",@"160",@"180",@"200",@"150",@"140",@"190",@"160"]]];
    [line setXAxisValues:@[@"2003",@"2004",@"2005",@"2006",@"2007",@"2008",@"2009",@"2010",@"2011",@"2012",@"2013",@"2014"]];
    line.backgroundColor = [UIColor clearColor];
    [self.view addSubview:line];
}


@end
