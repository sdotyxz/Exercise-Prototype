//
//  DumbbellViewController.h
//  Exercise1.01
//
//  Created by Tan Fuutou on 12-03-30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DumbbellViewController;

@protocol DumbbellDelegate <NSObject>

- (void)dumbbellViewController:(DumbbellViewController *)sender
               feedbackTimes:(int)times;

@end

@interface DumbbellViewController : UIViewController

@property (nonatomic, weak) id <DumbbellDelegate> delegate;

@end
