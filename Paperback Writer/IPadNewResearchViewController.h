//
//  IPadNewResearchViewController.h
//  Paperback Writer
//
//  Created by Troy HARRIS on 6/30/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FUIButton.h>
#import <V8HorizontalPickerView/V8HorizontalPickerView.h>
#import "NewObjectLabel.h"
#import "NewObjectTextField.h"
#import "ProjectPicker.h"
#import "SelectorLabel.h"

@protocol NewProjectDelegate <NSObject>

-(void)closedSemiModal;

@end

@interface IPadNewResearchViewController : UIViewController <V8HorizontalPickerViewDataSource, V8HorizontalPickerViewDelegate>

@property (nonatomic, strong) FUIButton *add;
@property (nonatomic, strong) FUIButton *cancel;
@property (nonatomic, strong) NewObjectLabel *header;
@property (nonatomic, strong) NewObjectTextField *researchTitle;
@property (nonatomic, strong) ProjectPicker *typePicker;
@property (nonatomic, strong) SelectorLabel *typeLabel;
@property (nonatomic, strong) NSArray *types;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIControl *underView;
@property (nonatomic, strong) UIControl *urlEntry;
@property (nonatomic, strong) UIView *noteEntry;
@property (nonatomic, strong) UIView *imageEntry;
@property (nonatomic, strong) NSArray *underConstH;
@property (nonatomic, strong) NSArray *underConstV;
@property (nonatomic, strong) UITextView *noteText;
@property (nonatomic, strong) UITextField *urlText;
@property (nonatomic, strong) UISegmentedControl *typeSwitch;

@end
