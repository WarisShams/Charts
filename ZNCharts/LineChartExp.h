//
//  LineChartExp.h
//  MTBCCharts
//
//  Created by waris on 3/22/14.
//  Copyright (c) 2014 MTBC. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LinePoint.h"
#import "PointInfo.h"

@interface LineChartExp : UIScrollView
@property (nonatomic,strong) NSArray *options;
@property (nonatomic,strong) NSArray *xAxisValues;
@end
