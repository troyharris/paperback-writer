//
//  Character.h
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/12/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Project;

@interface Character : NSManagedObject

@property (nonatomic, retain) NSString * age;
@property (nonatomic, retain) NSString * appearance;
@property (nonatomic, retain) NSString * bio;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *notes;
@property (nonatomic, retain) Project *project;
@property (nonatomic, retain) NSSet *scenes;
@end

@interface Character (CoreDataGeneratedAccessors)

- (void)addNotesObject:(NSManagedObject *)value;
- (void)removeNotesObject:(NSManagedObject *)value;
- (void)addNotes:(NSSet *)values;
- (void)removeNotes:(NSSet *)values;

- (void)addScenesObject:(NSManagedObject *)value;
- (void)removeScenesObject:(NSManagedObject *)value;
- (void)addScenes:(NSSet *)values;
- (void)removeScenes:(NSSet *)values;

@end
