//
//  EModeChooseViewController.m
//  Exercise1.01
//
//  Created by Tan Fuutou on 12-03-30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EModeChooseViewController.h"
#import "DumbbellViewController.h"
#import "SquatdownViewController.h"
#import "StretchViewController.h"
#import "User.h"

@interface EModeChooseViewController() <DumbbellDelegate, SquatDelegate, StretchDelegate>

@property (nonatomic) int dumbbellTotal;
@property (nonatomic) int squatdownTotal;
@property (nonatomic) int stretchTotal;

@end

@implementation EModeChooseViewController

@synthesize dumbbellTotal = _dumbbellTotal;
@synthesize squatdownTotal = _squatdownTotal;
@synthesize stretchTotal = _stretchTotal;

@synthesize userName = _userName;
@synthesize userRecord= _userRecord;
@synthesize delegate = _delegate;


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"doDumbbell"]) {
        DumbbellViewController *dumbbell = (DumbbellViewController *)segue.destinationViewController;
        dumbbell.delegate = self;
    } else if ([segue.identifier isEqualToString:@"doSquatdown"]) {
        SquatdownViewController *squatdown = (SquatdownViewController *)segue.destinationViewController;
        squatdown.delegate = self;
    } else if ([segue.identifier isEqualToString:@"doStretch"]) {
        StretchViewController *stretch = (StretchViewController *)segue.destinationViewController;
        stretch.delegate = self;
    }
}

- (void)dumbbellViewController:(DumbbellViewController *)sender feedbackTimes:(int)times
{
    self.dumbbellTotal += times;
}

- (void)squatdownViewController:(SquatdownViewController *)sender feedbackTimes:(int)times
{
    self.squatdownTotal += times;
}

- (void)stretchViewController:(StretchViewController *)sender feedbackTimes:(int)times
{
    self.stretchTotal += times;
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    self.userRecord = [User formatUserInfo:self.userName 
                             dumbbellTimes:[NSNumber numberWithInt:self.dumbbellTotal] 
                            squatdownTimes:[NSNumber numberWithInt:self.squatdownTotal] 
                              stretchTimes:[NSNumber numberWithInt:self.stretchTotal]];
    NSLog(@"%@",self.userRecord);
    [self.delegate EModeChooseController:self feedbackUserRecord:self.userRecord];
    self.dumbbellTotal = 0;
    self.squatdownTotal = 0;
    self.stretchTotal = 0;
}

@end
