//
//  DoughNutSegment.m
//  MTBCCharts
//
//  Created by waris on 3/27/14.
//  Copyright (c) 2014 MTBC. All rights reserved.
//

#import "DoughNutSegment.h"

@implementation DoughNutSegment

- (id)initWithFrame:(CGRect)frame andWithCenter:(CGPoint)center radius:(CGFloat)raduis
         startAngle:(CGFloat)sAngle endAngle:(CGFloat)eAngle andColor:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self)
    {
        cen = self.center;
        rad = raduis;
        startA = sAngle;
        endA = eAngle;
        newColor = color;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [newColor setStroke];
    [newColor setFill];
    
    //calculating start/end points
    CGPathRef yourCGPathP1 = [UIBezierPath bezierPathWithArcCenter:cen radius:rad startAngle:startA endAngle:endA clockwise:YES].CGPath;
    NSMutableArray *bezierPointsP1 = [NSMutableArray array];
    CGPathApply(yourCGPathP1, (__bridge void *)(bezierPointsP1), MyCGPathApplierFunc1);
    CGPoint startP1 = [[bezierPointsP1 objectAtIndex:0]CGPointValue];
    CGPoint lastP1 = [[bezierPointsP1 lastObject]CGPointValue];
    CGPoint nextLP = CGPointMake((lastP1.x+cen.x)/2, (lastP1.y+cen.y)/2);
    
    //drawing
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, newColor.CGColor);
    CGContextSetFillColorWithColor(context, newColor.CGColor);
    CGContextAddArc(context, cen.x, cen.y, rad, startA, endA, 0);
    CGContextMoveToPoint(context, lastP1.x, lastP1.y);
    CGContextAddLineToPoint(context, nextLP.x, nextLP.y);
    CGContextAddArc(context, cen.x, cen.y, rad/1.3, endA, startA, 1);
    CGContextAddLineToPoint(context, startP1.x, startP1.y);
    CGContextFillPath(context);
    CGContextStrokePath(context);
}

void MyCGPathApplierFunc1 (void *info, const CGPathElement *element) {
    NSMutableArray *bezierPoints = (__bridge NSMutableArray *)info;
    
    CGPoint *points = element->points;
    CGPathElementType type = element->type;
    
    switch(type)
    {
        case kCGPathElementMoveToPoint: // contains 1 point
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[0]]];
            break;
            
        case kCGPathElementAddLineToPoint: // contains 1 point
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[0]]];
            break;
            
        case kCGPathElementAddQuadCurveToPoint: // contains 2 points
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[0]]];
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[1]]];
            break;
            
        case kCGPathElementAddCurveToPoint: // contains 3 points
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[0]]];
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[1]]];
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[2]]];
            break;
            
        case kCGPathElementCloseSubpath: // contains no point
            break;
    }
}


@end
