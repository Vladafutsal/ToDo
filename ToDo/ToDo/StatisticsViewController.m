//
//  StatisticsViewController.m
//  ToDo
//
//  Created by Cubes School 1 on 5/4/16.
//  Copyright © 2016 Cubes School 1. All rights reserved.
//

#import "StatisticsViewController.h"
#import "DataManager.h"
#import "Constants.h"

@interface StatisticsViewController()
@property (weak, nonatomic) IBOutlet UILabel *completedPrecentageLabel;
@property (weak, nonatomic) IBOutlet UILabel *notCompletedPrecentageLabel;
@property (weak, nonatomic) IBOutlet UILabel *inProgressPrecentageLabel;
@property (weak, nonatomic) IBOutlet UILabel *completedCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *notCompletedCountlabel;
@property (weak, nonatomic) IBOutlet UILabel *inProgressCountlabel;
@end

@implementation StatisticsViewController

#pragma mark - actions

- (IBAction)backButtonTapped {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat completedCount = [[DataManager sharedInstance] numberOfTaskPerTaskGroup:COMPLETED_TASK_GROUP];
    CGFloat notCompletedCount = [[DataManager sharedInstance] numberOfTaskPerTaskGroup:NOT_COMPLETED_TASK_GROUP];
    CGFloat inProgressCount = [[DataManager sharedInstance] numberOfTaskPerTaskGroup:IN_PROGRESS_TASK_GROUP];
    CGFloat taskCount = completedCount + notCompletedCount + inProgressCount;
    
    self.completedCountLabel.text = [NSString stringWithFormat:@"%.0f", completedCount];
    self.notCompletedCountlabel.text = [NSString stringWithFormat:@"%.0f", notCompletedCount];
    self.inProgressCountlabel.text = [NSString stringWithFormat:@"%.0f", inProgressCount];
    
    if (completedCount > 0) {
        CGFloat precentage = (completedCount/taskCount)*100;
        self.completedPrecentageLabel.text = [NSString stringWithFormat:@"%.0f", precentage];
    } else {
        self.completedPrecentageLabel.text = @"0";
    }
    
    if (notCompletedCount > 0) {
        CGFloat precentage = (notCompletedCount/taskCount)*100;
        self.notCompletedCountlabel.text = [NSString stringWithFormat:@"%.0f", precentage];
    } else {
        self.notCompletedCountlabel.text = @"0";
    }
    
    if (inProgressCount > 0) {
        CGFloat precentage = (inProgressCount/taskCount)*100;
        self.inProgressCountlabel.text = [NSString stringWithFormat:@"%.0f", precentage];
    } else {
        self.inProgressCountlabel.text = @"0";
    }

    
    
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end