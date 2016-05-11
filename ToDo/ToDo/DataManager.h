//
//  DataManager.h
//  ToDo
//
//  Created by Cubes School 1 on 5/11/16.
//  Copyright © 2016 Cubes School 1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreData/CoreData.h>

@interface DataManager : NSObject
@property (strong, nonatomic) CLLocation *userLocation;
@property (strong, nonatomic) NSString *userLocality;

+ (instancetype)sharedInstance;
- (NSMutableArray *)fetchEntity:(NSString *)entityName
                     withFilter:(NSString *)filter
                    withSortasc:(BOOL) sortAscending
                         forKey:(NSString *)sortKey;
- (void)deleteObjectInDataBase:(NSManagedObject *)object;
- (void)updateObject:(NSManagedObject *)object;
- (void)logObject:(NSManagedObject *)object;
- (CGFloat)numberOfTaskPerTaskGroup: (TaskGroup)group;
- (void)saveTaskWithTitle:(NSString *)title
              description:(NSString *)description
                    group:(NSInteger)group;

@end