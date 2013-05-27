//
//  THGridMenuItem.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/12/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "THGridMenuItem.h"
#import "UIColor+THColor.h"

@implementation THGridMenuItem

@synthesize title = _title;
@synthesize type = _type;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setAutoresizesSubviews:YES];
        self.backgroundColor = [UIColor colorFromHex:@"a57f2c" withAlpha:1.0];
        CGRect titleFrame = CGRectMake(10, 0, self.frame.size.width - 20, self.frame.size.height);
        _title = [[UILabel alloc] initWithFrame:titleFrame];
        _title.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        _title.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        _title.font = [UIFont fontWithName:@"Lato-Light" size:30];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.adjustsFontSizeToFitWidth = YES;
        _title.contentMode = UIViewContentModeScaleAspectFit;
        _title.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
        [self addSubview:_title];
        CGRect typeFrame = CGRectMake((self.frame.size.width / 2) - 10, 64, self.frame.size.width / 2, 20);
        _type = [[UILabel alloc] initWithFrame:typeFrame];
        _type.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        _type.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        _type.font = [UIFont fontWithName:@"Lato-Light" size:14];
        _type.adjustsFontSizeToFitWidth = YES;
        [self addSubview:_type];
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
