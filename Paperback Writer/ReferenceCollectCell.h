//
//  ReferenceCollectCell.h
//  Paperback Writer
//
//  Created by Troy HARRIS on 7/9/13.
//  Copyright (c) 2013 Lone Yeti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReferenceCollectCell : UICollectionViewCell

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *cellTitle;

-(void)willRotate;


@end
