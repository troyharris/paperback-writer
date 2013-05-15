//
//  GlobalProject.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/14/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "GlobalProject.h"

@implementation GlobalProject

@synthesize project = _project;

+ (id)sharedProject {
    static GlobalProject *sharedMyProject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyProject = [[self alloc] init];
    });
    return sharedMyProject;
}

@end
