//
//  IPadProjectNewViewController.h
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/29/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <V8HorizontalPickerView/V8HorizontalPickerView.h>
#import "NewObjectLabel.h"
#import "NewObjectTextField.h"
#import "SelectorLabel.h"
#import "ProjectPicker.h"
#import <FUIButton.h>
#import "TDSemiModalViewController.h"

@protocol NewProjectDelegate <NSObject>

-(void)closedSemiModal;

@end

@interface IPadProjectNewViewController : TDSemiModalViewController  <V8HorizontalPickerViewDataSource, V8HorizontalPickerViewDelegate> {
    id<NewProjectDelegate> _delegate;
}

@property (nonatomic, strong) id delegate;
@property (nonatomic, strong) FUIButton *add;
@property (nonatomic, strong) FUIButton *cancel;
@property (nonatomic, strong) NewObjectLabel *header;
@property (nonatomic, strong) NewObjectTextField *projectTitle;
@property (nonatomic, strong) SelectorLabel *genreLabel;
@property (nonatomic, strong) SelectorLabel *typeLabel;
@property (nonatomic, strong) ProjectPicker *typePicker;
@property (nonatomic, strong) ProjectPicker *genrePicker;
@property (nonatomic, strong) NSArray *genres;
@property (nonatomic, strong) NSArray *types;
@property (nonatomic, strong) NSString *selectedType;
@property (nonatomic, strong) NSString *selectedGenre;


-(void)pressAdd;
-(void)pressCancel;
-(void)resetPickers;

@end
