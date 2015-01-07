//
//  AppDelegate.m
//  GoldenScissors
//
//  Created by EventHorizon on 15/12/2014.
//  Copyright (c) 2014 EventHorizon. All rights reserved.
//

#import "AppDelegate.h"
#import "TableViewController.h"

@implementation AppDelegate
@synthesize navController,vController;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    vController = [[TableViewController alloc] initWithNibName:@"TableViewController" bundle:nil];
    navController = [[UINavigationController alloc] initWithRootViewController:vController];
    
    self.window.rootViewController = navController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    //open/create database
    int result = sqlite3_open([[self filePath] UTF8String],&db);
    
    if(result != SQLITE_OK)
        NSLog(@"Error : database not opened or created in %@ ",[self filePath]);
    
    //create a table for this database
    [self createTableNamed: @"CustomerCard" withField1: @"code" withField2: @"customerName" withField3: @"num"];
     
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



/***   DATABASE TEST  ***/


-(NSString *) filePath;
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);    
    NSString *documentsDir = [paths lastObject];
    
    
    NSLog(@"filePath = %@",paths);
    
  
    return[documentsDir stringByAppendingPathComponent:@"NewLoyaltyCard.sql"];
}



//function to open the database
-(void)openDB
{
    //create first database
    if(sqlite3_open( [[self filePath] UTF8String], &db) != SQLITE_OK )
    {
        sqlite3_close(db);
        NSAssert(0,@"Database one failed to open.");
    }
}


//create a Loyalty card customer table in the database
-(void) createTableNamed:(NSString *) tableName withField1:(NSString *) field1 withField2:(NSString *) field2 withField3:(NSString *) field3 {
    
    char *err;
    NSString *sql  = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' TEXT PRIMARY KEY, '%@' TEXT, '%@' INT);",tableName,field1,field2,field3];
    
    if(sqlite3_exec(db,[sql UTF8String],NULL,NULL,&err) != SQLITE_OK) {
        
        sqlite3_close(db);
        NSAssert(0,@"Table failed to create -- error msg = %s",err);
        
    }
    
}



@end
