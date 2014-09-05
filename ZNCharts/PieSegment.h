//
//  PieSegment.h
//  MTBCCharts
//
//  Created by waris on 3/19/14.
//  Copyright (c) 2014 MTBC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SegmentDelegate
-(void)showSegmentInfoAtPoint:(CGPoint)centerPoint withText:(NSString *)text;
@end

@interface PieSegment : UIView
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

-(void)refreshSegment:(PieSegment *)aSegment;

@property (nonatomic) CGFloat rad;
@property (nonatomic) CGFloat startA;
@property (nonatomic) CGFloat endA;
@property (nonatomic,strong) UIColor* nColor;

@property (nonatomic,assign)id<SegmentDelegate>delegate;
@property (nonatomic,weak)NSString *value;
@end
 