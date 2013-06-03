//
//  SceneCell.h
//  Paperback Writer
//
//  Created by Troy HARRIS on 6/2/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FMMoveTableViewCell.h>


@interface SceneCell : FMMoveTableViewCell


@property (nonatomic, strong) UILabel *sceneTitle;
@property (nonatomic, strong) UILabel *settingHead;
@property (nonatomic, strong) UILabel *charHead;
@property (nonatomic, strong) NSSet *characters;

@end
