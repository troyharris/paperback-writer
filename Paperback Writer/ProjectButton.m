//
//  ProjectButton.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/23/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "ProjectButton.h"
#import "UIColor+THColor.h"

@implementation ProjectButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithOrigin:(CGPoint)origin image:(UIImage *)img buttonText:(NSString *)text {
    CGRect frame = CGRectMake(origin.x, origin.y, 140, 95);
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat imgX = (self.frame.size.width / 2) - (img.size.width / 2);
        CGFloat imgY = 10;
        CGRect imgFrame = CGRectMake(imgX, imgY, img.size.width, img.size.height);
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:imgFrame];
        imgView.image = img;
        CGFloat labelTop = imgFrame.size.height + 15;
        CGRect labelFrame = CGRectMake(10, labelTop, (self.frame.size.width - 20), 20);
        UILabel *label = [[UILabel alloc] initWithFrame:labelFrame];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont fontWithName:@"Lato-Black" size:14];
        label.text = text;
        label.backgroundColor = [UIColor clearColor];
        label.textColor = [UIColor projectLightTextColor];
        [self addSubview:imgView];
        [self addSubview:label];
        //self.backgroundColor = [UIColor blackColor];
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
