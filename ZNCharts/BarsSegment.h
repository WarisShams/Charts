//
//  BarsSegment.h
//  MTBCCharts
//
//  Created by waris on 3/26/14.
//  Copyright (c) 2014 MTBC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BarSegmentDelegate
-(void)barSegmentTouched:(int)tag;
@end

@interface BarsSegment : UIView
@property (nonatomic,assign) id<BarSegmentDelegate>delegate;
@property (nonatomic,strong) UIColor *color;
- (id)initWithHeight:(float)height withX:(float)x withY:(float)y;;
@end
