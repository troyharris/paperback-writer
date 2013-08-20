//
//  IPadNewProjectVC.h
//  Paperback Writer
//
//  Created by Troy HARRIS on 8/20/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProseyPicker.h"

@protocol NewProjectDelegate <NSObject>

-(void)closedPopover;

@end


@interface IPadNewProjectVC : UIViewController <V8HorizontalPickerViewDataSource, V8HorizontalPickerViewDelegate>

@property (nonatomic, weak) id<NewProjectDelegate> delegate;
@property (nonatomic, strong) IBOutlet UITextField *titleText;
@property (nonatomic, strong) IBOutlet ProseyPicker *genre;
@property (nonatomic, strong) IBOutlet ProseyPicker *type;
@property (nonatomic, strong) NSArray *genres;
@property (nonatomic, strong) NSArray *types;

-(IBAction)pressAdd;
-(IBAction)pressCancel;

@end
