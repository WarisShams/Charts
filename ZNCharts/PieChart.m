//
//  PieChart.m
//  MTBCCharts
//
//  Created by waris on 3/19/14.
//  Copyright (c) 2014 MTBC. All rights reserved.
//

#import "PieChart.h"
#import "PieSegmentLayer.h"
#import "PieSegment.h"

@interface PieChart()<SegmentDelegate>
{
    NSArray *colorArray;
    float total;
    UIScrollView *scrollView;
    CGFloat previousAngle;
}
@end

@implementation PieChart
@synthesize options;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        colorArray = @[[UIColor yellowColor],[UIColor magentaColor],[UIColor redColor],[UIColor blueColor],[UIColor purpleColor],[UIColor greenColor],[UIColor cyanColor],[UIColor yellowColor],[UIColor magentaColor],[UIColor redColor],[UIColor blueColor],[UIColor purpleColor],[UIColor greenColor],[UIColor cyanColor]];
    }
    return self;
}

-(void)adjustHeightnWidth
{
    if (_sideValue_Bar == kSideValueBar_Show)
    {
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.bounds.size.width, self.bounds.size.width-60)];
        scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(self.bounds.size.width-70, 10, 60, self.bounds.size.width-80)];
        scrollView.backgroundColor = [UIColor clearColor];
        scrollView.showsVerticalScrollIndicator = NO;
        [scrollView setContentSize:CGSizeMake(60, options.count*40)];
        [self addSubview:scrollView];
    }
    else
    {
        [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.bounds.size.width, self.bounds.size.width)];
    }
}

-(void)removeNegitiveValues
{
    NSMutableArray *newOptions = [[NSMutableArray alloc]init];
    for (id num in options)
    {
        float f = [num floatValue];
        if (f > 0)
        {
            [newOptions addObject:num];
        }
    }
    
    options = newOptions;
}

-(void)adjustOptions
{
    for (id num in options)
    {
        float f = [num floatValue];
        total += f;
    }
}


- (void)drawRect:(CGRect)rect
{
    [self removeNegitiveValues];
    [self adjustOptions];
    [self adjustHeightnWidth];
    [self addSegments];
}

-(void)addSegments
{
    CGFloat angleSize = 2*M_PI;
    int initialY = 0;
    
    for (int i = 0; i<options.count; i++)
    {
        UIColor *currentColor = [self colorForSegment];
        
        float value = ([options[i]floatValue]/total)*100;
        CGFloat angle = (angleSize/100)*value;
        
        PieSegment *seg = [[PieSegment alloc]initWithFrame:self.bounds];
        
        if (_sideValue_Bar == kSideValueBar_Show)
            [seg setFrame:CGRectMake(0, 0, self.bounds.size.width-60, self.bounds.size.height)];
        else
            [seg setFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        
        [seg setRad:(self.bounds.size.width-60)/2.5];
        [seg setStartA:previousAngle];
        [seg setEndA:previousAngle+angle];
        [seg setNColor:currentColor];
        
        seg.value = options[i];
        seg.tag = i;

        seg.value = [NSString stringWithFormat:@"%i",i];
        seg.backgroundColor = [UIColor clearColor];
        [self addSubview:seg];
        [seg setNeedsDisplay];
        seg.delegate = self;
        previousAngle = previousAngle+angle;
        
        if (_sideValue_Bar == kSideValueBar_Show)
        {
            float value = ([options[i]floatValue]/total)*100;
            
            UILabel *priLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, initialY, 60, 20)];
            priLabel.textColor = currentColor;
            priLabel.font = [UIFont systemFontOfSize:12];
            if (i<_titleValues.count)
                priLabel.text = [NSString stringWithFormat:@"%@",_titleValues[i]];
            else
                priLabel.text = [NSString stringWithFormat:@"No Title"];
                
            
            UILabel *secLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, initialY+15, 60, 20)];
            secLabel.textColor = currentColor;
            secLabel.font = [UIFont systemFontOfSize:8];
            secLabel.text = [NSString stringWithFormat:@"(%0.2f%%)",value];
            
            [scrollView addSubview:priLabel];
            [scrollView addSubview:secLabel];
            
            initialY+=40;
        }
    }
}

-(UIColor *)colorForSegment
{
    CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
    
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1.0];
}


-(void)addLayers
{
    CGFloat angleSize = 2*M_PI;
    int initialY = 0;
    
    for (int i = 0; i<options.count; i++)
    {
        float value = ([options[i]floatValue]/total)*100;
        CGFloat angle = (angleSize/100)*value;
        
        PieSegmentLayer *seg = [PieSegmentLayer layer];
        
        if (_sideValue_Bar == kSideValueBar_Show)
            [seg setFrame:CGRectMake(0, 0, self.bounds.size.width-60, self.bounds.size.height)];
        else
            [seg setFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        
        [seg setRad:(self.bounds.size.width-60)/2.5];
        [seg setStartA:previousAngle];
        [seg setEndA:previousAngle+angle];
        [seg setMyColor:colorArray[i]];
        
        seg.shadowOffset = CGSizeMake(0, 3);
        seg.shadowRadius = 3.0;
        seg.shadowColor = [UIColor blackColor].CGColor;
        seg.shadowOpacity = 0.7;
        [seg setValue:[NSNumber numberWithFloat:.9999]
           forKeyPath:@"transform.scale"];
        seg.value = [NSString stringWithFormat:@"%i",i];
        seg.backgroundColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:seg];
        [seg setNeedsDisplay];
        previousAngle = previousAngle+angle;
        
        if (_sideValue_Bar == kSideValueBar_Show)
        {
            float value = ([options[i]floatValue]/total)*100;
            
            UILabel *priLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, initialY, 60, 20)];
            priLabel.textColor = colorArray[i];
            priLabel.font = [UIFont systemFontOfSize:12];
            priLabel.text = [NSString stringWithFormat:@"%0.2f",[options[i] floatValue]];
            
            UILabel *secLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, initialY+15, 60, 20)];
            secLabel.textColor = colorArray[i];
            secLabel.font = [UIFont systemFontOfSize:8];
            secLabel.text = [NSString stringWithFormat:@"(%0.2f%%)",value];
            
            [scrollView addSubview:priLabel];
            [scrollView addSubview:secLabel];
            
            initialY+=40;
        }
    }
}

-(void)showSegmentInfoAtPoint:(CGPoint)centerPoint withText:(NSString *)text
{
    NSArray *arraySubviews = [self subviews];
    for (PieSegment *segment in arraySubviews)
    {
        if ([segment isKindOfClass:[PieSegment class]])
        {
            if (segment.tag != [text intValue])
                [segment refreshSegment:segment];
        }
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_segment_Selection == kSegmentSelection_On)
    {
        CGPoint p = [(UITouch*)[touches anyObject] locationInView:self];
        for (PieSegmentLayer *layer in self.layer.sublayers)
        {
            if ([layer isKindOfClass:[PieSegmentLayer class]])
            {
                [layer updateSegments];
                if (![layer containsPoint:p])
                {
                    [layer refreshSegment:layer];
                }
                
            }
        }
    }
}

@end
