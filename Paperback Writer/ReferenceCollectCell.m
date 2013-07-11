//
//  ReferenceCollectCell.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 7/9/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "ReferenceCollectCell.h"

@implementation ReferenceCollectCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [_imageView setClipsToBounds:YES];
        [self addSubview:_imageView];
        _cellTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, (self.bounds.size.height / 2) - 30, self.bounds.size.width, 60)];
        [_cellTitle setTextAlignment:NSTextAlignmentCenter];
        _cellTitle.font = [UIFont fontWithName:@"Lato-Black" size:30];
        [_cellTitle adjustsFontSizeToFitWidth];
        _cellTitle.textAlignment = NSTextAlignmentCenter;
        _cellTitle.textColor = [UIColor whiteColor];
        [self addSubview:_cellTitle];
        [self setClipsToBounds:YES];
        // Initialization code
    }
    return self;
}

-(void)willRotate {
    _cellTitle.frame = CGRectMake(0, (self.bounds.size.height / 2) - 30, self.bounds.size.width, 60);
    _imageView.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
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
