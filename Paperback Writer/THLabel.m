//
//  THLabel.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/31/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "THLabel.h"
#import "UIColor+THColor.h"

@implementation THLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)init {
    self = [super init];
    if (self) {
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        self.font = [UIFont fontWithName:@"Lato-Black" size:24];
        //self.textAlignment = NSTextAlignmentCenter;
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
