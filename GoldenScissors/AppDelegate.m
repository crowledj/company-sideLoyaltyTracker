//
//  AppDelegate.m
//  GoldenScissors
//
//  Created by EventHorizon on 15/12/2014.
//  Copyright (c) 2014 EventHorizon. All rights reserved.
//


/*****   TO  DO  *****/

//1) - Put in alerts in view for bad inputs/errors
//2) - Pur in alerts for when actions/button preses complete successfully.



/*****    DONE    *****/

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
    
    //include dropbox functionality by first creating an acc. manager object.
    DBAccountManager *accountManager =
    [[DBAccountManager alloc] initWithAppKey:@"9x4p140n7dtp0fw" secret:@"mem8sz34kotof3m"];
    [DBAccountManager setSharedManager:accountManager];
    
    DBAccount *account = [[DBAccountManager sharedManager] linkedAccount];
    
    if (account) {
        DBFilesystem *filesystem = [[DBFilesystem alloc] initWithAccount:account];
        [DBFilesystem setSharedFilesystem:filesystem];
    }
    
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url
  sourceApplication:(NSString *)source annotation:(id)annotation {
    DBAccount *account = [[DBAccountManager sharedManager] handleOpenURL:url];
    if (account) {
        NSLog(@"App linked successfully!");
        return YES;
    }
    return NO;
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
    
    // create unique date to append onto Dropbox file
    //(this functionality needs to be modularized later !)
    
    NSString *uniqueDropboxFileName=@"debugNewFile";
    DBError *error = nil;
    uniqueDropboxFileName=[self createDateString:uniqueDropboxFileName];
    
    NSLog(@"** UNIQUE DROPBOX FILENAME ** = %@",uniqueDropboxFileName);
    
    //write to file in dropbox filesystem
    DBPath *newPath = [[DBPath root] childPath:uniqueDropboxFileName];
    DBFile *file = [[DBFilesystem sharedFilesystem] createFile:newPath error:nil];
    
    if(!file)
        NSLog(@"Error when creating file in Dropbox filesystem ,error description: %@", error);
    else
        NSLog(@"Success when creating file in Dropbox filesystem");
        
    [self extractDataFromDB : @"CustomerCard"];
    
    if(![file writeContentsOfFile:[self filePathBackUp] shouldSteal:NO error:nil])
        NSLog(@"Error when writing filein Dropbox, error description: %@", error);
    else
        NSLog(@"Successfully wrote to file %@ on dropbox", newPath);
    
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


-(NSString *) filePath;
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);    
    NSString *documentsDir = [paths lastObject];
    
    NSLog(@"filePath = %@",paths);
    
    return[documentsDir stringByAppendingPathComponent:@"NewLoyaltyCard.sql"];
}


-(NSString *) filePathBackUp
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDir = [paths lastObject];
    NSString *storageFile=@"backUp";

    //functional implementaion here instead
    storageFile=[self createDateString:storageFile];
    
    NSLog(@"back up filePath = %@",paths);
    NSLog(@"and file name located here is = ->%@<-",storageFile);
    
    return[documentsDir stringByAppendingPathComponent:storageFile];
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

-(void) extractDataFromDB : (NSString *) tableName
{
    NSString *insQL = [NSString stringWithFormat: @"select * from \"%@\" ",tableName];
    sqlite3_stmt *statement_1;
    const char *stmt = [insQL UTF8String];

    if(sqlite3_prepare_v2(db, stmt, -1, &statement_1, NULL) == SQLITE_OK) {
    
        while(sqlite3_step(statement_1) == SQLITE_ROW) {
            
            NSString *dbcodeID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement_1, 0)];
            NSString *dbNameText = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement_1, 1)];
            
            int count= (int )sqlite3_column_int(statement_1, 2);
            const char *codeString = [dbcodeID UTF8String];
            const char *nameString = [dbNameText UTF8String];
            
            //NSLog(@"in extract BD method : codeString = %s -- nameString= %s",codeString,nameString);
            
            fp = fopen ([[self filePathBackUp] UTF8String], "a");
            fprintf(fp, "%s %s %d \n", codeString,nameString,count);
            fclose(fp);
        }
    }
    
    sqlite3_finalize(statement_1);
}

-(NSString *) createDateString : (NSString *) inputString
{
    NSString *exp=nil;
    
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd-hh:mm:ss"];
    
    currDate=[DateFormatter stringFromDate:[NSDate date]];
    NSLog(@"currDate = %@",currDate);
    
    inputString=[inputString stringByAppendingString:currDate];
    inputString=[inputString stringByAppendingString:@".txt"];
    exp=inputString;
    
    return exp;
}


@end
