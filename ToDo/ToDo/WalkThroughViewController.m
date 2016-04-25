//
//  WalkThroughViewController.m
//  ToDo
//
//  Created by Cubes School 1 on 4/22/16.
//  Copyright © 2016 Cubes School 1. All rights reserved.
//

#import "WalkThroughViewController.h"
#import "Constanc.h"
#import "WalkthroughItem.h"
#import "WalkthroughCollectionViewCell.h"

@interface WalkThroughViewController() <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (strong, nonatomic) NSArray *itemsArray;
@end

@implementation WalkThroughViewController

- (IBAction)closeButtonTapped:(id)sender {
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"WALKTHROUGHT_PRESENTED"];
    [[NSUserDefaults standardUserDefaults] synchronize];
     
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.itemsArray = @[
                        [[WalkthroughItem alloc] initWithText:@"Keep your work organized and\nquickly check your reminders\nwith simple calendar"
                                                 andImage:[UIImage imageNamed:@"calendar"]],
                        [[WalkthroughItem alloc] initWithText:@"Manage your tasks quick and easy\nfrom your phone"
                                                 andImage:[UIImage imageNamed:@"phone"]],
                        [[WalkthroughItem alloc] initWithText:@"Quickly add tasks\nfrom home screen"
                                                 andImage:[UIImage imageNamed:@"tasks"]],
                        ];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    WalkthroughCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
    WalkthroughItem *item = [self.itemsArray objectAtIndex:indexPath.item];
    cell.walkthroughItem = item;
    
    self.pageControl.currentPage = indexPath.row;
    
    if (indexPath.row == self.itemsArray.count - 1) {
        [UIView animateWithDuration:0.3 animations:^{
            self.closeButton.alpha = 1.0;
        }];
    }
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                        layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    return CGSizeMake(collectionView.frame.size.width, collectionView.frame.size.height);
}

@end