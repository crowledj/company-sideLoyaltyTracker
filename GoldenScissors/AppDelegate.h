//
//  AppDelegate.h
//  GoldenScissors
//
//  Created by EventHorizon on 15/12/2014.
//  Copyright (c) 2014 EventHorizon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@class TableViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
        sqlite3 *db;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navController;
@property (strong, nonatomic) TableViewController *vController;

@end
