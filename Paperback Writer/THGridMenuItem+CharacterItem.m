//
//  THGridMenuItem+CharacterItem.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/14/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "THGridMenuItem+CharacterItem.h"
#import <objc/runtime.h>

static char characterMenuItemKey;

@implementation THGridMenuItem (CharacterItem)

-(Character *)character {
    return objc_getAssociatedObject(self, &characterMenuItemKey);
}

-(void)setCharacter:(Character *)character {
    objc_setAssociatedObject(self, &characterMenuItemKey, character, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
