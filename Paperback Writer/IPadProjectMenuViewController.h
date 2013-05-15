//
//  IPadProjectMenuViewController.h
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/10/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProjectMenuDelegate <NSObject>

-(void)didSelectMenuItem:(int)index;

@end

@interface IPadProjectMenuViewController : UIViewController {
    __weak id<ProjectMenuDelegate> delegate;
}

@property (weak, nonatomic) id<ProjectMenuDelegate> delegate;

-(void)pressInfo;
-(void)pressCharacter;
-(void)closeProject;

@end
