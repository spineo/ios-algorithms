//
//  MatchColors.m
//  PaintPicker
//
//  Created by Stuart Pineo on 1/28/17 (refactored from 9/6/15)
//  Copyright © 2017 Stuart Pineo. All rights reserved.
//
#import "MatchColors.h"

@implementation MatchColors


// Required Keys below, methods use NSMutableDictionary
//
NSString * const RED        = @"red";
NSString * const GREEN      = @"green";
NSString * const BLUE       = @"blue";
NSString * const HUE        = @"hue";
NSString * const SATURATION = @"saturation";
NSString * const BRIGHTNESS = @"brightness";


// Weights (for weighted diffs)
//
CGFloat const RED_WGT       = 0.30;
CGFloat const GREEN_WGT     = 0.59;
CGFloat const BLUE_WGT      = 0.11;


// colorDiffByRGB - Apply the RGB diff algorithm (the smaller the return value the better the match)
//
// d = sqrt((r2-r1)^2 + (g2-g1)^2 + (b2-b1)^2) on RGB
//
+ (float)colorDiffByRGB:(NSMutableDictionary *)mainDict compDict:(NSMutableDictionary *)compDict {
    double diff = sqrt(
                        pow(fabs([[mainDict valueForKey:RED]   floatValue] - [[compDict valueForKey:RED]   floatValue]),2) +
                        pow(fabs([[mainDict valueForKey:GREEN] floatValue] - [[compDict valueForKey:GREEN] floatValue]),2) +
                        pow(fabs([[mainDict valueForKey:BLUE]  floatValue] - [[compDict valueForKey:BLUE]  floatValue]),2)
                    );
    
    return (float)diff;
}

// colorDiffByHSB - Apply the HSB diff algorithm
//
// d = sqrt((h2-h1)^2 + (s2-s1)^2 + (b2-b1)^2) on HSB
//
+ (float)colorDiffByHSB:(NSMutableDictionary *)mainDict compDict:(NSMutableDictionary *)compDict {
    double diff = sqrt(
                       pow(fabs([[mainDict valueForKey:HUE]        floatValue] - [[compDict valueForKey:HUE]        floatValue]),2) +
                       pow(fabs([[mainDict valueForKey:SATURATION] floatValue] - [[compDict valueForKey:SATURATION] floatValue]),2) +
                       pow(fabs([[mainDict valueForKey:BRIGHTNESS] floatValue] - [[compDict valueForKey:BRIGHTNESS] floatValue]),2)
                    );
    
    return (float)diff;
}

// colorDiffByRGBAndHue - Apply the HSB and Hue diff algorithm
//
// d = sqrt((r2-r1)^2 + (g2-g1)^2 + (b2-b1)^2 + (h2-h1)^2) on RGB + Hue
//
+ (float)colorDiffByRGBAndHue:(NSMutableDictionary *)mainDict compDict:(NSMutableDictionary *)compDict {
    double diff = sqrt(
                       pow(fabs([[mainDict valueForKey:RED]   floatValue] - [[compDict valueForKey:RED]   floatValue]),2) +
                       pow(fabs([[mainDict valueForKey:GREEN] floatValue] - [[compDict valueForKey:GREEN] floatValue]),2) +
                       pow(fabs([[mainDict valueForKey:BLUE]  floatValue] - [[compDict valueForKey:BLUE]  floatValue]),2) +
                       pow(fabs([[mainDict valueForKey:HUE]   floatValue] - [[compDict valueForKey:HUE]   floatValue]),2)
                    );
    
    return (float)diff;
}

// colorDiffByRGBAndHue - Apply the HSB and Hue diff algorithm
//
// d = sqrt((r2-r1)^2 + (g2-g1)^2 + (b2-b1)^2 + (h2-h1)^2 + (s2-s1)^2 + (br2-br1)^2) on RGB + HSB
//
+ (float)colorDiffByRGBAndHSB:(NSMutableDictionary *)mainDict compDict:(NSMutableDictionary *)compDict {
    double diff = sqrt(
                       pow(fabs([[mainDict valueForKey:RED]        floatValue] - [[compDict valueForKey:RED]        floatValue]),2) +
                       pow(fabs([[mainDict valueForKey:GREEN]      floatValue] - [[compDict valueForKey:GREEN]      floatValue]),2) +
                       pow(fabs([[mainDict valueForKey:BLUE]       floatValue] - [[compDict valueForKey:BLUE]       floatValue]),2) +
                       pow(fabs([[mainDict valueForKey:HUE]        floatValue] - [[compDict valueForKey:HUE]        floatValue]),2) +
                       pow(fabs([[mainDict valueForKey:SATURATION] floatValue] - [[compDict valueForKey:SATURATION] floatValue]),2) +
                       pow(fabs([[mainDict valueForKey:BRIGHTNESS] floatValue] - [[compDict valueForKey:BRIGHTNESS] floatValue]),2)
                       );
    
    return (float)diff;
}

// colorDiffByRGBW - Weighted on RGB only
//
// d = ((r2-r1)*0.30)^2
//  + ((g2-g1)*0.59)^2
//  + ((b2-b1)*0.11)^2
//
+ (float)colorDiffByRGBW:(NSMutableDictionary *)mainDict compDict:(NSMutableDictionary *)compDict {
    double diff = sqrt(
                       pow((fabs([[mainDict valueForKey:RED]   floatValue] - [[compDict valueForKey:RED]   floatValue]) * RED_WGT),  2) +
                       pow((fabs([[mainDict valueForKey:GREEN] floatValue] - [[compDict valueForKey:GREEN] floatValue]) * GREEN_WGT),2) +
                       pow((fabs([[mainDict valueForKey:BLUE]  floatValue] - [[compDict valueForKey:BLUE]  floatValue]) * BLUE_WGT), 2)
                       );
    
    return (float)diff;
}

// colorDiffByRGBWAndHSB - Weighted on RGB + HSB
//
// d = ((r2-r1)*0.30)^2
//  + ((g2-g1)*0.59)^2
//  + ((b2-b1)*0.11)^2
// Plus HSB diff
//
+ (float)colorDiffByRGBWAndHSB:(NSMutableDictionary *)mainDict compDict:(NSMutableDictionary *)compDict {
    double diff = sqrt(
                       pow((fabs([[mainDict valueForKey:RED]       floatValue] - [[compDict valueForKey:RED]        floatValue]) * RED_WGT),  2) +
                       pow((fabs([[mainDict valueForKey:GREEN]     floatValue] - [[compDict valueForKey:GREEN]      floatValue]) * GREEN_WGT),2) +
                       pow((fabs([[mainDict valueForKey:BLUE]      floatValue] - [[compDict valueForKey:BLUE]       floatValue]) * BLUE_WGT), 2) +
                       pow(fabs([[mainDict valueForKey:HUE]        floatValue] - [[compDict valueForKey:HUE]        floatValue]),2) +
                       pow(fabs([[mainDict valueForKey:SATURATION] floatValue] - [[compDict valueForKey:SATURATION] floatValue]),2) +
                       pow(fabs([[mainDict valueForKey:BRIGHTNESS] floatValue] - [[compDict valueForKey:BRIGHTNESS] floatValue]),2)
                       );
    
    return (float)diff;
}

// colorDiffByHue - Diff by Hue only
//
// d = sqrt((h2-h1)^2)
//
+ (float)colorDiffByHue:(NSMutableDictionary *)mainDict compDict:(NSMutableDictionary *)compDict {
    double diff = sqrt(
                       pow(fabs([[mainDict valueForKey:HUE]   floatValue] - [[compDict valueForKey:HUE]   floatValue]),2)
                       );
    
    return (float)diff;
}

@end
