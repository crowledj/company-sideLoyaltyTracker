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

//Back up of original 'applicationDidEnterBackground:(UIApplication *)application' code
/*
 
 //NSLog(@"created file in dropbox");
 
 
 //write to file in dropbox filesystem
 
 //DBPath *newPath = [[DBPath root] childPath:@"NewFile.sql"];
 //DBFile *file = [[DBFilesystem sharedFilesystem] createFile:newPath error:nil];
 //[file writeString:@"Hello World!" error:nil];
 
 //[file writeContentsOfFile:[self filePath] shouldSteal:NO error:nil];
 

//NSLog(@"wrote to file on dropbox");

//NSString *dropboxFile=@"NewBackupFile.txt";

//NSMutableString *dropboxFile=@"NewBackupFile.txt";

NSString * string1 = @"NewBackupFile_";
NSMutableString * string2 = [string1 mutableCopy];

NSLog(@"in background app currDate = %@",currDate);

//[dropboxFile stringByAppendingString:currDate];

[string2 appendString:testString];
[string2 appendString:@".txt"];

NSLog(@"about to write to file on dropbox-- unique dropbox fileString is %@",string2);

//test onpine code :



//END test onpine code :

DBPath *newPath_1 = [[DBPath root] childPath:string1];
DBError *error = nil;
DBError *error1= nil;
DBFile *destFile = [[DBFilesystem sharedFilesystem] createFile:newPath_1 error:&error1];
[self extractDataFromDB : @"CustomerCard"];

if(destFile) {
    NSData *fileData = [NSData dataWithContentsOfFile:[self filePathBackUp]];
    if (![destFile writeData:fileData error:&error]) {
        NSLog(@"Error when writing file %@ in Dropbox, error description: %@", newPath_1, error);
    }
    [destFile close];
}  else {
    NSLog(@"Error when creating file %@ in Dropbox, error description: %@", newPath_1, error1.description);
}




 if(newPath_1)
 NSLog(@" :) in created initial file path in dropbox loop ! :)");
 
 else
 NSLog(@" NOT in created initial file path in dropbox loop ! :(");
 */

//temp remove as test for error string below.
/*DBFile *file_1 = [[DBFilesystem sharedFilesystem] createFile:newPath_1 error:nil];*/

//create and write to a local file

///remove temporrily es test.
//[self extractDataFromDB : @"CustomerCard"];


//rempve as test this code-block :

/*
 BOOL writeResult;
 //write the contents of this file
 
 if( !([[DBFilesystem sharedFilesystem] createFile:newPath_1 error:&error]) ){
 
 NSLog(@" NOT in writing to file on dropbox loop ?! :(");
 NSLog(@"Error when writing filein Dropbox, error description: %@", error);
 
 }
 
 else{
 
 NSLog(@" :) in writing to file on dropbox loop ! :)");
 //writeResult=[file_1 writeContentsOfFile:[self filePathBackUp] shouldSteal:NO error:nil];
 
 }
 
 NSLog(@"past backing up DB to file ! and 'writeContentsOfFile' = %s",writeResult ? "true" : "false");

 */

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    // create unique date to append onto Dropbox file
    //(this functionality needs to be modularized later !)
    
    NSString *basicDBoxFileName=@"debugNewFile";
    
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd-hh:mm:ss"];
    
    NSString *currentDate=[DateFormatter stringFromDate:[NSDate date]];
    NSLog(@"In 'applicationDidEnterBackground' method -- currDate = %@",currentDate);
    
    NSString *uniqueDropboxFileName=[basicDBoxFileName stringByAppendingString:currentDate];
    uniqueDropboxFileName=[uniqueDropboxFileName stringByAppendingString:@".txt"];
    NSLog(@"** UNIQUE DROPBOX FILENAME ** = %@",uniqueDropboxFileName);
    
    //write to file in dropbox filesystem
    DBPath *newPath = [[DBPath root] childPath:uniqueDropboxFileName];
    DBFile *file = [[DBFilesystem sharedFilesystem] createFile:newPath error:nil];
    //[file writeString:@"Hello World!" error:nil];
    
    NSLog(@"created file in dropbox");
    
    [self extractDataFromDB : @"CustomerCard"];
    
    [file writeContentsOfFile:[self filePathBackUp] shouldSteal:NO error:nil];
    
    NSLog(@"wrote to file on dropbox");
    
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


-(NSString *) filePathBackUp
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDir = [paths lastObject];
    
    NSString *storageFile=@"backUp";
    
    NSLog(@"at date attempt ! ");
    
    NSDateFormatter *DateFormatter=[[NSDateFormatter alloc] init];
    [DateFormatter setDateFormat:@"yyyy-MM-dd-hh:mm:ss"];

    currDate=[DateFormatter stringFromDate:[NSDate date]];
    NSLog(@"currDate = %@",currDate);
    
    storageFile=[storageFile stringByAppendingString:currDate];
    storageFile=[storageFile stringByAppendingString:@".txt"];
    
    
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
//***************************     TEST    **************************************

    NSString *insQL = [NSString stringWithFormat:
                   @"select * from \"%@\" ",tableName];
    sqlite3_stmt *statement_1;
    const char *stmt = [insQL UTF8String];
    //char *errMsg = 0;

//if(sqlite3_exec(db, stmt, NULL, NULL,&zErrMsg)

    //if(sqlite3_exec(db, stmt,NULL, NULL,&errMsg) == SQLITE_OK) {
    if(sqlite3_prepare_v2(db, stmt, -1, &statement_1, NULL) == SQLITE_OK) {
    
        while(sqlite3_step(statement_1) == SQLITE_ROW) {
            
            NSString *dbcodeID = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement_1, 0)];
            NSString *dbNameText = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement_1, 1)];
            int count= (int )sqlite3_column_int(statement_1, 2);
            
            
           // fprintf([[self filePathBackUp] UTF8String], "w+");
            const char *codeString = [dbcodeID UTF8String];
            const char *nameString = [dbNameText UTF8String];
            
            NSLog(@"in extract BD method : codeString = %s -- nameString= %s",codeString,nameString);
            
            
            fp = fopen ([[self filePathBackUp] UTF8String], "a");
            fprintf(fp, "%s %s %d \n", codeString,nameString,count);
            
            fclose(fp);
            
        }
    }

    sqlite3_finalize(statement_1);
    
}

@end
