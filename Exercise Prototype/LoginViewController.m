//
//  LoginViewController.m
//  Exercise1.01
//
//  Created by Tan Fuutou on 12-03-30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController() <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;

@end


@implementation LoginViewController

@synthesize usernameTextField = _usernameTextField;
@synthesize username = _username;
@synthesize delegate = _delegate;

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.username = textField.text;
    if (![textField.text length]) {
        [[self presentingViewController] dismissModalViewControllerAnimated:YES];
    } else {
        [self.delegate LoginController:self LoginUser:self.username];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField.text length]) {
        [textField resignFirstResponder];
        return YES;
    }else{
        return NO;
    }
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.usernameTextField.delegate = self;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.usernameTextField becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    //pass the username back to the welcomepage and fetch the data form the database
    
}


- (void)viewDidUnload {
    [self setUsernameTextField:nil];
    [super viewDidUnload];
}
@end
