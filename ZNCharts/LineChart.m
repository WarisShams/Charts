//
//  LineChart.m
//  MTBCCharts
//
//  Created by waris on 3/21/14.
//  Copyright (c) 2014 MTBC. All rights reserved.
//

#import "LineChart.h"
#import "LinePoint.h"
#import "PointInfo.h"
#import "XaxisValues.h"
#import "LineChartExp.h"
#import "YaxisValues.h"

@interface LineChart()
{
    NSArray *options;
    //NSArray *colorArray;
    
    float total;
    float scaleY;
    float scaleX;
    float upperlimit;
    float lowerlimit;
    
    int maxCount;
    
    PointInfo *info;
    
    NSArray *dPoints;
    NSMutableArray *completeArray;
}
@end

@implementation LineChart

- (id)initWithFrame:(CGRect)frame withArray:(NSArray*)optionsArray
{
    self = [super initWithFrame:frame];
    if (self)
    {
        options = optionsArray;
        [self setup];
        
        [self drawBackgroundLines];

    }
    return self;
}

-(NSMutableArray *)drawablePoints:(float)low andHigh:(float)upper withOptions:(NSArray *)opts
{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    float xValue = 0;
    for (NSString *str  in opts)
    {
        float num = [str floatValue];
        NSString *point = [NSString stringWithFormat:@"%0.2f,%0.2f",xValue,num*scaleY];
        [array addObject:point];
        xValue+=SPACE_BETWEEN_XAXIS_VALUES;
    }
    
    return array;
}

-(void)setup
{
    completeArray = [[NSMutableArray alloc]init];
    
    maxCount = 0;//options.count;//
    
    for (NSArray *arr in options)
    {
        int currentCount = (int)arr.count;
        if (currentCount > maxCount)
            maxCount = currentCount;
        
        [completeArray addObjectsFromArray:arr];
    }
    
    float expectedWidth = SPACE_BETWEEN_XAXIS_VALUES*maxCount;
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, expectedWidth, self.frame.size.height)];
    
    
    BOOL isFirstTime = YES;
    for (id str in completeArray)
    {
        if(isFirstTime)
        {
            lowerlimit = upperlimit = [str floatValue];
            isFirstTime = NO;
            continue;
        }
        
        lowerlimit = fminf(lowerlimit, [str floatValue]);
        upperlimit = fmaxf(upperlimit, [str floatValue]);
    }
    
    float totalPoints = self.frame.size.height/30.0;
    
    float difference = upperlimit - lowerlimit;
    float t = difference / totalPoints;
    
    if (lowerlimit > t)
        lowerlimit -=t;
    else
        lowerlimit = 0;
    
    upperlimit +=t;
    
    scaleY = self.bounds.size.height/upperlimit;
    scaleX = self.bounds.size.width/SPACE_BETWEEN_XAXIS_VALUES;

}


- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    LineChartExp *superView = (LineChartExp *)self.superview;
    [superView setContentSize:CGSizeMake(self.frame.size.width+YAXIS_BAR_WIDTH, superView.frame.size.height)];
    
    XaxisValues *view2 = [[XaxisValues alloc]initWithFrame:CGRectMake(YAXIS_BAR_WIDTH, superView.bounds.size.height-XAXIS_BAR_HEIGHT, self.bounds.size.width, XAXIS_BAR_HEIGHT)];
    view2.values = _xaxisValues;
    view2.optionscount = maxCount;
    view2.backgroundColor = [UIColor clearColor];
    [self.superview addSubview:view2];
    
    YaxisValues *view3 = [[YaxisValues alloc]initWithFrame:CGRectMake(0, 0, YAXIS_BAR_WIDTH, superView.bounds.size.height-XAXIS_BAR_HEIGHT) andDifference:upperlimit-lowerlimit withScale:scaleY];
    view3.backgroundColor = [UIColor clearColor];
    [self.superview addSubview:view3];
    int tag = 0;

    for (int j = 0; j<options.count; j++)
    {
        UIColor *strokeColor = [self colorForLine];
        [strokeColor setStroke];
        
        dPoints = [self drawablePoints:lowerlimit andHigh:upperlimit withOptions:options[j]];
        BOOL isFirstPoint = YES;
        for (int i = 0; i<dPoints.count; i++)
        {
            NSString *point = [dPoints objectAtIndex:i];
            NSArray *points = [point componentsSeparatedByString:@","];
            float x = [points[0]floatValue];
            float y = self.bounds.size.height-[points[1]floatValue];
            
            if (isFirstPoint)
            {
                isFirstPoint = NO;
                
                CGContextMoveToPoint(context, x, y);
                CGContextStrokePath(context);
            }
            else
            {
                NSString *point = [dPoints objectAtIndex:i-1];
                NSArray *points = [point componentsSeparatedByString:@","];
                float xP = [points[0]floatValue];
                float yP = self.bounds.size.height-[points[1]floatValue];
                
                CGContextMoveToPoint(context, xP, yP);
                CGContextAddLineToPoint(context, x, y);
                CGContextStrokePath(context);
            }
            
        }
        
        for (NSString *string in dPoints)
        {
            NSArray *points = [string componentsSeparatedByString:@","];
            float x = ([points[0]floatValue]);
            float y = self.bounds.size.height-[points[1]floatValue];
            LinePoint *point = [[LinePoint alloc]initWithFrame:CGRectMake (x-2, y-2, 4.0, 4.0)];
            point.tag = tag;
            [self addSubview:point];
            
            tag++;
        }
    }
}

-(void)drawBackgroundLines
{
    float delta = scaleY*((upperlimit-lowerlimit)/NUMBER_OF_YAXIS_VALUES);
    float valueX = 0;
    int count = 0;
    
    do
    {
        float y = valueX;
        float x = 0;

        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:CGPointMake(x, y)];
        [path addLineToPoint:CGPointMake(x+1000, y)];

        CAShapeLayer *pathLayer = [CAShapeLayer layer];
        pathLayer.path = path.CGPath;
        pathLayer.strokeColor = [[UIColor lightGrayColor] CGColor];
        pathLayer.fillColor = nil;
        pathLayer.lineWidth = 1.0f;

        [self.layer insertSublayer:pathLayer atIndex:0];

        CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
        pathAnimation.duration = 0.1;
        pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
        pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
        [pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];

        valueX+=delta;
        count++;
        
    } while (count<=NUMBER_OF_YAXIS_VALUES);
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    CGRect touchedRect = CGRectMake(point.x-10, point.y-10, 20, 20);
    
    if (info)
        [info removeFromSuperview];

    NSArray *array = [self subviews];
    for (LinePoint *point in array)
    {
        if (CGRectContainsPoint(touchedRect, point.center))
        {
            NSString *string = [NSString stringWithFormat:@"%@",completeArray[point.tag]];
            info = [[PointInfo alloc]initWithFrame:[self getExpeectedHeigh:string] andCenter:point.center andText:string];
            info.layer.cornerRadius = 10;
            [self addSubview:info];
            break;
            
        }
    }
}

-(CGRect)getExpeectedHeigh:(NSString*)text
{
    CGRect expectedFrame = [text boundingRectWithSize:CGSizeMake(189, 10)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIFont fontWithName:@"Helvetica-Light" size:10], NSFontAttributeName,nil]
                                              context:nil];
    
    //expectedFrame = CGRectMake(expectedFrame.origin.x, expectedFrame.origin.y, expectedFrame.size.width+5, expectedFrame.size.height);
    return expectedFrame;
}


-(UIColor *)colorForLine
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1.0];
}

@end
