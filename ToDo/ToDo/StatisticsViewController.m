//
//  StatisticsViewController.m
//  ToDo
//
//  Created by Cubes School 1 on 5/4/16.
//  Copyright © 2016 Cubes School 1. All rights reserved.
//

#import "StatisticsViewController.h"

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
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end