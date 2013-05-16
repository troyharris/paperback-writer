//
//  Scene.h
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/15/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Character, Outline;

@interface Scene : NSManagedObject

@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSNumber * orderNum;
@property (nonatomic, retain) NSString * setting;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSSet *characters;
@property (nonatomic, retain) Outline *outline;
@end

@interface Scene (CoreDataGeneratedAccessors)

- (void)addCharactersObject:(Character *)value;
- (void)removeCharactersObject:(Character *)value;
- (void)addCharacters:(NSSet *)values;
- (void)removeCharacters:(NSSet *)values;

@end
