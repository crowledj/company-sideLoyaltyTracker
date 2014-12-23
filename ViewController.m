//
//  ViewController.m
//  GoldenScissors
//
//  Created by EventHorizon on 15/12/2014.
//  Copyright (c) 2014 EventHorizon. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    sqlite3 *db;
}
@end



@implementation ViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //open/create database
    int result = sqlite3_open([[self filePath] UTF8String],&db);
    
    if(result != SQLITE_OK)
        NSLog(@"Error : database not opened or created in %@ ",[self filePath]);
    
    //else printf("database NOT opened or created in \n");
    
    //create a table for this database
    [self createTableNamed: @"LoyaltyCounter" withField1: @"code" withField2: @"customerName" withField3: 1];
    
    
    for(int i=0;i<5;++i){
    //insert some records
        
        NSString *code = [[NSString alloc] initWithFormat:@"000%d",i];
        NSString *userName = [[NSString alloc] initWithFormat:@"user_%d",i];

        
        [self insertRecordIntoTableNamed: @"LoyaltyCounter" withField1:@"code" field1Value: code
                           andField2:@"customerName" field2Value: userName
                           andField3:1 field3Value:i];
    
        //Title.font= [UIFont boldSystemFontOfSize:16];
        course_1.titleLabel.font = [UIFont boldSystemFontOfSize:12.0f];
        userCode = [[UITextField alloc] initWithFrame:CGRectMake(10, 200, 300, 40)];
        
    
    }
        
    // Do any additional setup after loading the view from its nib.
}



/***   DATABASE TEST  ***/

/*
-(NSString *) filePath;
{
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSString *dbPath = [[[NSBundle mainBundle] resourcePath ]stringByAppendingPathComponent:@"NewLoyaltyCard.sql"];
    
    BOOL success = [fileMgr fileExistsAtPath:dbPath];
    
    
    NSLog(@"dbPath = %@",dbPath);
    
    if(success)
        return dbPath;
    
    //return a nil string as error
    dbPath=nil;
    
    return dbPath;
}
 */


-(NSString *) filePath;
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    
    NSString *documentsDir = [paths lastObject];
    
    //print check
    NSLog(@"dbPath = %@",paths);
    
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
-(void) createTableNamed:(NSString *) tableName withField1:(NSString *) field1 withField2:(NSString *) field2 withField3:(int) field3 {
    
    char *err;
    NSString *sql  = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' TEXT PRIMARY KEY, '%@' TEXT, '%d' INT);",tableName,field1,field2,field3];
    
    if(sqlite3_exec(db,[sql UTF8String],NULL,NULL,&err) != SQLITE_OK) {
        
        sqlite3_close(db);
        NSAssert(0,@"Table failed to create -- error msg = %s",err);
        
    }
    
}


//function to insert rows of customer data into this table
-(void) insertRecordIntoTableNamed: (NSString *) tableName
						withField1: (NSString *) field1 field1Value: (NSString *) field1Value
                        andField2:(NSString *) field2  field2Value: (NSString *) field2Value
                        andField3:(int) field3  field3Value: (int) field3Value
{
	
	
	NSString *sqlStr = [NSString stringWithFormat: @"INSERT OR REPLACE INTO '%@' ('%@', '%@','%d') VALUES (?,?,?)",
                        tableName, field1, field2, field3];
	const char *sql = [sqlStr UTF8String];
	sqlite3_stmt *statement;
    
	if (sqlite3_prepare_v2(db, sql, -1, &statement, nil) == SQLITE_OK) {
		sqlite3_bind_text(statement, 1, [field1Value UTF8String], -1, NULL);
		sqlite3_bind_text(statement, 2, [field2Value UTF8String], -1, NULL);
        sqlite3_bind_int(statement, 3, field3Value);  // not sure  could be error here  - syntax guessed !
	}
	
	if (sqlite3_step(statement) != SQLITE_DONE)
		NSAssert(0, @"Error updating table.");
	
	sqlite3_finalize(statement);
	
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
