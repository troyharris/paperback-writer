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
        self.backgroundColor = [UIColor projectHighlightColor];
        CGRect titleFrame = CGRectMake(10, 0, self.frame.size.width - 20, self.frame.size.height);
        _title = [[UILabel alloc] initWithFrame:titleFrame];
        _title.textColor = [UIColor whiteColor];
        _title.backgroundColor = [UIColor clearColor];
        _title.font = [UIFont fontWithName:@"Lato-Light" size:30];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.adjustsFontSizeToFitWidth = YES;
        _title.contentMode = UIViewContentModeScaleAspectFit;
        _title.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
        [self addSubview:_title];
        CGRect typeFrame = CGRectMake((self.frame.size.width / 2) - 10, 64, self.frame.size.width / 2, 20);
        _type = [[UILabel alloc] initWithFrame:typeFrame];
        _type.textColor = [UIColor whiteColor];
        _type.backgroundColor = [UIColor clearColor];
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
