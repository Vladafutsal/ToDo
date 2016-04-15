//
//  HomeViewController.m
//  ToDo
//
//  Created by Cubes School 1 on 4/8/16.
//  Copyright © 2016 Cubes School 1. All rights reserved.
//

#import "HomeViewController.h"
#import "TaskTableViewCell.h"
#import "Constanc.h"

@interface HomeViewController() <UITableViewDelegate, UITableViewDataSource>

@end

@implementation HomeViewController

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.taskTitleLabel.text = [NSString stringWithFormat: @"red %ld", indexPath.row];
    
    switch (indexPath.row) {
            
        case COMPLETED_TASK_GROUP:
            cell.taskGroupView.backgroundColor = kTurquoiseColor;
            break;
            
        case NOT_COMPLETED_TASK_GROUP:
            cell.taskGroupView.backgroundColor = kPurpleColor;
            break;
            
        case IN_PROGRESS_TASK_GROUP:
            cell.taskGroupView.backgroundColor = kOrangeColor;
            break;
            
            default:
            cell.taskGroupView.backgroundColor = [UIColor redColor];
            break;
            }
                                
    return cell;
}

@end