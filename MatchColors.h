//
//  MatchColors.h
//  PaintPicker
//
//  Created by Stuart Pineo on 1/28/17 (refactored from 9/6/15)
//  Copyright © 2017 Stuart Pineo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MatchColors : NSObject

+ (float)colorDiffByRGB:(NSMutableDictionary *)mainDict compDict:(NSMutableDictionary *)compDict;

+ (float)colorDiffByHSB:(NSMutableDictionary *)mainDict compDict:(NSMutableDictionary *)compDict;

+ (float)colorDiffByRGBAndHue:(NSMutableDictionary *)mainDict compDict:(NSMutableDictionary *)compDict;

+ (float)colorDiffByRGBAndHSB:(NSMutableDictionary *)mainDict compDict:(NSMutableDictionary *)compDict;

+ (float)colorDiffByRGBW:(NSMutableDictionary *)mainDict compDict:(NSMutableDictionary *)compDict;

+ (float)colorDiffByRGBWAndHSB:(NSMutableDictionary *)mainDict compDict:(NSMutableDictionary *)compDict;

+ (float)colorDiffByHue:(NSMutableDictionary *)mainDict compDict:(NSMutableDictionary *)compDict;

@end
