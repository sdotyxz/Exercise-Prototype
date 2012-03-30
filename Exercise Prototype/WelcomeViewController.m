//
//  WelcomeViewController.m
//  Exercise1.01
//
//  Created by Tan Fuutou on 12-03-29.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WelcomeViewController.h"
#import "LoginViewController.h"
#import "Edata+Update.h"
#import "User.h"
#import "EModeChooseViewController.h"

@interface WelcomeViewController() <LoginDelegate, EModeChooseDelegate>

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dumbbellLabel;
@property (weak, nonatomic) IBOutlet UILabel *squatdownLabel;
@property (weak, nonatomic) IBOutlet UILabel *stretchLabel;

@property (nonatomic, strong) NSString *userName;

@end

@implementation WelcomeViewController

@synthesize usernameLabel = _usernameLabel;
@synthesize dumbbellLabel = _dumbbellLabel;
@synthesize squatdownLabel = _squatdownLabel;
@synthesize stretchLabel = _stretchLabel;

@synthesize  userName = _userName;
@synthesize eDatabase = _eDatabase;


#pragma mark - Modal View Controller

// prepare for the modal view controller

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"login"]) {
        LoginViewController *user = (LoginViewController *)segue.destinationViewController;
        user.delegate = self;
    } else if ([segue.identifier isEqualToString:@"modeChange"]) {  
        EModeChooseViewController *user = (EModeChooseViewController *)segue.destinationViewController;
        user.delegate = self;
        user.userName = self.userName;
    }
}

// refresh the WelcomePage

- (void)refreshWelcome:(Edata *)userInfo
{
    self.usernameLabel.text = [NSString stringWithFormat:@"Welcome!! %@", userInfo.username];
    self.dumbbellLabel.text = [NSString stringWithFormat:@"Dumbbell %@", userInfo.dumbbell];
    self.squatdownLabel.text = [NSString stringWithFormat:@"Squat Down %@", userInfo.squatdown];
    self.stretchLabel.text = [NSString stringWithFormat:@"Stretch %@", userInfo.stretch];
}


#pragma mark - Database Usage

// 3. Open or create the document here
// We modify one which is much more generate                                                                                                       

- (void)useDocument
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:[self.eDatabase.fileURL path]]) {
        //does not exist on disk, so create it 
        [self.eDatabase saveToURL:self.eDatabase.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success){
            NSLog(@"The database is created");
        }];
    } else if (self.eDatabase.documentState == UIDocumentStateClosed) {
        // exists on disk, but we need to open it 
        [self.eDatabase openWithCompletionHandler:^(BOOL success){
            NSLog(@"The database is opened");
        }];
    } else if (self.eDatabase.documentState == UIDocumentStateNormal) {
        // already open and ready to use
        NSLog(@"The database is already opened");
    }
}

- (Edata *)chechDatabase:(UIManagedDocument *)database with:(NSString *)name
{
    Edata *checkResult;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Edata"];
    request.predicate = [NSPredicate predicateWithFormat:@"username = %@", name];
    
    NSError *error = nil;
    NSArray *result = [database.managedObjectContext executeFetchRequest:request error:&error];
    
    checkResult = [result lastObject];
    return checkResult;
}

- (IBAction)reset:(id)sender 
{
    Edata *data = [self chechDatabase:self.eDatabase with:self.userName];
    [self.eDatabase.managedObjectContext deleteObject:data];
    NSDictionary *initInfo = [User formatUserInfo:self.userName 
                                    dumbbellTimes:nil
                                   squatdownTimes:nil  
                                     stretchTimes:nil];
    data = [Edata dataWithuserInfo:initInfo inManagedObjectContext:self.eDatabase.managedObjectContext];
    [self refreshWelcome:data];
}


#pragma mark - Setter

// 2.Init our database

- (void)setEDatabase:(UIManagedDocument *)eDatabase
{
    if (_eDatabase != eDatabase) {
        _eDatabase = eDatabase;
        [self useDocument];
    }
}

#pragma mark - Delegate

- (void)LoginController:(LoginViewController *)sender LoginUser:(NSString *)username
{
    Edata *login = [self chechDatabase:self.eDatabase with:username];
    if (!login) {
        // add a new user into the database with username which was entered by the user 
        // and refresh the welcome page 
        NSDictionary *initInfo = [User formatUserInfo:username 
                                        dumbbellTimes:nil
                                       squatdownTimes:nil  
                                         stretchTimes:nil];
        login = [Edata dataWithuserInfo:initInfo inManagedObjectContext:self.eDatabase.managedObjectContext];
        [self refreshWelcome:login];
    } else {
        // refresh the welcome page with the user data
        [self refreshWelcome:login];
    }
    self.userName = login.username;
    [self dismissModalViewControllerAnimated:YES];
}

- (void)EModeChooseController:(EModeChooseViewController *)sender feedbackUserRecord:(NSDictionary *)record
{
    [Edata dataWithuserInfo:record inManagedObjectContext:self.eDatabase.managedObjectContext];
    Edata *feedbackInfo = [self chechDatabase:self.eDatabase with:[record objectForKey:USER_NAME]];
    if (self.view.window) {
        [self refreshWelcome:feedbackInfo];
    }
}

#pragma mark - View Controller LifeCycle

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 1.Everything start from here
    
    if (!self.eDatabase) {
        // Create a default database if none is set
        NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        url = [url URLByAppendingPathComponent:@"Default E Database"];
        // url is now "<Default E Database>/Default E Database"
        self.eDatabase = [[UIManagedDocument alloc] initWithFileURL:url];
        // setter will create this for us on disk
    }
}


- (void)viewDidUnload {
    [self setDumbbellLabel:nil];
    [self setUsernameLabel:nil];
    [self setSquatdownLabel:nil];
    [self setStretchLabel:nil];
    [super viewDidUnload];
}
@end
