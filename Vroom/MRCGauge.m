//
//  MRCGauge.m
//  Vroom
//
//  Created by Marty Cullen on 8/15/14.
//  Copyright (c) 2014 MartyCullen.Com. All rights reserved.
//

#import "MRCGauge.h"

@implementation MRCGauge

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.color = [UIColor colorWithRed:0.1 green:1.0 blue:0.1 alpha:1];
        self.backgroundColor = [UIColor clearColor];
        self.startAngle = 90;
        self.progress = 0.0;
        self.priorProgress = 0.0;
        self.duration = 1.0;
        self.parts = 20;
        
        self.arcLayer	= [CAShapeLayer layer];
        self.arcLayer.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        //self.arcLayer.backgroundColor = [[UIColor redColor] CGColor];
        [self.layer addSublayer:self.arcLayer];

        CGRect labelRect = CGRectMake(frame.size.width/3.0, frame.size.height/3.0, frame.size.width/3.0, frame.size.height/3.0);
        self.label = [[UILabel alloc] initWithFrame:labelRect];
        self.label.textColor = self.color;
        [self addSubview:self.label];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void) setProgress:(CGFloat)progress
{
    [self setProgress:progress animated:NO];
}

- (void) setProgress:(CGFloat)progress animated:(BOOL)animated
{
    _progress = progress;
    
    self.label.text = [NSString stringWithFormat:@"%2.0f %%", 100*progress];
    
    if ( animated )
    {
        [self animateGauge];
    } else {
        [self drawStaticGauge:progress];
        self.priorProgress = progress;
    }

    [self setNeedsDisplay];
}

- (void) drawStaticGauge:(CGFloat)value
{
    CGFloat toDegrees = self.startAngle + (360 * value);
//    NSLog(@"START %f", self.startAngle);
//    NSLog(@"PROGRESS %f %f %f ", value, (360 * value), self.startAngle + (360 * value));
//    NSLog(@"TO %f", toDegrees);
    
    CGFloat radius = self.frame.size.width/2 - ((self.frame.size.width/2)*0.3);
    
    CGMutablePathRef newPath = CGPathCreateMutable();
    CGFloat start = DEGREES_TO_RADIANS(self.startAngle);
    CGFloat end = DEGREES_TO_RADIANS(toDegrees);
    CGPathAddArc(newPath, nil, self.frame.size.width/2, self.frame.size.height/2, radius, start, end, 0);

    self.arcLayer.strokeColor = [self.color CGColor];
    self.arcLayer.lineWidth = self.arcLayer.frame.size.width/2 - (radius + 2);;
    self.arcLayer.path = newPath;
}

- (void) animateGauge
{
    self.currentPart = 1;
    self.partSize = (self.progress - self.priorProgress)/(float)self.parts;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.duration/self.parts
                                                  target:self
                                                selector:@selector(updateGaugeInterval:)
                                                userInfo:nil
                                                 repeats:YES];

}

- (void) updateGaugeInterval:(NSTimer*)timer
{
    CGFloat newProgress = self.priorProgress + (self.currentPart * self.partSize);
    [self drawStaticGauge:newProgress];
    
    if ( self.parts <= self.currentPart )
    {
        [timer invalidate];
        self.priorProgress = self.progress;
    }
    self.currentPart += 1;

}

- (void) animateGaugeWonky
{
    NSLog(@"START %f", self.startAngle);
    NSLog(@"PRIOR %f %f %f ", self.priorProgress, (360 * self.priorProgress), self.startAngle + (360 * self.priorProgress));
    NSLog(@"PROGRESS %f %f %f ", self.progress, (360 * self.progress), self.startAngle + (360 * self.progress));
    CGFloat fromDegrees = self.startAngle + (360 * self.priorProgress);
    CGFloat toDegrees = self.startAngle + (360 * self.progress);
    NSLog(@"FROM %f TO %f", fromDegrees, toDegrees);
    
    CGFloat radius = self.frame.size.width/2 - ((self.frame.size.width/2)*0.3);
    
    CGMutablePathRef basePath = CGPathCreateMutable();
    CGFloat start = DEGREES_TO_RADIANS(self.startAngle);
    CGFloat end = DEGREES_TO_RADIANS(fromDegrees);
    CGPathAddArc(basePath, nil, self.frame.size.width/2, self.frame.size.height/2, radius, start, end, 0);
    
    CGMutablePathRef newPath = CGPathCreateMutable();
    start = DEGREES_TO_RADIANS(self.startAngle);
    end = DEGREES_TO_RADIANS(toDegrees);
    CGPathAddArc(newPath, nil, self.frame.size.width/2, self.frame.size.height/2, radius, start, end, 0);
    
    NSString* keyPath = @"path";
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:keyPath];
    [animation setDuration:1.0];
    [animation setFromValue:(__bridge id)basePath];
    [animation setToValue:(__bridge id)newPath];
    
    self.arcLayer.strokeColor = [self.color CGColor];
    self.arcLayer.lineWidth = self.arcLayer.frame.size.width/2 - (radius + 2);;
    self.arcLayer.path = newPath;
    [self.arcLayer addAnimation:animation forKey:keyPath];
    
}

@end
