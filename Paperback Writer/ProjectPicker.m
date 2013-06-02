//
//  ProjectPicker.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/29/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "ProjectPicker.h"
#import "THUtil.h"
#import "UIColor+THColor.h"

@implementation ProjectPicker

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

-(id)initWithSide:(int)side withTag:(int)tag {
    CGFloat margin = 20.0f;
	CGFloat width = (([THUtil getRealDeviceWidth] - (margin * 2.0f)) / 2) - 10;
	CGFloat pickerHeight = 40.0f;
	CGFloat x;
    if (side == kLeft) {
        x = margin;
    } else {
        x = margin + width + (margin / 2);
    }
	CGFloat y = 200.0f;
	CGRect tmpFrame = CGRectMake(x, y, width, pickerHeight);
    self = [super initWithFrame:tmpFrame];
    if (self) {
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        self.backgroundColor   = [UIColor projectBackgroundColor];
        self.selectedTextColor = [UIColor projectDarkTextColor];
        self.textColor   = [UIColor projectHighlightColor];
        self.elementFont = [UIFont fontWithName:@"Lato-Light" size:16.0];
        self.selectionPoint = CGPointMake(60, 0);
        self.tag = tag;
    }
    return self;
}

-(id)initWithLeftSideAndTag:(int)tag {
    return [self initWithSide:kLeft withTag:tag];
}

-(id)initWithRightSideAndTag:(int)tag {
    return [self initWithSide:kRight withTag:tag];
}

-(void)updateWidthForLeft {
    CGFloat margin = 20.0f;
    CGFloat width = (([THUtil getRealDeviceWidth] - (margin * 2.0f)) / 2) - 10;
    CGRect tmpFrame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
    self.frame = tmpFrame;
}

-(void)updateWidthForRight {
    CGFloat margin = 20.0f;
    CGFloat width = (([THUtil getRealDeviceWidth] - (margin * 2.0f)) / 2) - 10;
    CGRect tmpFrame = CGRectMake(margin + width + (margin / 2), self.frame.origin.y,width, self.frame.size.height);
    self.frame = tmpFrame;
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
