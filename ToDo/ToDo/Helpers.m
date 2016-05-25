//
//  Helpers.m
//  ToDo
//
//  Created by Cubes School 1 on 5/23/16.
//  Copyright © 2016 Cubes School 1. All rights reserved.
//

#import "Helpers.h"

@implementation Helpers

+(BOOL)isEmailValid:(NSString *)email {
    NSString *emailRegex = @"";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL isValid = [emailTest evaluateWithObject:email];
    
    return isValid;
}

+(BOOL)isLoggedIn {
    return [[NSUserDefaults standardUserDefaults] boolForKey:LOGGED_IN];
}

+ (UIColor *)colorForTaskGroup:(TaskGroup)group {
    UIColor *color = nil;
    
    switch (group) {
        case COMPLETED_TASK_GROUP:
            color = kTurquoiseColor;
            break;
        case NOT_COMPLETED_TASK_GROUP:
            color = kOrangeColor;
            break;
        case IN_PROGRESS_TASK_GROUP:
            color = kPurpleColor;
            break;
    }
    
    return color;
}

+ (BOOL)isMorning {
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:[NSDate date]];
    
    NSInteger hour = components.hour;
    if (hour > 12) {
        return NO;
    }
    
    return YES;
}

@end