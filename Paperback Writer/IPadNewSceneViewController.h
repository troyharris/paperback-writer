//
//  IPadNewSceneViewController.h
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/15/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Outline.h"

@interface IPadNewSceneViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *sceneText;
@property (nonatomic, strong) Outline *outline;
@property (nonatomic, strong) NSNumber *nextOrderNum;

-(IBAction)pressAdd;
-(IBAction)pressCancel;

@end
