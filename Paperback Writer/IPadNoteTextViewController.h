//
//  IPadNoteTextViewController.h
//  Paperback Writer
//
//  Created by Troy HARRIS on 7/27/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Research.h"
#import "DRNRealTimeBlurView.h"

@interface IPadNoteTextViewController : UIViewController <UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UITextField *titleField;
@property (nonatomic, strong) DRNRealTimeBlurView *titleView;
@property (nonatomic, strong) Research *research;

@end
