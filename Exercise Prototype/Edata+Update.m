//
//  Edata+Update.m
//  Exercise1.01
//
//  Created by Tan Fuutou on 12-03-29.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Edata+Update.h"
#import "User.h"

@implementation Edata (Update)

+ (Edata *)dataWithuserInfo:(NSDictionary *)userInfo inManagedObjectContext:(NSManagedObjectContext *)context
{
    Edata *data = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Edata"];
    request.predicate = [NSPredicate predicateWithFormat:@"username = %@", [userInfo objectForKey:USER_NAME]];
    
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if (!matches || ([matches count] > 1)) {
        //handle error
    } else if ([matches count] == 0) {
        
        data = [NSEntityDescription insertNewObjectForEntityForName:@"Edata" inManagedObjectContext:context];
        data.username = [userInfo objectForKey:USER_NAME];
        data.dumbbell = [NSNumber numberWithInt:[[userInfo objectForKey:USER_DUMBBELL] intValue]];
        data.squatdown = [NSNumber numberWithInt:[[userInfo objectForKey:USER_SQUATDOWN] intValue]];
        data.stretch = [NSNumber numberWithInt:[[userInfo objectForKey:USER_STRETCH] intValue]];
        
        NSLog(@"insert into the dataBase");
    } else {
        data = [matches lastObject];
        data.dumbbell = [NSNumber numberWithInt:[data.dumbbell intValue] + [[userInfo objectForKey:USER_DUMBBELL] intValue]];
        data.squatdown =[NSNumber numberWithInt:[data.squatdown intValue] + [[userInfo objectForKey:USER_SQUATDOWN] intValue]];
        data.stretch =[NSNumber numberWithInt:[data.stretch intValue] + [[userInfo objectForKey:USER_STRETCH] intValue]];
        
        NSLog(@"update the exist user");
    }
    
    return data;
}


@end
