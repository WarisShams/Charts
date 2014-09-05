//
//  LineChartExp.m
//  MTBCCharts
//
//  Created by waris on 3/22/14.
//  Copyright (c) 2014 MTBC. All rights reserved.
//

#import "LineChartExp.h"
#import "LineChart.h"

@implementation LineChartExp

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
    }
    
    return self;
}

-(void)drawRect:(CGRect)rect
{
    LineChart *line = [[LineChart alloc]initWithFrame:CGRectMake(YAXIS_BAR_WIDTH, 0, self.bounds.size.width, self.bounds.size.height-XAXIS_BAR_HEIGHT) withArray:_options];
    line.xaxisValues = _xAxisValues;
    line.backgroundColor = [UIColor clearColor];
    [self addSubview:line];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 3.0);
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGContextAddRect(context, rect);
    CGContextStrokePath(context);
}

@end
