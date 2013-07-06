//
//  Research.h
//  Paperback Writer
//
//  Created by Troy HARRIS on 7/1/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Note, Project;

@interface Research : NSManagedObject

@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) Note *notes;
@property (nonatomic, retain) Project *project;

@end
