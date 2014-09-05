//
//  PieSegmentLayer.m
//  MTBCCharts
//
//  Created by waris on 4/10/14.
//  Copyright (c) 2014 MTBC. All rights reserved.
//

#import "PieSegmentLayer.h"

@implementation PieSegmentLayer
@synthesize delegate,rad,startA,endA,myColor;

- (id)init
{
    self = [super init];
    if (self)
    {
        isSegmentAnimated = NO;
        self.shouldRasterize = YES;
    }
    
    return self;
}


-(void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
    
}


-(void)drawInContext:(CGContextRef)ctx
{
    if (cen.x == 0 || cen.y == 0)
        cen = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidX(self.frame));

    UIGraphicsPushContext(ctx);

    path = [UIBezierPath bezierPath];
    currentPath = path;
    [myColor setStroke];
    [myColor setFill];
    
    [path addArcWithCenter:cen radius:rad startAngle:startA endAngle:(endA+startA)/2 clockwise:YES];
    CGPathRef yourCGPath1 = path.CGPath;
    NSMutableArray *bezierPoints1 = [NSMutableArray array];
    CGPathApply(yourCGPath1, (__bridge void *)(bezierPoints1), MyCGPathApplierFunc2);
    CGPoint last1 = [[bezierPoints1 lastObject]CGPointValue];
    
    arcCenter = last1;
    
    [path addArcWithCenter:cen radius:rad startAngle:(endA+startA)/2 endAngle:endA clockwise:YES];
    
    CGPathRef yourCGPath = path.CGPath;
    NSMutableArray *bezierPoints = [NSMutableArray array];
    CGPathApply(yourCGPath, (__bridge void *)(bezierPoints), MyCGPathApplierFunc2);
    CGPoint start = [[bezierPoints objectAtIndex:0]CGPointValue];
    CGPoint last = [[bezierPoints lastObject]CGPointValue];
    [path moveToPoint:last];
    [path addLineToPoint:cen];
    [path addLineToPoint:start];
    
    [path stroke];
    [path closePath];
    [path fill];
}

-(CGPoint)getCenter:(UIBezierPath *)bPath
{
    CGPathRef yourCGPath = path.CGPath;
    NSMutableArray *bezierPoints = [NSMutableArray array];
    CGPathApply(yourCGPath, (__bridge void *)(bezierPoints), MyCGPathApplierFunc2);
    CGPoint last = [[bezierPoints lastObject]CGPointValue];
    return last;
}

void MyCGPathApplierFunc2 (void *info, const CGPathElement *element) {
    NSMutableArray *bezierPoints = (__bridge NSMutableArray *)info;
    
    CGPoint *points = element->points;
    CGPathElementType type = element->type;
    
    switch(type)
    {
        case kCGPathElementMoveToPoint:
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[0]]];
            break;
            
        case kCGPathElementAddLineToPoint:
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[0]]];
            break;
            
        case kCGPathElementAddQuadCurveToPoint:
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[0]]];
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[1]]];
            break;
            
        case kCGPathElementAddCurveToPoint:
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[0]]];
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[1]]];
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[2]]];
            break;
            
        case kCGPathElementCloseSubpath:
            break;
    }
}

-(void)updateSegments
{
    if (isSegmentAnimated)
    {
        cen= CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidX(self.frame));
        isSegmentAnimated = NO;
    }
    else
    {
        CGPoint cen1 = CGPointMake((arcCenter.x+cen.x)/2, (arcCenter.y+cen.y)/2);
        CGPoint cen2 = CGPointMake((cen1.x+cen.x)/2, (cen1.y+cen.y)/2);
        cen2 = CGPointMake((cen2.x+cen.x)/2, (cen2.y+cen.y)/2);
        cen = cen2;
        isSegmentAnimated = YES;
    }
    
    [self setNeedsDisplay];
}

-(void)refreshSegment:(PieSegmentLayer *)aSegment
{
    cen = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidX(self.frame));
    [self setNeedsDisplay];
    isSegmentAnimated = NO;
}

-(BOOL)containsPoint:(CGPoint)p
{
    return [path containsPoint:p];
}


@end
