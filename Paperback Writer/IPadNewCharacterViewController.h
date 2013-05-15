//
//  IPadNewCharacterViewController.h
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/14/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IPadNewCharacterViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *nameText;

-(IBAction)pressAdd;
-(IBAction)pressCancel;

@end
