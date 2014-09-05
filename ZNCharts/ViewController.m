//
//  ViewController.m
//  MTBCCharts
//
//  Created by waris on 2/25/14.
//  Copyright (c) 2014 MTBC. All rights reserved.
//

#import "ViewController.h"
#import "PieChartController.h"
#import "LineChartController.h"
#import "BarChartController.h"
#import "DoughnutChartController.h"


@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
}


-(IBAction)pieChart:(id)sender
{
    PieChartController *pie = [[PieChartController alloc]initWithNibName:@"PieChartController" bundle:nil];
    [self.navigationController pushViewController:pie animated:YES];
}

-(IBAction)lineChart:(id)sender
{
    LineChartController *line = [[LineChartController alloc]initWithNibName:@"LineChartController" bundle:nil];
    [self.navigationController pushViewController:line animated:YES];
}

-(IBAction)barChart:(id)sender
{
    BarChartController *bar = [[BarChartController alloc]initWithNibName:@"BarChartController" bundle:nil];
    [self.navigationController pushViewController:bar animated:YES];
}

-(IBAction)doughnutChart:(id)sender
{
    DoughnutChartController *doughnut = [[DoughnutChartController alloc]initWithNibName:@"DoughnutChartController" bundle:nil];
    [self.navigationController pushViewController:doughnut animated:YES];
}


/*
 
 for (int i = 0; i<options2.count; i++)
 {
 float value = ([options2[i]floatValue]/total)*100;
 CGFloat angle = (angleSize/100)*value;
 
 DoughNutSegment *seg = [[DoughNutSegment alloc]initWithFrame:self.bounds andWithCenter:self.center radius:self.bounds.size.width/2.8 startAngle:previousAngle endAngle:previousAngle+angle andColor:colorArray2[i]];
 seg.layer.backgroundColor = [UIColor clearColor].CGColor;
 seg.backgroundColor = [UIColor clearColor];
 [self addSubview:seg];
 previousAngle = previousAngle+angle;
 }
 
 for (int i = 0; i<options.count; i++)
 {
 float value = ([options[i]floatValue]/total)*100;
 CGFloat angle = (angleSize/100)*value;
 
 DoughNutSegment *seg = [[DoughNutSegment alloc]initWithFrame:self.bounds andWithCenter:self.center radius:self.bounds.size.width/4 startAngle:previousAngle endAngle:previousAngle+angle andColor:colorArray[i]];
 seg.layer.backgroundColor = [UIColor clearColor].CGColor;
 seg.backgroundColor = [UIColor clearColor];
 [self addSubview:seg];
 previousAngle = previousAngle+angle;
 }
 
 */

@end
