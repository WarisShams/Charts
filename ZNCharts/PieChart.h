//
//  PieChart.h
//  MTBCCharts
//
//  Created by waris on 3/19/14.
//  Copyright (c) 2014 MTBC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AllDefines.h"

@interface PieChart : UIView
@property (nonatomic,strong) NSArray *options;
@property (nonatomic,strong) NSArray *titleValues;
@property (nonatomic) SideValueBar sideValue_Bar;
@property (nonatomic) SegmentSelection segment_Selection;
@end
