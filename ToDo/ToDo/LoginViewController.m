//
//  LoginViewController.m
//  ToDo
//
//  Created by Cubes School 1 on 3/30/16.
//  Copyright © 2016 Cubes School 1. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController()
@property (weak, nonatomic) IBOutlet UIImageView *usernameImageView;
@property (weak, nonatomic) IBOutlet UIImageView *passwordImageView;
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@end

@implementation LoginViewController

#pragma mark - Pribvate API

-(void)configureTextField:(UITextField *)textField {
    if (textField.placeholder.length > 0) {
        
        //UIColor *color = [UIColor colorWithRed:117.0/255.0
                    //                     green:<#(CGFloat)#>
                    //                      blue:<#(CGFloat)#>
                    //                     alpha:1.0;
                                                  
                                                  
                                                  
                            }
        NSDictionary *attributes = @{
                            NSFontAttributeName: [UIFont fontWithName:@"AvenirNext-Regular" size:14.0],
                            NSForegroundColorAttributeName: [UIColor whiteColor]
                            };
        
        
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWhithString:textField.placeholder attributes:attributes];
    }
    
}


#pragma mark - Actions

- (IBAction)forgotPasswordButtonTapped:(UIButton *)sender {
}

- (IBAction)signInButtonTapped:(UIButton *)sender {
}

- (IBAction)signUpButtonTapped:(UIButton *)sender {
    NSLog(@"Sign up...");
}


#pragma mark - View Lifecycle 

 -(void)viewDidLoad {
    [super viewDidLoad];
                }

@end