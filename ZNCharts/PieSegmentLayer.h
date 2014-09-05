//
//  PieSegmentLayer.h
//  MTBCCharts
//
//  Created by waris on 4/10/14.
//  Copyright (c) 2014 MTBC. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@protocol SegmentLayerDelegate
-(void)showSegmentInfoAtPoint:(CGPoint)centerPoint withText:(NSString *)text;
@end

@interface PieSegmentLayer : CALayer
{
    CGPoint cen;
    CGFloat rad;
    CGFloat startA;
    CGFloat endA;
    BOOL clockW;
    UIColor *newColor;
    UIBezierPath *path;
    
    CGPoint arcCenter;
    
    BOOL isSegmentAnimated;
    
    UIBezierPath *currentPath;
}

@property (nonatomic) CGFloat rad;
@property (nonatomic) CGFloat startA;
@property (nonatomic) CGFloat endA;
@property (nonatomic,strong) UIColor* myColor;

@property (assign)id<SegmentLayerDelegate>delegate;
@property (nonatomic,weak)NSString *value;

-(void)updateSegments;
-(void)refreshSegment:(PieSegmentLayer *)aSegment;
@end
