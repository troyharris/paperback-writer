//
//  Project.h
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/12/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Project : NSManagedObject

@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * genre;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSSet *characters;
@property (nonatomic, retain) NSSet *outlines;
@property (nonatomic, retain) NSSet *researches;
@end

@interface Project (CoreDataGeneratedAccessors)

- (void)addCharactersObject:(NSManagedObject *)value;
- (void)removeCharactersObject:(NSManagedObject *)value;
- (void)addCharacters:(NSSet *)values;
- (void)removeCharacters:(NSSet *)values;

- (void)addOutlinesObject:(NSManagedObject *)value;
- (void)removeOutlinesObject:(NSManagedObject *)value;
- (void)addOutlines:(NSSet *)values;
- (void)removeOutlines:(NSSet *)values;

- (void)addResearchesObject:(NSManagedObject *)value;
- (void)removeResearchesObject:(NSManagedObject *)value;
- (void)addResearches:(NSSet *)values;
- (void)removeResearches:(NSSet *)values;

@end
