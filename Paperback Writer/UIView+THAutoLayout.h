//
//  UIView+THAutoLayout.h
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/31/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (THAutoLayout)

-(void)addConstraintsWithString:(NSString *)vsl bindings:(NSDictionary *)bindings;

-(NSDictionary *)projectMetrics;

@end
