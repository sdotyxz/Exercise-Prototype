//
//  StretchViewController.h
//  Exercise1.01
//
//  Created by Tan Fuutou on 12-03-30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StretchViewController;

@protocol StretchDelegate <NSObject>

- (void)stretchViewController:(StretchViewController *)sender
                feedbackTimes:(int)times;

@end

@interface StretchViewController : UIViewController

@property (nonatomic, weak) id <StretchDelegate> delegate;

@end
