//
//  Outline.h
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/15/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Project;

@interface Outline : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) Project *project;
@property (nonatomic, retain) NSSet *scenes;
@end

@interface Outline (CoreDataGeneratedAccessors)

- (void)addScenesObject:(NSManagedObject *)value;
- (void)removeScenesObject:(NSManagedObject *)value;
- (void)addScenes:(NSSet *)values;
- (void)removeScenes:(NSSet *)values;

@end
