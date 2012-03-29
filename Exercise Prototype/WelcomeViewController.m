//
//  WelcomeViewController.m
//  Exercise1.01
//
//  Created by Tan Fuutou on 12-03-29.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WelcomeViewController.h"

@implementation WelcomeViewController

@synthesize eDatabase = _eDatabase;

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

#pragma mark - Setter

// 2.Init our database

- (void)setEDatabase:(UIManagedDocument *)eDatabase
{
    if (_eDatabase != eDatabase) {
        _eDatabase = eDatabase;
        [self useDocument];
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


@end
