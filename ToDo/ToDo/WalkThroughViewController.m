//
//  WalkThroughViewController.m
//  ToDo
//
//  Created by Cubes School 1 on 4/22/16.
//  Copyright © 2016 Cubes School 1. All rights reserved.
//

#import "WalkThroughViewController.h"
#import "Constanc.h"

@implementation WalkThroughViewController

- (IBAction)closeButtonTapped:(id)sender {
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"WALKTHROUGHT_PRESENTED"];
    [[NSUserDefaults standardUserDefaults] synchronize];
     
    [self.navigationController popViewControllerAnimated:YES];
}


@end