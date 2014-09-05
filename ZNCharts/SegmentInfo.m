//
//  SegmentInfo.m
//  MTBCCharts
//
//  Created by waris on 3/20/14.
//  Copyright (c) 2014 MTBC. All rights reserved.
//

#import "SegmentInfo.h"

@implementation SegmentInfo

- (id)initWithFrame:(CGRect)frame andCenter:(CGPoint)center andText:(NSString *)text
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.center = center;
        textString = text;
        self.layer.cornerRadius = 10;
        self.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    UIFont* font = [UIFont fontWithName:@"Helvetica" size:10];
    UIColor* textColor = [UIColor whiteColor];
    NSDictionary* stringAttrs = @{ NSFontAttributeName : font, NSForegroundColorAttributeName : textColor };
    NSAttributedString* attrStr = [[NSAttributedString alloc] initWithString:textString attributes:stringAttrs];
    [attrStr drawAtPoint:CGPointMake(0, 0)];
}

@end
