//
//  BarChart.m
//  MTBCCharts
//
//  Created by waris on 3/26/14.
//  Copyright (c) 2014 MTBC. All rights reserved.
//

#import "BarChartB.h"
#import "LinePoint.h"
#import "BarChart.h"
#import "XaxisValues.h"
#import "YaxisValues.h"
#import "BarsSegment.h"
#import "PointInfo.h"
#import "XaxisValue_Bars.h"

@interface BarChartB()<BarSegmentDelegate>
{
    NSArray *options;
    NSArray *colorArray;
    
    NSMutableArray *drawPoints;
    
    float total;
    float scaleY;
    float scaleX;
    float upperlimit;
    float lowerlimit;
    
    PointInfo *info;
    
    NSArray *dPoints;
    NSMutableArray *completeArray;
    NSMutableArray *groupsTitlePositions;
    
    NSArray *xTitlesValues;
}
@end

@implementation BarChartB

- (id)initWithFrame:(CGRect)frame withOptions:(NSArray *)optionsArray withTitles:(NSArray *)xTitles
{
    self = [super initWithFrame:frame];
    if (self)
    {
        options = optionsArray;
        xTitlesValues = xTitles;
        [self setup];
        groupsTitlePositions = [[NSMutableArray alloc]init];
    }
    return self;
}

-(void)setup
{
    completeArray = [[NSMutableArray alloc]init];
        
    int maxCount = 0;
    
    for (NSArray *arr in options)
    {
        int currentCount = (int)arr.count;
        if (currentCount > maxCount)
            maxCount = currentCount;
        
        [completeArray addObjectsFromArray:arr];
    }
    
    NSMutableArray *temp = [[NSMutableArray alloc]init];
    for (int i =0; i<maxCount; i++)
    {
        [temp addObject:[self colorForLine]];
    }
    
    colorArray = temp;
    
    float expectedWidth = SPACE_BETWEEN_BARS*completeArray.count+(options.count*SPACE_BETWEEN_BARGROUPS);
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


- (void)drawRect:(CGRect)rect
{
    [self drawBackgroundLines];
    
    int tag = 1;
    int xVal = 0;
    
    CGPoint one;
    CGPoint two;
    
    for (int j = 0; j<options.count; j++)
    {
        UIColor *colorR = [self colorForLine];
        dPoints = [self drawablePoints:lowerlimit andHigh:upperlimit withOptions:options[j]];
        
        for (int i = 0; i<dPoints.count; i++)
        {
            NSString *string = dPoints[i];
            NSArray *points = [string componentsSeparatedByString:@","];
            float x = xVal;
            float y = self.bounds.size.height-[points[1]floatValue];
            
            BarsSegment *segment = [[BarsSegment alloc]initWithFrame:CGRectMake(x, y,BAR_WIDTH, self.bounds.size.height-y)];
            segment.delegate = self;
            
            if (options.count == 1)
                segment.color = colorR;
            else
                segment.color = colorArray[i];
            
            segment.tag = tag;
            [self addSubview:segment];
            
            
            if (i == 0)
                one = CGPointMake(x, y);
            if (i == dPoints.count-1)
                two = CGPointMake(x+BAR_WIDTH, y);
            
            
            
            tag++;
            xVal+=SPACE_BETWEEN_BARS;
        }
        
        if (options.count > 1)
        {
            CGPoint cen = CGPointMake((one.x+two.x)/2, (one.y+two.y)/2);
            [groupsTitlePositions addObject:[NSValue valueWithCGPoint:cen]];
        }

        
        xVal+=SPACE_BETWEEN_BARGROUPS;
        
        
    }
    
    BarChart *superView = (BarChart *)self.superview;
    [superView setContentSize:CGSizeMake(self.frame.size.width+YAXIS_BAR_WIDTH, superView.frame.size.height)];
 
    XaxisValue_Bars *view2 = [[XaxisValue_Bars alloc]initWithFrame:CGRectMake(YAXIS_BAR_WIDTH, superView.bounds.size.height-XAXIS_BAR_HEIGHT, self.bounds.size.width, XAXIS_BAR_HEIGHT)];
    view2.values = xTitlesValues;
    view2.optionscount = (int)[options[0] count];
    view2.backgroundColor = [UIColor clearColor];
    view2.titlesPositions = groupsTitlePositions;
    [self.superview addSubview:view2];
   
    YaxisValues *view3 = [[YaxisValues alloc]initWithFrame:CGRectMake(0, 0, YAXIS_BAR_WIDTH, superView.bounds.size.height-XAXIS_BAR_HEIGHT) andDifference:upperlimit-lowerlimit withScale:scaleY];
    view3.backgroundColor = [UIColor clearColor];
    [self.superview addSubview:view3];
}

-(void)drawablePoints:(float)low andHigh:(float)upper
{
    float xValue = 0;
    for (NSString *str  in options)
    {
        float num = [str floatValue];
        NSString *point = [NSString stringWithFormat:@"%0.2f,%0.2f",xValue,num*scaleY];
        [drawPoints addObject:point];
        xValue+=SPACE_BETWEEN_XAXIS_VALUES;
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


-(void)drawBackgroundLines1
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0);
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    
    float delta = scaleY*((upperlimit-lowerlimit)/NUMBER_OF_YAXIS_VALUES);
    float valueX = 0;
    int count = 0;
    
    do
    {
        float y = valueX;
        float x = 0;
        
        CGContextMoveToPoint(context, x, y);
        
        CGContextAddLineToPoint(context, x+1000, y);
        CGContextStrokePath(context);
        valueX+=delta;
        count++;
        
    } while (count<=NUMBER_OF_YAXIS_VALUES+1);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (info) {
        [info removeFromSuperview];
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


-(void)barSegmentTouched:(int)tag
{
    if (info)
        [info removeFromSuperview];
    int localTag = tag -1;
    BarsSegment *bar = (BarsSegment *)[self viewWithTag:tag];
    NSString *string = [NSString stringWithFormat:@"%@",completeArray[localTag]];
    info = [[PointInfo alloc]initWithFrame:[self getExpeectedHeigh:string] andCenter:bar.center andText:string];
    [self addSubview:info];
}

-(UIColor *)colorForLine
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1.0];
}


@end
