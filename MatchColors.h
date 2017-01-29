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

- (void)init:(NSMutableDictionary *)mainDict compDict:(NSMutableDictionary *)compDict;

- (float)colorDiffByRGB;

- (float)colorDiffByHSB;

- (float)colorDiffByRGBAndHue;

- (float)colorDiffByRGBAndHSB;

- (float)colorDiffByRGBW;

- (float)colorDiffByRGBWAndHSB;

- (float)colorDiffByHue;

@end
