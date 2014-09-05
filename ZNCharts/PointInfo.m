//
//  PointInfo.m
//  MTBCCharts
//
//  Created by waris on 3/22/14.
//  Copyright (c) 2014 MTBC. All rights reserved.
//

#import "PointInfo.h"

@implementation PointInfo

- (id)initWithFrame:(CGRect)frame andCenter:(CGPoint)center andText:(NSString *)text;
{
    self = [super initWithFrame:frame];
    if (self) {
        self.center = center;
        textString= text;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    UIFont* font = [UIFont fontWithName:@"Helvetica-Light" size:10];
    UIColor* textColor = [UIColor whiteColor];
    NSDictionary* stringAttrs = @{ NSFontAttributeName : font, NSForegroundColorAttributeName : textColor };
    NSAttributedString* attrStr = [[NSAttributedString alloc] initWithString:textString attributes:stringAttrs];
    [attrStr drawAtPoint:CGPointMake(0, 0)];
}


@end
