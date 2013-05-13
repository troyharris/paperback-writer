//
//  IPadNewProjectViewController.h
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/12/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IPadNewProjectViewController : UIViewController

@property (nonatomic, strong) IBOutlet UIButton *add;
@property (nonatomic, strong) IBOutlet UIButton *cancel;
@property (nonatomic, strong) IBOutlet UITextField *projectTitle;

-(IBAction)pressAdd;
-(IBAction)pressCancel;

@end
