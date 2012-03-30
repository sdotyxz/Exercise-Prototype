//
//  User.m
//  Exercise1.01
//
//  Created by Tan Fuutou on 12-03-30.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "User.h"

@implementation User

+(NSDictionary *)formatUserInfo:(NSString *)username 
                  dumbbellTimes:(NSNumber *)dumbbell 
                 squatdownTimes:(NSNumber *)squatdown 
                   stretchTimes:(NSNumber *)stretch
{
    NSDictionary *userInfo;
    
    userInfo = [NSDictionary dictionaryWithObjectsAndKeys:username, USER_NAME, dumbbell, USER_DUMBBELL, squatdown, USER_SQUATDOWN, stretch, USER_STRETCH, nil];
    
    return userInfo;
}

@end
