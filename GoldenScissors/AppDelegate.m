//
//  AppDelegate.m
//  GoldenScissors
//
//  Created by EventHorizon on 15/12/2014.
//  Copyright (c) 2014 EventHorizon. All rights reserved.
//

#import "AppDelegate.h"
#import "TableViewController.h"
#import "APXML.h"
#import "MyDocument.h"

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
    
     NSLog(@"**** in entering background app. function ****");
    [self backupToXMLonCloud];
    
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
    
    NSLog(@"**** in terminating app. function ****");
    
    
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


- (void)loadData:(NSMetadataQuery *)queryData
{
    
    
    for (NSMetadataItem *item in [queryData results])
    {
        NSString *filename = [item valueForAttribute:NSMetadataItemDisplayNameKey];
        NSNumber *filesize = [item valueForAttribute:NSMetadataItemFSSizeKey];
        NSDate *updated = [item valueForAttribute:NSMetadataItemFSContentChangeDateKey];
        NSLog(@"%@ (%@ bytes, updated %@) ", filename, filesize, updated);
        
        NSURL *url = [item valueForAttribute:NSMetadataItemURLKey];
        MyDocument *doc = [[MyDocument alloc] initWithFileURL:url];
        if([filename isEqualToString:@"Properties"])
        {
            [doc openWithCompletionHandler:^(BOOL success) {
                if (success) {
                    NSLog(@"XML: Success to open from iCloud");
                    NSData *file = [NSData dataWithContentsOfURL:url];
                    //NSString *xmlFile = [[NSString alloc] initWithData:file encoding:NSASCIIStringEncoding];
                    //NSLog(@"%@",xmlFile);
                    
                    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:file];
                    [parser setDelegate:self];
                    [parser parse];
                    //We hold here until the parser finishes execution
                  
                }
                else
                {
                    NSLog(@"XML: failed to open from iCloud");
                }
            }]; 
        }
    }
}



-(void) backupToXMLonCloud
{
    // create the document with it’s root element
    APDocument *doc = [[APDocument alloc] initWithRootElement:[APElement elementWithName:@"CustomerCard"]];
    APElement *rootElement = [doc rootElement]; // retrieves same element we created the line above
    
    NSMutableArray *addrList = [[NSMutableArray alloc] init];
    NSString *select_query;
    const char *select_stmt;
    sqlite3_stmt *compiled_stmt;
    if (sqlite3_open([[self filePath] UTF8String], &db) == SQLITE_OK)
    {
        select_query = [NSString stringWithFormat:@"SELECT * FROM CustomerCard"];
        select_stmt = [select_query UTF8String];
        if(sqlite3_prepare_v2(db, select_stmt, -1, &compiled_stmt, NULL) == SQLITE_OK)
        {
            while(sqlite3_step(compiled_stmt) == SQLITE_ROW)
            {
                NSString *addr = [NSString stringWithFormat:@"%@",[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiled_stmt,0)]];
                addr = [NSString stringWithFormat:@"%@#%@",addr,[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiled_stmt,1)]];
                addr = [NSString stringWithFormat:@"%@#%@",addr,[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiled_stmt,2)]];
                
                NSLog(@" mutable array frm select * = ->%@<-",addr);
                [addrList addObject:addr];
            }
            sqlite3_finalize(compiled_stmt);
        }
        else
        {
            NSLog(@"Error while creating detail view statement. '%s'", sqlite3_errmsg(db));
        }
        
    }
    
    for(int i =0 ; i < [addrList count]; i++)
    {
        NSArray *addr = [[NSArray alloc] initWithArray:[[addrList objectAtIndex:i] componentsSeparatedByString:@"#"]];
        
        APElement *property = [APElement elementWithName:@"Customers"];
        [property addAttributeNamed:@"id" withValue:[addr objectAtIndex:0]];
        [property addAttributeNamed:@"name" withValue:[addr objectAtIndex:1]];
        [property addAttributeNamed:@"counter" withValue:[addr objectAtIndex:2]];

        [rootElement addChild:property];
        
    
    }
    sqlite3_close(db);
    
    
    NSString *prettyXML = [doc prettyXML];
    NSLog(@"\n\nstring is ->%@<- ",prettyXML);
    
    
    //***** PARSE XML FILE *****
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Customers.xml" ];
    
    NSLog(@"got to 'dataWithBytes' thingy ");
    
    NSData *file = [NSData dataWithBytes:[prettyXML UTF8String] length:strlen([prettyXML UTF8String])];
  
    NSLog(@"got PAST 'dataWithBytes' thingy ");
    
    [file writeToFile:path atomically:YES];
    
    
    NSString *fileName = [NSString stringWithFormat:@"Customers.xml "];
    NSURL *ubiq = [[NSFileManager defaultManager]URLForUbiquityContainerIdentifier:nil];
    NSURL *ubiquitousPackage = [[ubiq URLByAppendingPathComponent:@"Documents"]  URLByAppendingPathComponent:fileName];
    
    
    MyDocument *mydoc = [[MyDocument alloc] initWithFileURL:ubiquitousPackage];
    mydoc.xmlContent = prettyXML;
    [mydoc saveToURL:[mydoc fileURL]forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success)
     {
         
         if (success)
         {
             NSLog(@"XML: Synced with icloud");
             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"iCloud Syncing" message:@"Successfully synced with iCloud." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
             [alert show];
         }
         else
             NSLog(@"XML: Syncing FAILED with icloud");
         
         
     }];
    
}
@end
