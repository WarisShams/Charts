//
//  DoughnutChart.m
//  MTBCCharts
//
//  Created by waris on 3/26/14.
//  Copyright (c) 2014 MTBC. All rights reserved.
//

#import "DoughnutChart.h"
#import "PieSegment.h"
#import "SegmentInfo.h"
#import "DoughNutSegment.h"

@interface DoughnutChart()<SegmentDelegate>
{
    NSArray *options;NSArray *options2;
    NSMutableArray *colorArray;NSArray *colorArray2;
    CGFloat previousAngle;
    SegmentInfo *info;
    
    NSArray *chartValues;
    
    NSArray *dividerArray;
}
@end

@implementation DoughnutChart

- (id)initWithFrame:(CGRect)frame withValues:(NSArray *)values
{
    self = [super initWithFrame:frame];
    if (self) {
        
        chartValues = values;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [self setup];
    [self addSegments];

}

-(float)getTotalForArray:(NSArray *)totalArray
{
    float total = 0.0;
    for (NSString *num in chartValues[0])
    {
        float f = [num floatValue];
        total += f;
    }
    
    return total;
}

-(void)setup
{
    colorArray = [[NSMutableArray alloc]init];
    
    for (int count = 0; count<chartValues.count; count ++)
            [colorArray addObject:[self colorForLine]];
    
    dividerArray = @[@2.0,@2.8,@4.0,@5.4,@6.6,@7.8,@9.0];

}


-(void)addSegments
{
    CGFloat angleSize = 2*M_PI;
    NSArray *currentColorArray = [self getColorArray];

    for (int j =0; j<chartValues.count; j++)
    {
        if (j < dividerArray.count)
        {
            NSArray *currentArray = chartValues[j];
            float total = [self getTotalForArray:currentArray];
            float divider = [dividerArray[j] floatValue];
            
            for (int i = 0; i<[currentArray count]; i++)
            {
                float value = ([[currentArray objectAtIndex:i] floatValue]/total)*100;
                CGFloat angle = (angleSize/100)*value;
                
                DoughNutSegment *seg = [[DoughNutSegment alloc]initWithFrame:self.bounds andWithCenter:self.center radius:self.bounds.size.width/divider startAngle:previousAngle endAngle:previousAngle+angle andColor:currentColorArray[i]];
                seg.layer.backgroundColor = [UIColor clearColor].CGColor;
                seg.backgroundColor = [UIColor clearColor];
                [self addSubview:seg];
                previousAngle = previousAngle+angle;
            }
        }
    }
}

-(void)showSegmentInfoAtPoint:(CGPoint)centerPoint withText:(NSString *)text
{
    if (info)
    {
        [info removeFromSuperview];
    }
    
    info = [[SegmentInfo alloc]initWithFrame:CGRectMake(0, 0, 60, 20) andCenter:centerPoint andText:text];
    [self addSubview:info];
}

-(NSArray *)getColorArray
{
    int maxCount = 0;
    
    for (NSArray *arr in chartValues)
    {
        int currentCount = (int)arr.count;
        if (currentCount > maxCount)
            maxCount = currentCount;
    }

    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (int i = 0; i< maxCount; i++) {
        [array addObject:[self colorForLine]];
    }
    
    return array;
}

-(UIColor *)colorForLine
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1.0];
}




@end
