//
//  XaisValues.m
//  MTBCCharts
//
//  Created by waris on 3/22/14.
//  Copyright (c) 2014 MTBC. All rights reserved.
//

#import "XaxisValues.h"

@implementation XaxisValues

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    float valueX = 0;
    for (int count = 0; count<=_optionscount; count++)
    {
        float x = valueX;
        float y = self.bounds.size.height-20;
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(x, y, 15, 16)];
        label.font = [UIFont systemFontOfSize:6];
        label.center = CGPointMake(x, label.frame.origin.y);
        
        if (count < _values.count)
            label.text = _values[count];
        else
            label.text = @"";
        
        label.backgroundColor = [UIColor clearColor];
        label.transform = CGAffineTransformMakeRotation(-M_PI_4);
        [self addSubview:label];
        
        valueX+=(SPACE_BETWEEN_XAXIS_VALUES);
    }
}


@end
