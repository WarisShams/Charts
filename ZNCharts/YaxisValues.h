//
//  YaxisValues.h
//  MTBCCharts
//
//  Created by waris on 3/25/14.
//  Copyright (c) 2014 MTBC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YaxisValues : UIView
{
    float difference;
    float yScale;
}
- (id)initWithFrame:(CGRect)frame andDifference:(float)diff withScale:(float)scale;
@end
