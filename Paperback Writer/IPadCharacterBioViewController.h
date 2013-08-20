//
//  IPadCharacterBioViewController.h
//  Paperback Writer
//
//  Created by Troy HARRIS on 8/16/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Character.h"
#import "DRNRealTimeBlurView.h"

@interface IPadCharacterBioViewController : UIViewController <UITextViewDelegate>

@property (nonatomic, strong) Character *character;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UITextField *bioHeader;
@property (nonatomic, strong) DRNRealTimeBlurView *titleView;

@end
