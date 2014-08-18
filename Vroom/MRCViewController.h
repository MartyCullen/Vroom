//
//  MRCViewController.h
//  Vroom
//
//  Created by Marty Cullen on 8/15/14.
//  Copyright (c) 2014 MartyCullen.Com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MRCGauge.h"

@interface MRCViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UISegmentedControl *animation;

@property (weak, nonatomic) IBOutlet UIView *logoView;
@property (nonatomic, strong) MRCGauge* guage;

- (IBAction)animationChanged:(id)sender;
@end
