//
//  MatchColors.m
//  PaintPicker
//
//  Created by Stuart Pineo on 1/28/17 (refactored from 9/6/15)
//  Copyright © 2017 Stuart Pineo. All rights reserved.
//
#import "MatchColors.h"

@implementation MatchColors


// colorDiffByRGB - Apply the RGB diff algorithm (the smaller the return value the better the match)
//
// d = sqrt((r2-r1)^2 + (g2-g1)^2 + (b2-b1)^2) on RGB
//
+ (float)colorDiffByRGB:(NSMutableDictionary *)mainDict compDict:(NSMutableDictionary *)compDict {
    double diff = sqrt(
                        pow(fabs([[mainDict valueForKey:@"red"]   floatValue] - [[compDict valueForKey:@"red"]   floatValue]),2) +
                        pow(fabs([[mainDict valueForKey:@"green"] floatValue] - [[compDict valueForKey:@"green"] floatValue]),2) +
                        pow(fabs([[mainDict valueForKey:@"blue"]  floatValue] - [[compDict valueForKey:@"blue"]  floatValue]),2)
                    );
    
    return (float)diff;
}

// colorDiffByHSB - Apply the HSB diff algorithm
//
// d = sqrt((h2-h1)^2 + (s2-s1)^2 + (b2-b1)^2) on HSB
//
+ (float)colorDiffByHSB:(NSMutableDictionary *)mainDict compDict:(NSMutableDictionary *)compDict {
    double diff = sqrt(
                       pow(fabs([[mainDict valueForKey:@"hue"]        floatValue] - [[compDict valueForKey:@"hue"]        floatValue]),2) +
                       pow(fabs([[mainDict valueForKey:@"saturation"] floatValue] - [[compDict valueForKey:@"saturation"] floatValue]),2) +
                       pow(fabs([[mainDict valueForKey:@"brightness"] floatValue] - [[compDict valueForKey:@"brightness"] floatValue]),2)
                    );
    
    return (float)diff;
}

// colorDiffByRGBAndHue - Apply the HSB and Hue diff algorithm
//
// d = sqrt((r2-r1)^2 + (g2-g1)^2 + (b2-b1)^2 + (h2-h1)^2) on RGB + Hue
//
+ (float)colorDiffByRGBAndHue:(NSMutableDictionary *)mainDict compDict:(NSMutableDictionary *)compDict {
    double diff = sqrt(
                       pow(fabs([[mainDict valueForKey:@"red"]   floatValue] - [[compDict valueForKey:@"red"]   floatValue]),2) +
                       pow(fabs([[mainDict valueForKey:@"green"] floatValue] - [[compDict valueForKey:@"green"] floatValue]),2) +
                       pow(fabs([[mainDict valueForKey:@"blue"]  floatValue] - [[compDict valueForKey:@"blue"]  floatValue]),2) +
                       pow(fabs([[mainDict valueForKey:@"hue"]   floatValue] - [[compDict valueForKey:@"hue"]   floatValue]),2)
                    );
    
    return (float)diff;
}

// colorDiffByRGBAndHue - Apply the HSB and Hue diff algorithm
//
// d = sqrt((r2-r1)^2 + (g2-g1)^2 + (b2-b1)^2 + (h2-h1)^2 + (s2-s1)^2 + (br2-br1)^2) on RGB + HSB
//
+ (float)colorDiffByRGBAndHSB:(NSMutableDictionary *)mainDict compDict:(NSMutableDictionary *)compDict {
    double diff = sqrt(
                       pow(fabs([[mainDict valueForKey:@"red"]        floatValue] - [[compDict valueForKey:@"red"]        floatValue]),2) +
                       pow(fabs([[mainDict valueForKey:@"green"]      floatValue] - [[compDict valueForKey:@"green"]      floatValue]),2) +
                       pow(fabs([[mainDict valueForKey:@"blue"]       floatValue] - [[compDict valueForKey:@"blue"]       floatValue]),2) +
                       pow(fabs([[mainDict valueForKey:@"hue"]        floatValue] - [[compDict valueForKey:@"hue"]        floatValue]),2) +
                       pow(fabs([[mainDict valueForKey:@"saturation"] floatValue] - [[compDict valueForKey:@"saturation"] floatValue]),2) +
                       pow(fabs([[mainDict valueForKey:@"brightness"] floatValue] - [[compDict valueForKey:@"brightness"] floatValue]),2)
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
                       pow((fabs([[mainDict valueForKey:@"red"]   floatValue] - [[compDict valueForKey:@"red"]   floatValue]) * 0.30),2) +
                       pow((fabs([[mainDict valueForKey:@"green"] floatValue] - [[compDict valueForKey:@"green"] floatValue]) * 0.59),2) +
                       pow((fabs([[mainDict valueForKey:@"blue"]  floatValue] - [[compDict valueForKey:@"blue"]  floatValue]) * 0.11),2)
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
                       pow((fabs([[mainDict valueForKey:@"red"]       floatValue] - [[compDict valueForKey:@"red"]        floatValue]) * 0.30),2) +
                       pow((fabs([[mainDict valueForKey:@"green"]     floatValue] - [[compDict valueForKey:@"green"]      floatValue]) * 0.59),2) +
                       pow((fabs([[mainDict valueForKey:@"blue"]      floatValue] - [[compDict valueForKey:@"blue"]       floatValue]) * 0.11),2) +
                       pow(fabs([[mainDict valueForKey:@"hue"]        floatValue] - [[compDict valueForKey:@"hue"]        floatValue]),2) +
                       pow(fabs([[mainDict valueForKey:@"saturation"] floatValue] - [[compDict valueForKey:@"saturation"] floatValue]),2) +
                       pow(fabs([[mainDict valueForKey:@"brightness"] floatValue] - [[compDict valueForKey:@"brightness"] floatValue]),2)
                       );
    
    return (float)diff;
}

// colorDiffByHue - Diff by Hue only
//
// d = sqrt((h2-h1)^2)
//
+ (float)colorDiffByHue:(NSMutableDictionary *)mainDict compDict:(NSMutableDictionary *)compDict {
    double diff = sqrt(
                       pow(fabs([[mainDict valueForKey:@"hue"]   floatValue] - [[compDict valueForKey:@"hue"]   floatValue]),2)
                       );
    
    return (float)diff;
}

@end
