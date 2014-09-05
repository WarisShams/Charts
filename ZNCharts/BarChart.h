//
//  BarChartBase.h
//  MTBCCharts
//
//  Created by waris on 3/26/14.
//  Copyright (c) 2014 MTBC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BarChart : UIScrollView
@property (nonatomic,strong) NSArray *values;
@property (nonatomic,strong) NSArray *groupOrBarTitles;
@end
