//
//  DoughNutSegment.h
//  MTBCCharts
//
//  Created by waris on 3/27/14.
//  Copyright (c) 2014 MTBC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DoughNutSegment : UIView
{
    CGPoint cen;
    CGFloat rad;
    CGFloat startA;
    CGFloat endA;
    BOOL clockW;
    UIColor *newColor;
    UIBezierPath *path1;
    UIBezierPath *path2;
}
- (id)initWithFrame:(CGRect)frame andWithCenter:(CGPoint)center radius:(CGFloat)raduis
         startAngle:(CGFloat)sAngle endAngle:(CGFloat)eAngle andColor:(UIColor *)color;
@end
