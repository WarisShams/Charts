//
//  YaxisValues.m
//  MTBCCharts
//
//  Created by waris on 3/25/14.
//  Copyright (c) 2014 MTBC. All rights reserved.
//

#import "YaxisValues.h"

@implementation YaxisValues

- (id)initWithFrame:(CGRect)frame andDifference:(float)diff withScale:(float)scale
{
    self = [super initWithFrame:frame];
    if (self)
    {
        difference = diff;
        yScale = scale;
        
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    float delta = yScale*(difference/NUMBER_OF_YAXIS_VALUES);
    float valueX = 0;
    int count = 0;
    
    float v = (difference/NUMBER_OF_YAXIS_VALUES);
    
    do
    {
        float y = valueX;
        float x = 5;

        NSString *str = [NSString stringWithFormat:@"%li",lroundf((difference)-(v*count))];
        NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:6], NSFontAttributeName,
                                    [NSNumber numberWithFloat:1.0], NSBaselineOffsetAttributeName, nil];
        if (y!=0) {
            [str drawInRect:CGRectMake(x, y-5, 20, 10) withAttributes:attributes];
        }
        valueX+=delta;
        count++;

    } while (count<NUMBER_OF_YAXIS_VALUES);
    
}


@end
