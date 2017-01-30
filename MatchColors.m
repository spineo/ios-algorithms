//
//  MatchColors.m
//  PaintPicker
//
//  Created by Stuart Pineo on 1/28/17 (refactored from 9/6/15)
//  Copyright © 2017 Stuart Pineo. All rights reserved.
//
#import "MatchColors.h"

@interface MatchColors ()

@property (nonatomic, strong) NSMutableDictionary *mainDict, *compDict;

@end

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


// init - Set the two Mutable Dictionaries
//
- (void)setDict:(NSMutableDictionary *)mainDict compDict:(NSMutableDictionary *)compDict {
    [self setMainDict:mainDict];
    [self setCompDict:compDict];
}

// colorDiffByRGB - Apply the RGB diff algorithm (the smaller the return value the better the match)
//
// d = sqrt((r2-r1)^2 + (g2-g1)^2 + (b2-b1)^2) on RGB
//
- (float)colorDiffByRGB {
    return (float)sqrt(
                       [self compDiff:RED] + [self compDiff:GREEN] + [self compDiff:BLUE]
                       );
}

// colorDiffByHSB - Apply the HSB diff algorithm
//
// d = sqrt((h2-h1)^2 + (s2-s1)^2 + (b2-b1)^2) on HSB
//
- (float)colorDiffByHSB {
    return (float)sqrt(
                       [self compDiff:HUE] + [self compDiff:SATURATION] + [self compDiff:BRIGHTNESS]
                       );
}

// colorDiffByRGBAndHue - Apply the HSB and Hue diff algorithm
//
// d = sqrt((r2-r1)^2 + (g2-g1)^2 + (b2-b1)^2 + (h2-h1)^2) on RGB + Hue
//
- (float)colorDiffByRGBAndHue {
    return (float)sqrt(
                       [self compDiff:RED] + [self compDiff:GREEN] + [self compDiff:BLUE] + [self compDiff:HUE]
                       );
}

// colorDiffByRGBAndHue - Apply the HSB and Hue diff algorithm
//
// d = sqrt((r2-r1)^2 + (g2-g1)^2 + (b2-b1)^2 + (h2-h1)^2 + (s2-s1)^2 + (br2-br1)^2) on RGB + HSB
//
- (float)colorDiffByRGBAndHSB {
    return (float)sqrt(
                       [self compDiff:RED] + [self compDiff:GREEN] + [self compDiff:BLUE] +
                       [self compDiff:HUE] + [self compDiff:SATURATION] + [self compDiff:BRIGHTNESS]
                       );
}

// colorDiffByRGBW - Weighted on RGB only
//
// d = ((r2-r1)*RED_WGT)^2
//  + ((g2-g1)*GREEN_WGT)^2
//  + ((b2-b1)*BLUE_WGT)^2
//
- (float)colorDiffByRGBW {
    return (float)sqrt(
                       [self compDiffWgt:RED weight:RED_WGT] + [self compDiffWgt:GREEN weight:GREEN_WGT] + [self compDiffWgt:BLUE weight:BLUE_WGT]
                       );
}

// colorDiffByRGBWAndHSB - Weighted on RGB + HSB
//
// d = ((r2-r1)*RED_WGT)^2
//  + ((g2-g1)*GREEN_WGT)^2
//  + ((b2-b1)*BLUE_WGT)^2
// Plus HSB diff
//
- (float)colorDiffByRGBWAndHSB {
    return (float)sqrt(
                       [self compDiffWgt:RED weight:RED_WGT] + [self compDiffWgt:GREEN weight:GREEN_WGT] + [self compDiffWgt:BLUE weight:BLUE_WGT] +
                       [self compDiff:HUE] + [self compDiff:SATURATION] + [self compDiff:BRIGHTNESS]
                       );
}

// colorDiffByHue - Diff by Hue only
//
// d = sqrt((h2-h1)^2)
//
- (float)colorDiffByHue {
    return (float)sqrt(
                       [self compDiff:HUE]
                       );
}

// compDiff - Compute the difference
//
- (double)compDiff:(NSString *)color {
    return pow(fabs([[self.mainDict valueForKey:color] floatValue] - [[self.compDict valueForKey:color] floatValue]),2);
}

// compDiffWgt - Compute the difference with Weighted values added
//
- (double)compDiffWgt:(NSString *)color weight:(CGFloat)weight {
    return pow((fabs([[self.mainDict valueForKey:color] floatValue] - [[self.compDict valueForKey:color] floatValue]) * weight),2);
}

@end
