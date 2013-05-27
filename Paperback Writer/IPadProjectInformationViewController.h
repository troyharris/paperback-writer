//
//  IPadProjectInfoViewController.h
//  
//
//  Created by Troy HARRIS on 5/23/13.
//
//

#import <UIKit/UIKit.h>
#import "Project.h"

@interface IPadProjectInformationViewController : UIViewController

@property (nonatomic, strong) Project *project;
@property (nonatomic, strong) UITextField *projectTitle;
@property (nonatomic, strong) UITextView *desc;
@property (nonatomic, strong) UILabel *charCount;
@property (nonatomic, strong) UILabel *sceneCount;
@property (nonatomic, strong) UILabel *noteCount;

@end
