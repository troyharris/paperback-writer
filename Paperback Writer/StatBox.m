//
//  StatBox.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 6/2/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "StatBox.h"
#import "UIColor+THColor.h"
#import "UIView+THAutoLayout.h"

@implementation StatBox

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor projectHighlightColor];
        
        _statTitle = [[UILabel alloc] init];
        [_statTitle setTranslatesAutoresizingMaskIntoConstraints:NO];
        _statTitle.font = [UIFont fontWithName:@"Lato-Light" size:24];
        _statTitle.textAlignment = NSTextAlignmentCenter;
        _statTitle.textColor = [UIColor projectLightTextColor];
        _statTitle.backgroundColor = [UIColor clearColor];
        [self addSubview:_statTitle];
        
        _statNum = [[UILabel alloc] init];
        [_statNum setTranslatesAutoresizingMaskIntoConstraints:NO];
        _statNum.font = [UIFont fontWithName:@"Lato-Light" size:98];
        _statNum.textAlignment = NSTextAlignmentCenter;
        _statNum.textColor = [UIColor projectLightTextColor];
        _statNum.backgroundColor = [UIColor clearColor];
        [self addSubview:_statNum];
        
        [self addConstraintsWithString:@"V:|-[_statNum]-|" bindings:NSDictionaryOfVariableBindings(_statNum)];
        [self addConstraintsWithString:@"V:|-[_statTitle]" bindings:NSDictionaryOfVariableBindings(_statTitle)];
        [self addConstraintsWithString:@"H:|-[_statTitle]-|" bindings:NSDictionaryOfVariableBindings(_statTitle)];
        [self addConstraintsWithString:@"H:|-[_statNum]-|" bindings:NSDictionaryOfVariableBindings(_statNum)];
        
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
