//
//  DumbbellViewController.m
//  Exercise1.01
//
//  Created by Tan Fuutou on 12-03-30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DumbbellViewController.h"
#import "CMMotionManager+Shared.h"

@interface DumbbellViewController()

@property (nonatomic) int workTimes;
@property (nonatomic) double moveLength;
@property (weak, nonatomic) IBOutlet UILabel *showTimesLabel;

@end

@implementation DumbbellViewController


@synthesize workTimes = _workTimes;
@synthesize moveLength = _moveLength;
@synthesize showTimesLabel = _showTimesLabel;
@synthesize delegate = _delegate;

#define WATCH_HZ 50
#define SENSER_RATE 0.085

- (double)dataRounding:(double)rawData afterPoint:(int)point
{
    rawData = round(rawData * point) / point;
    return rawData;
}

- (void)startEexercise
{
    CMMotionManager *manager = [CMMotionManager sharedMotionManager];
    if ([manager isDeviceMotionAvailable]) {
        [manager setDeviceMotionUpdateInterval:1.0/WATCH_HZ];
        [manager startDeviceMotionUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMDeviceMotion *data, NSError *error) {
            //do something
            double movement;
            movement = pow(0.5 * ([self dataRounding:data.userAcceleration.x afterPoint:10] * 9.8) * pow(manager.deviceMotionUpdateInterval, 2), 2) 
            + pow(0.5 * ([self dataRounding:data.userAcceleration.y afterPoint:10] * 9.8) * pow(manager.deviceMotionUpdateInterval, 2), 2) 
            + pow(0.5 * ([self dataRounding:data.userAcceleration.z afterPoint:10] * 9.8) * pow(manager.deviceMotionUpdateInterval, 2), 2);
            movement = sqrt(movement);
            NSLog(@"%10.10f", movement);
            self.moveLength += movement;
            if (self.moveLength > SENSER_RATE)
            {
                self.workTimes ++;
                self.moveLength = 0;
            }
            self.showTimesLabel.text = [NSString stringWithFormat:@"Total = %d", self.workTimes];
        }];
    }
}

- (IBAction)switch:(UISwitch *)sender 
{
    if (sender.on)
    {
        [self startEexercise];
    } else {
        [[CMMotionManager sharedMotionManager] stopDeviceMotionUpdates];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.delegate dumbbellViewController:self feedbackTimes:self.workTimes ];
    [[CMMotionManager sharedMotionManager] stopDeviceMotionUpdates];

}

- (void)viewDidUnload {
    [self setShowTimesLabel:nil];
    [super viewDidUnload];
}

@end
