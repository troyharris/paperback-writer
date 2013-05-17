//
//  IPadNewProjectViewController.h
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/12/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <V8HorizontalPickerView.h>

@class V8HorizontalPickerView;

@interface IPadNewProjectViewController : UIViewController <V8HorizontalPickerViewDataSource, V8HorizontalPickerViewDelegate>

@property (nonatomic, strong) IBOutlet UIButton *add;
@property (nonatomic, strong) IBOutlet UIButton *cancel;
@property (nonatomic, strong) IBOutlet UITextField *projectTitle;
@property (nonatomic, strong) IBOutlet V8HorizontalPickerView *typePicker;
@property (nonatomic, strong) IBOutlet V8HorizontalPickerView *genrePicker;
@property (nonatomic, strong) NSArray *genres;
@property (nonatomic, strong) NSArray *types;
@property (nonatomic, strong) NSString *selectedType;
@property (nonatomic, strong) NSString *selectedGenre;

-(IBAction)pressAdd;
-(IBAction)pressCancel;

@end
