//
//  NewObjectLabel.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/29/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "NewObjectLabel.h"
#import "THUtil.h"
#import "UIColor+THColor.h"

@implementation NewObjectLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id) init {
    CGFloat deviceWidth = [THUtil getRealDeviceWidth];
    CGRect newFrame = CGRectMake(0, 20, deviceWidth, 38);
    self = [super initWithFrame:newFrame];
    if (self) {
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        self.font = [UIFont fontWithName:@"Lato-Light" size:32];
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = [UIColor projectDarkTextColor];
        self.backgroundColor = [UIColor clearColor];
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
