//
//  PieChartController.m
//  MTBCCharts
//
//  Created by waris on 2/25/14.
//  Copyright (c) 2014 MTBC. All rights reserved.
//

#import "PieChartController.h"
#import "PieChart.h"

@interface PieChartController ()

@end

@implementation PieChartController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    PieChart *pie = [[PieChart alloc]initWithFrame:CGRectMake(10, 10, 300, 250)];
    
    [pie setOptions:@[@10,@30,@10,@10,@20,@60,@70]];
    [pie setTitleValues:@[@"2008",@"2009",@"2010",@"2011",@"2012",@"2013"]];
    [pie setSideValue_Bar:kSideValueBar_Show];
    [pie setSegment_Selection:kSegmentSelection_On];
    
    [self.view addSubview:pie];
}

@end
