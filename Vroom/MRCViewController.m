//
//  MRCViewController.m
//  Vroom
//
//  Created by Marty Cullen on 8/15/14.
//  Copyright (c) 2014 MartyCullen.Com. All rights reserved.
//

#import "MRCViewController.h"

@interface MRCViewController ()

@end

@implementation MRCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    CGRect gaugeRect = CGRectMake(100, 100, 100, 100);
    self.guage = [[MRCGauge alloc] initWithFrame:gaugeRect];
    
    [self.blackView addSubview:self.guage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sliderValueChanged:(id)sender {
    
}

- (IBAction)animationChanged:(id)sender {
    if ( 0 == self.animation.selectedSegmentIndex )
    {
        NSLog(@"Now");
        [self.guage setProgress:self.slider.value];
    } else {
        NSLog(@"Animated");
        [self.guage setProgress:self.slider.value animated:YES];
    }
}
@end
