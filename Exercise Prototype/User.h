//
//  User.h
//  Exercise1.01
//
//  Created by Tan Fuutou on 12-03-30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define USER_NAME @"username"
#define USER_DUMBBELL @"dumbbellTimes"
#define USER_SQUATDOWN @"squatdownTimes"
#define USER_STRETCH @"stretch"

@interface User : NSObject

+ (NSDictionary *)formatUserInfo:(NSString *)username
                   dumbbellTimes:(NSNumber *)dumbbell
                  squatdownTimes:(NSNumber *)squatdown
                    stretchTimes:(NSNumber *)stretch;

@end
