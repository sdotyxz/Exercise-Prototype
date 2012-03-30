//
//  SquatdownViewController.h
//  Exercise1.01
//
//  Created by Tan Fuutou on 12-03-30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SquatdownViewController;

@protocol SquatDelegate <NSObject>

- (void)squatdownViewController:(SquatdownViewController *)sender
               feedbackTimes:(int)times;

@end

@interface SquatdownViewController : UIViewController

@property (nonatomic, weak) id <SquatDelegate> delegate;

@end
