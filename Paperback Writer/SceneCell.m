//
//  SceneCell.m
//  Paperback Writer
//
//  Created by Troy HARRIS on 6/2/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "SceneCell.h"
#import "UIView+THAutoLayout.h"
#import "UIColor+THColor.h"
#import "THUtil.h"
#import "Character.h"

@implementation SceneCell

static float kMargin = 10.0;
static float kPadding = 20.0;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _sceneTitle = [[UILabel alloc] initWithFrame:CGRectMake(kPadding, kPadding, self.frame.size.width - (kPadding * 2), 30)];
        _sceneTitle.font = [UIFont fontWithName:@"Lato-Black" size:24];
        _sceneTitle.textColor = [UIColor projectDarkTextColor];
        _sceneTitle.backgroundColor = [UIColor clearColor];
        _sceneTitle.text = @"Sample Scene";
        [self.contentView addSubview:_sceneTitle];
        _settingHead = [[UILabel alloc] initWithFrame:CGRectMake(kPadding, [THUtil getViewBottomOrigin:_sceneTitle] + kMargin, self.frame.size.width - (kPadding * 2), 20) ];
        [_settingHead setTranslatesAutoresizingMaskIntoConstraints:NO];
        _settingHead.font = [UIFont fontWithName:@"Lato-Black" size:16];
        _settingHead.textColor = [UIColor projectHighlightColor];
        _settingHead.adjustsFontSizeToFitWidth = YES;
        _settingHead.text = @"Setting";
        [self.contentView addSubview:_settingHead];
        
        NSString *charString = @"";
        for (Character *c in _characters) {
            charString = [charString stringByAppendingFormat:@"%@  ", c.name];
        }
        _charHead = [[UILabel alloc] initWithFrame:CGRectMake(kPadding * 2, [THUtil getViewBottomOrigin:_settingHead] + kMargin, self.frame.size.width - (kPadding * 3), 20)];
        _charHead.font = [UIFont fontWithName:@"Lato-Black" size:16];
        _charHead.textColor = [UIColor projectHighlightColor];
        _charHead.adjustsFontSizeToFitWidth = YES;
        _charHead.text = charString;
        [self.contentView addSubview:_charHead];
        
        /*
        [self addConstraintsWithString:@"H:|-[_sceneTitle]-|" bindings:NSDictionaryOfVariableBindings(_sceneTitle)];
        [self addConstraintsWithString:@"H:|-[settingHead]-|" bindings:NSDictionaryOfVariableBindings(settingHead)];
        [self addConstraintsWithString:@"V:|-[_sceneTitle]-[settingHead]-|" bindings:NSDictionaryOfVariableBindings(_sceneTitle, settingHead)];
         */
        
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)prepareForMove {
    [super prepareForMove];
    self.contentView.hidden = YES;
}

@end
