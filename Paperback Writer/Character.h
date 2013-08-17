//
//  Character.h
//  Paperback Writer
//
//  Created by Troy HARRIS on 8/17/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Note, Project, Scene;

@interface Character : NSManagedObject

@property (nonatomic, retain) NSString * age;
@property (nonatomic, retain) NSString * appearance;
@property (nonatomic, retain) NSString * bio;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSString * hair;
@property (nonatomic, retain) NSString * height;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * skin;
@property (nonatomic, retain) NSString * role;
@property (nonatomic, retain) NSString * weight;
@property (nonatomic, retain) NSString * myers;
@property (nonatomic, retain) NSString * sign;
@property (nonatomic, retain) NSString * traits;
@property (nonatomic, retain) NSString * other;
@property (nonatomic, retain) NSString * motivation;
@property (nonatomic, retain) NSString * symbols;
@property (nonatomic, retain) NSString * personality;
@property (nonatomic, retain) NSSet *notes;
@property (nonatomic, retain) Project *project;
@property (nonatomic, retain) NSSet *scenes;
@end

@interface Character (CoreDataGeneratedAccessors)

- (void)addNotesObject:(Note *)value;
- (void)removeNotesObject:(Note *)value;
- (void)addNotes:(NSSet *)values;
- (void)removeNotes:(NSSet *)values;

- (void)addScenesObject:(Scene *)value;
- (void)removeScenesObject:(Scene *)value;
- (void)addScenes:(NSSet *)values;
- (void)removeScenes:(NSSet *)values;

@end
