//
//  NewObjectTextField.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/29/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "NewObjectTextField.h"
#import "THUtil.h"
#import "UIColor+THColor.h"

@implementation NewObjectTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)init {
    CGFloat deviceWidth = [THUtil getRealDeviceWidth];
    CGRect newFrame = CGRectMake(20, 70, deviceWidth - 40, 80);
    self = [super initWithFrame:newFrame];
    if (self) {
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        self.backgroundColor = [UIColor projectBackgroundColor];
        self.font = [UIFont fontWithName:@"Lato-Light" size:48];
        self.textAlignment = NSTextAlignmentCenter;
        self.adjustsFontSizeToFitWidth = YES;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
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
