//
//  THGridMenuItem+CharacterItem.h
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/14/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "THGridMenuItem.h"
#import "Character.h"

@interface THGridMenuItem (CharacterItem)

@property (nonatomic, strong) Character *character;

-(Character *)character;
-(void)setCharacter:(Character *)character;

@end
