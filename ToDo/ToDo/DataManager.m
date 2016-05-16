//
//  DataManager.m
//  ToDo
//
//  Created by Cubes School 1 on 5/11/16.
//  Copyright © 2016 Cubes School 1. All rights reserved.
//

#import "DataManager.h"
#import "AppDelegate.h"
#import "Task.h"
#import <MapKit/MapKit.h>

@interface DataManager()
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@end

@implementation DataManager

#pragma mark - Properties 

- (void)setUserLocation:(CLLocation *)userLocation {
    _userLocation = userLocation;
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder reverseGeocodeLocation:userLocation
                   completionHandler:^(NSArray<CLPlacemark *> * placemarks, NSError *error) {
                       
                       if (error) {
                           NSLog(@"CLGeocoder error: %@", [error localizedDescription]);
                       }
                       
                       if (placemarks.count > 0) {
                           CLPlacemark *placemark = [placemarks firstObject];
                           
                           self.userLocality = placemark.locality;
                           
                           [[NSNotificationCenter defaultCenter] postNotificationName:CITY_CHANGED object:nil];
                       }
    }];
}

- (NSManagedObjectContext *)managedObjectContext {
    if (!_managedObjectContext) {
        AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
        _managedObjectContext = appDelegate.managedObjectContext;
    }
    
    return _managedObjectContext;
}

#pragma mark - Public API

+ (instancetype)sharedInstance {
    static DataManager *sharedManager;
    
    @synchronized (self) {
        if (sharedManager == nil) {
            sharedManager = [[DataManager alloc] init];
        }
    }
    
    return sharedManager;
}

- (NSMutableArray *)fetchEntity:(NSString *)entityName
                     withFilter:(NSString *)filter
                    withSortasc:(BOOL) sortAscending
                         forKey:(NSString *)sortKey {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.managedObjectContext];
                                              [fetchRequest setEntity:entityDescription];
    
    //Sorting
    if (sortKey != nil) {
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortKey ascending:sortAscending];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
        [fetchRequest setSortDescriptors:sortDescriptors];
    }
    
    //Filtering
    if (filter != nil) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:filter];
        [fetchRequest setPredicate:predicate];
    }
    
    NSError *error;
    //NSMutableArray *resultsArray = [[self.managedObjectContext executeFetchRequest:fetchRequest error:&error] mutableCopy];
    
    NSArray *array = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    NSMutableArray *resultsArray = [NSMutableArray arrayWithArray:array];
    
    if (resultsArray == nil) NSLog(@"Error fetching %@(s).", entityName);
    
    return resultsArray;
    
}


- (void)deleteObjectInDataBase:(NSManagedObject *)object {
    [self.managedObjectContext deleteObject:object];
    [self saveToDatabese];
    
}

- (void)updateObject:(NSManagedObject *)object {
    NSError *error = nil;
    if ([object.managedObjectContext hasChanges] && ![object.managedObjectContext save:&error]) {
        NSLog( @"Unresolved error %@, %@", [error localizedDescription], [error userInfo]);
        abort();
    }
}

- (void)logObject:(NSManagedObject *)object {
    NSEntityDescription *decription = [object entity];
    NSDictionary *attributes = [decription attributesByName];
    
    for (NSString *attribute in attributes) {
        NSLog(@"%@ = %@", attribute, [object valueForKey:attribute]);
    }
}

- (CGFloat)numberOfTaskPerTaskGroup: (TaskGroup)group {
    NSArray *tasksArray = [self fetchEntity:NSStringFromClass([Task class])
                                 withFilter:[NSString stringWithFormat:@" group = %ld", group]
                                withSortasc:NO
                                     forKey:nil];
    
    return tasksArray.count;
    
}


- (void)saveTaskWithTitle:(NSString *)title
              description:(NSString *)description
                    group:(NSInteger)group {
    Task *task = (Task *) [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([Task class]) inManagedObjectContext:self.managedObjectContext];
    task.heading = title;
    task.desc = description;
    
    if (self.userLocation) {
        task.latitude = [NSNumber numberWithFloat:self.userLocation.coordinate.latitude];
        task.longitude = [NSNumber numberWithFloat:self.userLocation.coordinate.longitude];
    }
    
    task.date = [NSDate date];
    task.group = [NSNumber numberWithInteger:group];
    
    [self saveToDatabese];
    
}


#pragma mark - Private API

- (void)saveToDatabese {
      NSError *error = nil;
        if ([self.managedObjectContext hasChanges] && ![self.managedObjectContext save:&error]) {
            NSLog( @"Unresolved error %@, %@", [error localizedDescription], [error userInfo]);
            abort();
        }
}

@end