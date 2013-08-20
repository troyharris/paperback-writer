//
//  ProseyPicker.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 8/20/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "ProseyPicker.h"
#import "UIColor+THColor.h"

@implementation ProseyPicker

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self buildSelf];
    }
    return self;
}

- (void)awakeFromNib {
    [self buildSelf];
}

- (void)buildSelf {
    self.backgroundColor   = [UIColor projectBackgroundColor];
    self.selectedTextColor = [UIColor projectDarkTextColor];
    self.textColor   = [UIColor projectLightTextColor];
    self.elementFont = [UIFont fontWithName:@"Lato-Light" size:16.0];
    self.selectionPoint = CGPointMake(60, 0);
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
