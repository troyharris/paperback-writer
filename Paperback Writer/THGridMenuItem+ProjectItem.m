//
//  THGridMenuItem+ProjectItem.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/14/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "THGridMenuItem+ProjectItem.h"
#import <objc/runtime.h>

static char projectMenuItemKey;

@implementation THGridMenuItem (ProjectItem)

-(Project *)project {
    return objc_getAssociatedObject(self, &projectMenuItemKey);
}

-(void)setProject:(Project *)project {
    objc_setAssociatedObject(self, &projectMenuItemKey, project, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



@end
