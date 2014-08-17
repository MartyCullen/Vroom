//
//  MRCGauge.h
//  Vroom
//
//  Created by Marty Cullen on 8/15/14.
//  Copyright (c) 2014 MartyCullen.Com. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface MRCGauge : UIView

@property (nonatomic, assign) CGFloat startAngle;
@property (nonatomic, assign) CGFloat priorProgress;
@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, strong) UILabel* label;
@property (nonatomic, strong) UIColor* color;
//@property (nonatomic, strong) CALayer* rootLayer;
@property (nonatomic, strong) CAShapeLayer* arcLayer;

- (void) setProgress:(CGFloat)progress animated:(BOOL)animated;

@end
