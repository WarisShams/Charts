//
//  LineChart.h
//  MTBCCharts
//
//  Created by waris on 3/21/14.
//  Copyright (c) 2014 MTBC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LineChart : UIView
{
    
}
@property (nonatomic,strong) NSArray *xaxisValues;
- (id)initWithFrame:(CGRect)frame withArray:(NSArray*)optionsArray;
@end
