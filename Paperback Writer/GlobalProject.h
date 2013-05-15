//
//  GlobalProject.h
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/14/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Project.h"

@interface GlobalProject : NSObject {
    Project *project;
}

@property (nonatomic, strong) Project *project;

+(id)sharedProject;

@end
