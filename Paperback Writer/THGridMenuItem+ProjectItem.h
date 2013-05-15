//
//  THGridMenuItem+ProjectItem.h
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/14/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "THGridMenuItem.h"
#import "Project.h"

@interface THGridMenuItem (ProjectItem)

@property (nonatomic, strong) Project *project;

-(Project *)project;
-(void)setProject:(Project *)project;

@end
