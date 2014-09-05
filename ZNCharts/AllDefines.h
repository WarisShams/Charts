//
//  AllDefines.h
//  MTBCCharts
//
//  Created by waris on 3/25/14.
//  Copyright (c) 2014 MTBC. All rights reserved.
//

#ifndef MTBCCharts_AllDefines_h
#define MTBCCharts_AllDefines_h

#define SPACE_BETWEEN_XAXIS_VALUES 30
#define XAXIS_BAR_HEIGHT 30
#define YAXIS_BAR_WIDTH 30

#define NUMBER_OF_YAXIS_VALUES 10

#define BAR_WIDTH 20

#define SPACE_BETWEEN_BARS 25
#define SPACE_BETWEEN_BARGROUPS 20

typedef enum : NSUInteger
{
    kShadowOfSegments_Hide,
    kShadowOfSegments_Show,
} SegmentShadow;

typedef enum : NSUInteger
{
    kSideValueBar_Hide,
    kSideValueBar_Show,
} SideValueBar;

typedef enum : NSUInteger
{
    kSegmentSelection_On,
    kSegmentSelection_Off,
} SegmentSelection;

#endif
