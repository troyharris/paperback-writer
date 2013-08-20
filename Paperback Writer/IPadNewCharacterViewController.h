//
//  IPadNewCharacterViewController.h
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/14/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProseyPicker.h"

@protocol NewCharacterDelegate <NSObject>

-(void)closedPopover;

@end


@interface IPadNewCharacterViewController : UIViewController <V8HorizontalPickerViewDataSource, V8HorizontalPickerViewDelegate>

@property (nonatomic, weak) id<NewCharacterDelegate> delegate;
@property (nonatomic, strong) IBOutlet UITextField *nameText;
@property (nonatomic, strong) IBOutlet ProseyPicker *gender;
@property (nonatomic, strong) IBOutlet ProseyPicker *role;
@property (nonatomic, strong) NSArray *genders;
@property (nonatomic, strong) NSArray *roles;

-(IBAction)pressAdd;
-(IBAction)pressCancel;

@end
