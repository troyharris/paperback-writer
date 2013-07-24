//
//  ProjectCell.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 7/11/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "ProjectCell.h"
#import <FLKAutoLayout/UIView+FLKAutoLayout.h>
#import "UIColor+THColor.h"

@implementation ProjectCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        [_imageView setClipsToBounds:YES];
        [self addSubview:_imageView];
        _cellTitle = [[UILabel alloc] init];
        [_cellTitle setTextAlignment:NSTextAlignmentCenter];
        _cellTitle.font = [UIFont fontWithName:@"Lato-Light" size:30];
        _cellTitle.textAlignment = NSTextAlignmentCenter;
        _cellTitle.textColor = [UIColor blackColor];
        [_cellTitle adjustsFontSizeToFitWidth];
        
        [self addSubview:_cellTitle];
        
        [_cellTitle alignTop:@"0" bottom:@"0" toView:_cellTitle.superview];
        [_cellTitle alignLeading:@"0" trailing:@"0" toView:_cellTitle.superview];
        
        _subTitle = [[UILabel alloc] init];
        _subTitle.font = [UIFont fontWithName:@"Lato-Light" size:14];
        _subTitle.textColor = [UIColor blackColor];
        [self addSubview:_subTitle];
        
        [_subTitle alignTrailingEdgeWithView:[_subTitle superview] predicate:@"-20"];
        [_subTitle alignBottomEdgeWithView:[_subTitle superview] predicate:@"-20"];
        
        [self setClipsToBounds:YES];
        
        self.layer.borderColor = [UIColor colorFromHex:@"e0e0e0" withAlpha:1.0].CGColor;
        self.layer.borderWidth = 1;
        // Initialization code
    }
    return self;
}

-(void)willRotate {
    
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
