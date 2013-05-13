//
//  THGridMenuItem.h
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/12/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Project.h"

@interface THGridMenuItem : UIControl

@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *type;
@property (nonatomic, strong) NSString *titleText;
@property (nonatomic, strong) NSString *typeText;
@property (nonatomic, strong) NSString *genreText;
@property (nonatomic, strong) Project *project;

@end
