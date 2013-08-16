//
//  TableTextField.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 7/29/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "TableTextField.h"
#import "UIColor+THColor.h"

@implementation TableTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.font = [UIFont fontWithName:@"Lato-Light" size:30];
        self.backgroundColor = [UIColor projectHighlightColor];
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
