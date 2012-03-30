//
//  CMMotionManager+Shared.m
//  Device Motion Watcher
//
//  Created by Tan Fuutou on 12-03-22.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CMMotionManager+Shared.h"

@implementation CMMotionManager (Shared)

+ (CMMotionManager *)sharedMotionManager
{
    static CMMotionManager *shared = nil;
    if (!shared) shared = [[CMMotionManager alloc] init];
    return shared;
}

@end
