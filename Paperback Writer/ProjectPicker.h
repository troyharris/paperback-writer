//
//  ProjectPicker.h
//  Paperback Writer
//
//  Created by Troy HARRIS on 5/29/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import "V8HorizontalPickerView.h"

@interface ProjectPicker : V8HorizontalPickerView

-(id)initWithLeftSideAndTag:(int)tag;
-(id)initWithRightSideAndTag:(int)tag;

@end
