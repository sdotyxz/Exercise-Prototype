//
//  Edata.h
//  Exercise1.01
//
//  Created by Tan Fuutou on 12-03-29.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Edata : NSManagedObject

@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSNumber * squatdown;
@property (nonatomic, retain) NSNumber * dumbbell;
@property (nonatomic, retain) NSNumber * stretch;

@end
