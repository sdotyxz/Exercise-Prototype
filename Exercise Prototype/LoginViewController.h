//
//  LoginViewController.h
//  Exercise1.01
//
//  Created by Tan Fuutou on 12-03-30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LoginViewController;

@protocol LoginDelegate <NSObject>

- (void)LoginController:(LoginViewController *)sender
              LoginUser:(NSString *)username;

@end

@interface LoginViewController : UIViewController

@property (nonatomic, copy)NSString *username;

@property (nonatomic, weak) id <LoginDelegate> delegate;


@end
