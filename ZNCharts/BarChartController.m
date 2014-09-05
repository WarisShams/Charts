//
//  BarChartController.m
//  MTBCCharts
//
//  Created by waris on 3/26/14.
//  Copyright (c) 2014 MTBC. All rights reserved.
//

#import "BarChartController.h"
#import "BarChart.h"

@interface BarChartController ()

@end

@implementation BarChartController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    BarChart *barBase = [[BarChart alloc]initWithFrame:CGRectMake(10, 80, 300, 200)];
    
    /*  Values is array of arrays.. if no group then use @[@[values....]] else use @[@[values of group1],@[values of group2]] :)*/
    //[barBase setValues:@[@[@"50",@"150",@"30"],@[@"80",@"70",@"50"],@[@"30",@"120",@"106"],@[@"125",@"45",@"50"],@[@"40",@"106",@"115"]]];
        [barBase setValues:@[@[@"50",@"150",@"30",@"80",@"70",@"50",@"30",@"120",@"106",@"125",@"45",@"50",@"40"]]];
    
    /* groupOrBarTitles is array of group titles in case of multiple group or bar x-axis value in other case :)*/
    [barBase setGroupOrBarTitles:@[@"2001",@"2002",@"2003",@"2004",@"2005",@"2006",@"2007",@"2008",@"2009",@"2010",@"2012",@"2013",@"2014"]];
    
    barBase.backgroundColor = [UIColor clearColor];
    [self.view addSubview:barBase];
}

@end
