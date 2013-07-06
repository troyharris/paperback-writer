//
//  Note.h
//  Paperback Writer
//
//  Created by Troy HARRIS on 7/1/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Character, Research;

@interface Note : NSManagedObject

@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) Character *character;
@property (nonatomic, retain) Research *research;

@end
