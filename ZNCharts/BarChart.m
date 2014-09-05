//
//  BarChartBase.m
//  MTBCCharts
//
//  Created by waris on 3/26/14.
//  Copyright (c) 2014 MTBC. All rights reserved.
//

#import "BarChart.h"
#import "BarChartB.h"

@implementation BarChart

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    BarChartB *bar = [[BarChartB alloc]initWithFrame:CGRectMake(YAXIS_BAR_WIDTH, 0, self.bounds.size.width, self.bounds.size.height-XAXIS_BAR_HEIGHT) withOptions:_values withTitles:_groupOrBarTitles];
    bar.backgroundColor = [UIColor clearColor];
    [self addSubview:bar];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 3.0);
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    CGContextAddRect(context, rect);
    CGContextStrokePath(context);
}


@end
