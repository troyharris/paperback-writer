//
//  UIView+THAutoLayout.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/31/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "UIView+THAutoLayout.h"

@implementation UIView (THAutoLayout)

-(void)addConstraintsWithString:(NSString *)vsl bindings:(NSDictionary *)bindings {
    NSArray *contraints = [NSLayoutConstraint constraintsWithVisualFormat:vsl options:0 metrics:[self projectMetrics] views:bindings];
    [self addConstraints:contraints];
}

-(NSDictionary *)projectMetrics {
    NSString *path = [[NSBundle mainBundle] pathForResource:
                      @"projectMetrics" ofType:@"plist"];
    return [NSDictionary dictionaryWithContentsOfFile:path];
}

@end
