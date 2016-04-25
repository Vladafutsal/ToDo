//
//  WalkthroughCollectionViewCell.m
//  ToDo
//
//  Created by Cubes School 1 on 4/25/16.
//  Copyright © 2016 Cubes School 1. All rights reserved.
//

#import "WalkthroughCollectionViewCell.h"

@implementation WalkthroughCollectionViewCell

- (void)setWalkthroughItem:(WalkthroughItem *)walkthroughItem {
    _walkthroughItem = walkthroughItem;
    
    self.textLabel.text = walkthroughItem.text;
    self.imageView.image = walkthroughItem.image;
    
    self.textLabel.alpha = 0.0;
    [UIView animateWithDuration:0.3 animations:^{
        self.textLabel.alpha = 1.0;
    }];
}

@end
