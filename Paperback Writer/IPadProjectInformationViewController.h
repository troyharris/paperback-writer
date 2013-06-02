//
//  IPadProjectInfoViewController.h
//  
//
//  Created by Troy HARRIS on 5/23/13.
//
//

#import <UIKit/UIKit.h>
#import "Project.h"
#import "THLabel.h"
#import "StatBox.h"

@interface IPadProjectInformationViewController : UIViewController <UITextViewDelegate>

@property (nonatomic, strong) Project *project;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UITextField *projectTitle;
@property (nonatomic, strong) UITextView *desc;
@property (nonatomic, strong) UIView *hr;
@property (nonatomic, strong) THLabel *synopsis;
@property (nonatomic, strong) THLabel *typeAndGenre;
@property (nonatomic, strong) UILabel *charCount;
@property (nonatomic, strong) UILabel *sceneCount;
@property (nonatomic, strong) UILabel *noteCount;
@property (nonatomic, strong) NSArray *textConst;
@property (nonatomic, strong) NSValue *keyHeight;
@property (nonatomic, strong) UIView *statView;
@property (nonatomic, strong) StatBox *charBox;
@property (nonatomic, strong) StatBox *sceneBox;
@property (nonatomic, strong) StatBox *noteBox;

@end
