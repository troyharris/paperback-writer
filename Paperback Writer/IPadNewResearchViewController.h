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

@protocol NewResearchDelegate <NSObject>

-(void)closedPopover;

@end

@interface IPadNewResearchViewController : UIViewController <V8HorizontalPickerViewDataSource, V8HorizontalPickerViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, weak) id<NewResearchDelegate> delegate;
@property (nonatomic, strong) UIButton *add;
@property (nonatomic, strong) UIButton *cancel;
@property (nonatomic, strong) NewObjectLabel *header;
@property (nonatomic, strong) NewObjectTextField *researchTitle;
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
@property (nonatomic, strong) UIImagePickerController *galleryPicker;
@property (nonatomic, strong) UIImagePickerController *cameraPicker;
@property (nonatomic, strong) NSData *imageData;
@property (nonatomic, strong) NSArray *noteColors;
@property (nonatomic, strong) NSArray *urlColors;

@end
