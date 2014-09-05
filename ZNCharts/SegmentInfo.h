//
//  SegmentInfo.h
//  MTBCCharts
//
//  Created by waris on 3/20/14.
//  Copyright (c) 2014 MTBC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SegmentInfo : UIView
{
    NSString *textString;
}
- (id)initWithFrame:(CGRect)frame andCenter:(CGPoint)center andText:(NSString *)text;
@end
