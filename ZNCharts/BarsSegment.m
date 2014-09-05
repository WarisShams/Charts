//
//  BarsSegment.m
//  MTBCCharts
//
//  Created by waris on 3/26/14.
//  Copyright (c) 2014 MTBC. All rights reserved.
//

#import "BarsSegment.h"

@interface BarsSegment()
{
    float hvalue;
    float xvalue;
    float yvalue;
}
@end

@implementation BarsSegment

- (id)initWithHeight:(float)height withX:(float)x withY:(float)y;
{
    self = [super init];
    if (self) {
        
        hvalue = height;
        xvalue = x;
        yvalue = y;
    }
    return self;
}

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
    CGContextRef context = UIGraphicsGetCurrentContext();


    [_color setFill];
    CGContextAddRect(context, CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height));
    CGContextFillPath(context);
    
//    [[UIColor greenColor] setFill];
//    CGContextAddRect(context, CGRectMake(rect.origin.x+4, rect.origin.y, rect.size.width, rect.size.height));
//    CGContextFillPath(context);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.delegate barSegmentTouched:(int)self.tag];
}


@end
