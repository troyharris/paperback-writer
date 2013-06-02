//
//  SelectorLabel.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/29/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "SelectorLabel.h"
#import "THUtil.h"
#import "UIColor+THColor.h"

@implementation SelectorLabel

static int kLeft = 0;
static int kRight = 1;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithSide:(int)side {
    CGFloat x, width;
    CGRect newFrame;
    CGFloat deviceWidth = [THUtil getRealDeviceWidth];
    if (side == kLeft) {
        x = 30;
    } else {
        x = (deviceWidth / 2) + 20;
    }
    width = (deviceWidth - 70) / 2;
    newFrame = CGRectMake(x, 170, width, 30);
    self = [super initWithFrame:newFrame];
    if (self) {
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        self.font = [UIFont fontWithName:@"Lato-Black" size:20];
        self.backgroundColor = [UIColor clearColor];
        self.textColor = [UIColor projectLightTextColor];
    }
    return self;
}

-(id)initWithLeftSide {
    return [self initWithSide:kLeft];
}

-(id)initWithRightSide {
    return [self initWithSide:kRight];
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
