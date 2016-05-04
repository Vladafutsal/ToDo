//
//  WebViewController.m
//  ToDo
//
//  Created by Cubes School 1 on 5/4/16.
//  Copyright © 2016 Cubes School 1. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController() <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (strong, nonatomic) UIDynamicAnimator *animator;
@end

@implementation WebViewController

#pragma mark - Private API

- (void)animateCloseButton {
   
}

#pragma mark - Actions

- (IBAction)closeButtontapped {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - ViewLifecycle

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.closeButton.alpha = ZERO_VALUE;
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self animateCloseButton];
}

@end