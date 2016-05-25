//
//  HomeViewController.m
//  ToDo
//
//  Created by Cubes School 1 on 4/8/16.
//  Copyright © 2016 Cubes School 1. All rights reserved.
//

#import "HomeViewController.h"
#import "TaskTableViewCell.h"
#import "TaskDetailsViewController.h"
#import "UIViewController+Utilities.h"
#import "WebViewController.h"
#import "DataManager.h"
#import "Task.h"
#import "MenuView.h"
#import "Helpers.h"

@interface HomeViewController() <UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MenuViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *badgeImageView;
@property (weak, nonatomic) IBOutlet UILabel *badgeLabel;
@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (weak, nonatomic) IBOutlet MenuView *menuView;
@property (strong, nonatomic) NSMutableArray *itemsArray;
@property (strong, nonatomic) Task *selectedTask;
@end

@implementation HomeViewController

#pragma mark - Properties

-(NSMutableArray *)itemsArray {
    return [[DataManager sharedInstance]  fetchEntity:NSStringFromClass([Task class])
                                           withFilter:nil
                                          withSortasc:YES
                                              forKey:@"date"];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

#pragma mark - Private API 

-(void)configureBadge {
    self.badgeImageView.alpha = (self.itemsArray.count == 0) ? ZERO_VALUE : 1.0;
    self.badgeLabel.alpha = (self.itemsArray.count == 0) ? ZERO_VALUE : 1.0;
    self.badgeLabel.text = [NSString stringWithFormat:@"%ld", self.itemsArray.count];

}

-(void)configureProfileImage {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(pickImage)];
    self.profileImageView.userInteractionEnabled = YES;
    tap.numberOfTapsRequired = 1;
    [self.profileImageView addGestureRecognizer:tap];
    
    self.profileImageView.clipsToBounds = YES;
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.width/2;
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:USER_IMAGE]) {
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:USER_IMAGE];
        
        self.profileImageView.image = [[UIImage alloc] initWithData:data];
    }
}

-(void)configureWelcome {
    if ([Helpers isMorning]) {
        self.welcomeLabel.text = @"Good Morning!";
    } else {
        self.welcomeLabel.text = @"Good Afternnon!";
    }
}

#pragma mark - Segue Management

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"AboutSegue"]) {
        WebViewController *webViewController = (WebViewController *)segue.destinationViewController;
        webViewController.urlString = CUBES_URL;
    }
    
    if ([segue.identifier isEqualToString:@"TaskDetailsSegue"]) {
        TaskDetailsViewController *taskDetailsViewController = (TaskDetailsViewController *)segue.destinationViewController;
        taskDetailsViewController.task = self.selectedTask;
    }
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    //Task *task =[self.itemsArray objectAtIndex:indexPath.row];
    //cell.task = task;
    
    cell.task = self.itemsArray[indexPath.row];
    
    return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Task *task = [self.itemsArray objectAtIndex:indexPath.row];
        [[DataManager sharedInstance] deleteObjectInDataBase:task];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [tableView reloadData];
        [self configureBadge];
    }
}


#pragma mark - UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Task *task = [self.itemsArray objectAtIndex:indexPath.row];
    self.selectedTask = task;
    [self performSegueWithIdentifier:@"TaskDetailsSegue" sender:nil];
}


- (void)pickImage {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Choose source:" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Photo Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
        pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerController.delegate = self;
        pickerController.allowsEditing = YES;
        [self presentViewController:pickerController animated:YES completion:nil];
        
        
    }]];
    
    if (![UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear] || [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
        [alertController addAction:[UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
            pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            pickerController.delegate = self;
            pickerController.allowsEditing = YES;
            [self presentViewController:pickerController animated:YES completion:nil];
            
        }]];

    }
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.menuView.delegate = self;
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self configureProfileImage];
    [self configureBadge];
    [self configureWelcome];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    [self configureBadge];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"WALKTHROUGHT_PRESENTED"]) {
        [self performSegueWithIdentifier:@"WalkthroughtSegue" sender:self];
    }
}


#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (!image) {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    self.profileImageView.image = image;
    
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:USER_IMAGE];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //After picking image, dismiss image
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark - MenuViewDelegate

- (void)menuViewOptionTapped:(MenuOption)option {
    switch (option) {
        case TASK_DETAILS_MENU_OPTION: {
            self.selectedTask = nil;
            [self performSegueWithIdentifier:@"TaskDetailsSegue" sender:nil]; }
            break;
        case ABOUT_MENU_OPTION: {
            [self performSegueWithIdentifier:@"AboutSegue" sender:nil]; }
            break;
        case STATISTICS_MENU_OPTION: {
            [self performSegueWithIdentifier:@"StatisticsSegue" sender:nil]; }
            break;
        case WALKTHROUGH_MENU_OPTION: {
            [self performSegueWithIdentifier:@"WalkthroughSegue" sender:nil]; }
            break;
    }
}


@end