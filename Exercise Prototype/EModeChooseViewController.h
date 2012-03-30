//
//  EModeChooseViewController.h
//  Exercise1.01
//
//  Created by Tan Fuutou on 12-03-30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EModeChooseViewController;

@protocol EModeChooseDelegate <NSObject>

- (void)EModeChooseController:(EModeChooseViewController *)sender
           feedbackUserRecord:(NSDictionary *)record;

@end

@interface EModeChooseViewController : UIViewController

@property (nonatomic, strong) NSString *userName;
@property (nonatomic, copy) NSDictionary *userRecord;
@property (nonatomic, weak) id <EModeChooseDelegate> delegate;

@end
