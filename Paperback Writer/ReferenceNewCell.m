//
//  ReferenceNewCell.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 7/10/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "ReferenceNewCell.h"
#import "UIColor+THColor.h"

@implementation ReferenceNewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _plus = [[UILabel alloc] initWithFrame:CGRectMake(0, (self.bounds.size.height / 2) - 120, self.bounds.size.width, 200)];
        _plus.font = [UIFont fontWithName:@"Lato-Hairline" size:200];
        _plus.text = @"+";
        self.backgroundColor = [UIColor projectNavBarColor];
        _plus.textColor = [UIColor projectDarkTextColor];
        //_plus.backgroundColor = [UIColor whiteColor];
        _plus.textAlignment = NSTextAlignmentCenter;
        _plus.numberOfLines = 0;
        [self addSubview:_plus];
        
        // Initialization code
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
