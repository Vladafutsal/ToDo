//
//  LoginViewController.h
//  ToDo
//
//  Created by Cubes School 1 on 3/30/16.
//  Copyright © 2016 Cubes School 1. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *usernameImageView;
@property (weak, nonatomic) IBOutlet UIImageView *passwordImageView;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *logoView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIView *maskLogoVIew;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (nonatomic) CGFloat containerViewOriginY;

-(IBAction)submitButtonTapped;
-(void)configureTextFieldPlaceholders;
-(void)registerForNotifications;
-(void)prepareForAnimations;
-(void)animate;
@end