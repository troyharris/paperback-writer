//
//  IPadCharacterInfoTableViewController.h
//  Paperback Writer
//
//  Created by Troy HARRIS on 7/29/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TableTextField.h"
#import "Character.h"

@interface IPadCharacterInfoTableViewController : UITableViewController

@property (nonatomic, strong) Character *character;
@property (nonatomic, strong) IBOutlet UIImageView *portrait;
@property (nonatomic, strong) IBOutlet TableTextField *name;
@property (nonatomic, strong) IBOutlet TableTextField *gender;
@property (nonatomic, strong) IBOutlet TableTextField *age;
@property (nonatomic, strong) IBOutlet TableTextField *myers;
@property (nonatomic, strong) IBOutlet TableTextField *role;
@property (nonatomic, strong) IBOutlet TableTextField *other;
@property (nonatomic, strong) IBOutlet TableTextField *weight;
@property (nonatomic, strong) IBOutlet TableTextField *height;
@property (nonatomic, strong) IBOutlet TableTextField *skin;
@property (nonatomic, strong) IBOutlet TableTextField *hair;
@property (nonatomic, strong) IBOutlet TableTextField *notables;
@property (nonatomic, strong) IBOutlet TableTextField *sign;
@property (nonatomic, strong) IBOutlet TableTextField *traits;
@property (nonatomic, strong) IBOutlet TableTextField *motivation;
@property (nonatomic, strong) IBOutlet TableTextField *symbols;
@property (nonatomic, strong) IBOutlet TableTextField *storyOther;



@end
