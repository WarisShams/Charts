//
//  PieSegment.m
//  MTBCCharts
//
//  Created by waris on 3/19/14.
//  Copyright (c) 2014 MTBC. All rights reserved.
//

#import "PieSegment.h"
#import "PieChart.h"

#define   DEGREES_TO_RADIANS(degrees)  ((M_PI * degrees)/ 180)
#define   RADIANS_TO_DEGREES(radians) ((radians) * (180.0 / M_PI))

@implementation PieSegment
@synthesize delegate,rad,startA,endA,nColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        isSegmentAnimated = NO;
    }

    return self;
}


- (void)drawRect:(CGRect)rect
{
    if (cen.x == 0 || cen.y == 0)
        cen = self.center;
    
    path = [UIBezierPath bezierPath];
    currentPath = path;
    [[UIColor whiteColor] setStroke];
    [nColor setFill];
    
    
    [path addArcWithCenter:cen radius:rad startAngle:startA endAngle:(endA+startA)/2 clockwise:YES];
    CGPathRef yourCGPath1 = path.CGPath;
    NSMutableArray *bezierPoints1 = [NSMutableArray array];
    CGPathApply(yourCGPath1, (__bridge void *)(bezierPoints1), MyCGPathApplierFunc);
    CGPoint last1 = [[bezierPoints1 lastObject]CGPointValue];
    
    arcCenter = last1;
    
    [path addArcWithCenter:cen radius:rad startAngle:(endA+startA)/2 endAngle:endA clockwise:YES];
    
    CGPathRef yourCGPath = path.CGPath;
    NSMutableArray *bezierPoints = [NSMutableArray array];
    CGPathApply(yourCGPath, (__bridge void *)(bezierPoints), MyCGPathApplierFunc);
    CGPoint start = [[bezierPoints objectAtIndex:0]CGPointValue];
    CGPoint last = [[bezierPoints lastObject]CGPointValue];
    [path moveToPoint:last];
    [path addLineToPoint:cen];
    [path addLineToPoint:start];
    
    [path closePath];
    [path fill];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (flag) {
        [currentPath fill];
    }
}

-(CGPoint)getCenter:(UIBezierPath *)bPath
{
    CGPathRef yourCGPath = path.CGPath;
    NSMutableArray *bezierPoints = [NSMutableArray array];
    CGPathApply(yourCGPath, (__bridge void *)(bezierPoints), MyCGPathApplierFunc);
    CGPoint last = [[bezierPoints lastObject]CGPointValue];
    return last;
}

void MyCGPathApplierFunc (void *info, const CGPathElement *element) {
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    [self.delegate showSegmentInfoAtPoint:point withText:[NSString stringWithFormat:@"%i",(int)self.tag]];
    
    if (isSegmentAnimated)
    {
        cen= self.center;
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

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    return [path containsPoint:point];
}

-(void)refreshSegment:(PieSegment *)aSegment
{
    cen = self.center;
    [self setNeedsDisplay];
    isSegmentAnimated = NO;
}

@end
