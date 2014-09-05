//
//  XaxisValue_Bars.m
//  MTBCCharts
//
//  Created by waris on 4/14/14.
//  Copyright (c) 2014 MTBC. All rights reserved.
//

#import "XaxisValue_Bars.h"

@implementation XaxisValue_Bars

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
    if (_titlesPositions.count > 0)
    {
        float valueX = BAR_WIDTH/2;
        for (int count = 0; count<_titlesPositions.count; count++)
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
            
            NSValue *value = _titlesPositions[count];
            CGPoint center = value.CGPointValue;
            label.center = CGPointMake(center.x, y);
            [self addSubview:label];
            
            valueX+=((BAR_WIDTH+SPACE_BETWEEN_XAXIS_VALUES)/2);
        }

    }
    else
    {
        float valueX = BAR_WIDTH/2;
        for (int count = 0; count<_optionscount; count++)
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
            
            valueX+=((BAR_WIDTH+SPACE_BETWEEN_XAXIS_VALUES)/2);
        }

    }
}

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//
//    }
//    return self;
//}
//
//- (void)drawRect:(CGRect)rect
//{
//    for (NSArray *a in _titlesPositions)
//    {
//        float fX = [[a objectAtIndex:0]floatValue];
//        float lX = [[a lastObject]floatValue];
//        
//        float y = self.bounds.size.height-10;
//        
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(fX, y, (lX-fX)+BAR_WIDTH, 10)];
//        label.font = [UIFont systemFontOfSize:6];
//        label.textAlignment = NSTextAlignmentCenter;
//        label.text = [NSString stringWithFormat:@"%li",lroundf(100)];
//        label.backgroundColor = [UIColor clearColor];
//        [self addSubview:label];
//    }
//}

@end
