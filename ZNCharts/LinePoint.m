//
//  LinePoint.m
//  MTBCCharts
//
//  Created by waris on 3/22/14.
//  Copyright (c) 2014 MTBC. All rights reserved.
//

#import "LinePoint.h"

@interface LinePoint()
{
    UIBezierPath *path;
    CGPoint center;
}
@end

@implementation LinePoint

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    CGRect box = CGRectInset(self.bounds, self.bounds.size.width * 0.1f, self.bounds.size.height * 0.1f);
    path = [UIBezierPath bezierPathWithOvalInRect:box];
    [[UIColor lightGrayColor] setFill];
    [path stroke];
    [path fill];
    [self setBackgroundColor:[UIColor clearColor]];
}




@end
