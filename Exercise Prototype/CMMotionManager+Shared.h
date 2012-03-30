//
//  CMMotionManager+Shared.h
//  Device Motion Watcher
//
//  Created by Tan Fuutou on 12-03-22.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <CoreMotion/CoreMotion.h>

@interface CMMotionManager (Shared)

+ (CMMotionManager *)sharedMotionManager;

@end
